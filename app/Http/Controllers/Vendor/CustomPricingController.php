<?php

namespace App\Http\Controllers\Vendor;

use App\Http\Controllers\Controller;
use App\Http\Helpers\VendorPermissionHelper;
use App\Models\BookingHour;
use App\Models\CustomPricing;
use App\Models\Hotel;
use App\Models\HourlyRoomPrice;
use App\Models\Language;
use App\Models\HotelContent; // Add this import
use App\Models\Room;
use App\Models\RoomContent;
use Auth;
use Illuminate\Http\Request;

class CustomPricingController extends Controller
{
    public function index(Request $request)
    {
        $hotel_id = null;
        if (request()->filled('hotel_id')) {
            $hotel_id = $request->hotel_id;
            if ($hotel_id == "ALL") {
                $hotel_id = null;
            }
        }
        $language = Language::where('code', $request->language)->firstOrFail();
        $title = $request->input('title');
    
        $current_package = VendorPermissionHelper::packagePermission(Auth::guard('vendor')->user()->id);
        $hotels = Hotel::join('hotel_contents', 'hotels.id', '=', 'hotel_contents.hotel_id')
            ->where('hotels.vendor_id', Auth::guard('vendor')->user()->id)
            ->where('hotel_contents.language_id', $language->id)
            ->select('hotels.id', 'hotel_contents.title', 'hotel_contents.category_id')
            ->get()
            ->map(function($hotel) use ($language) {
                if ($hotel->category_id) {
                    $category = HotelContent::where('language_id', $language->id)
                        ->where('category_id', $hotel->category_id)
                        ->first();
                    $hotel->category_name = $category ? $category->name : null;
                } else {
                    $hotel->category_name = null;
                }
                return $hotel;
            });
        $room_contents = RoomContent::where('language_id', $language->id)
            ->whereHas('room', function($query) {
                $query->where('vendor_id', Auth::guard('vendor')->user()->id);
            })
            ->when($title, function($query) use ($title) {
                return $query->where('title', 'like', '%' . $title . '%');
            })
            ->get();
            $hourlyPrices = BookingHour::with(['room', 'hotel'])
            ->when($hotel_id, function($query) use ($hotel_id) {
                return $query->where('hotel_id', $hotel_id);
            })
            ->get();
        $rooms = Room::with(['room_content' => function($query) use ($language) {
                $query->where('language_id', $language->id);
            }])
            ->where('vendor_id', Auth::guard('vendor')->user()->id)
            ->get();
        $customPricings = CustomPricing::with(['bookingHour'])->join('hotel_contents', 'custom_pricings.hotel_id', '=', 'hotel_contents.hotel_id')
            ->leftJoin('room_contents', 'custom_pricings.room_id', '=', 'room_contents.room_id')
            ->where('custom_pricings.vendor_id', Auth::guard('vendor')->user()->id)
            ->where('hotel_contents.language_id', $language->id)
            ->where('room_contents.language_id', $language->id)
            ->when($hotel_id, function ($query) use ($hotel_id) {
                return $query->where('custom_pricings.hotel_id', $hotel_id);
            })
            ->when($title, function($query) use ($title) {
                return $query->where('room_contents.title', 'like', '%' . $title . '%');
            })
            ->select(
                'custom_pricings.id',
                'custom_pricings.date',
                'custom_pricings.price',
                'custom_pricings.room_id',
                'hotel_contents.title as hotel_title',
                'custom_pricings.booking_hours_id',
                'room_contents.title as room_title',
                'hotel_contents.slug',
                'hotel_contents.hotel_id',
                'hotel_contents.category_id'
            )
            ->get();
    
        return view('vendors.room.custompricing', compact(
            'customPricings',
            'hotels',
            'rooms',
            'room_contents',
            'language',
            'title',
            'hourlyPrices'
        ));
    }
    public function store(Request $request)
    {
        $request->validate([
            'hotel_id' => 'required|exists:hotels,id',
            'room_id' => 'required|exists:rooms,id',
            'date' => 'required|date',
            'prices' => 'required|array',
            'prices.*' => 'nullable|numeric|min:0',
        ]);
    
        foreach ($request->prices as $hourId => $price) {
            if (!empty($price)) {
                $existing = CustomPricing::where('hotel_id', $request->hotel_id)
                    ->where('room_id', $request->room_id)
                    ->where('date', $request->date)
                    ->where('booking_hours_id', $hourId)
                    ->first();
    
                if ($existing) {
                    $existing->update([
                        'price' => $price,
                        'vendor_id' => Auth::guard('vendor')->user()->id
                    ]);
                } else {
                    CustomPricing::create([
                        'hotel_id' => $request->hotel_id,
                        'room_id' => $request->room_id,
                        'date' => $request->date,
                        'booking_hours_id' => $hourId,
                        'price' => $price,
                        'vendor_id' => Auth::guard('vendor')->user()->id
                    ]);
                }
            }
        }
    
        return redirect()->back()->with('success', 'Custom Pricing Added successfully');
    }
    
    public function edit($id)
    {
        $customPricing = CustomPricing::findOrFail($id);
        $hotels = Hotel::with(['hotel_contents'])->get();
        $room_contents =RoomContent::all();
        $hourlyPrices = BookingHour::all();
        return view('vendors.room.customedit', compact('customPricing', 'hotels', 'room_contents', 'hourlyPrices'));
    }
    
    public function update(Request $request, $id)
    {
        $request->validate([
            'hotel_id' => 'required',
            'room_id' => 'required',
            'date' => 'required|date',
            'booking_hours_id' => 'required',
            'price' => 'required|numeric|min:0'
        ]);
    
        $customPricing = CustomPricing::findOrFail($id);
        $customPricing->update([
            'hotel_id' => $request->hotel_id,
            'room_id' => $request->room_id,
            'date' => $request->date,
            'booking_hours_id' => $request->booking_hours_id,
            'price' => $request->price
        ]);
    
        return redirect()->back()->with('success', 'Custom Pricing Updated Successfully!');
    }
    public function destroySingle($id)
    {
        $pricing = CustomPricing::where('vendor_id', Auth::guard('vendor')->user()->id)->findOrFail($id);
        $pricing->delete();
        return redirect()->back()->with('success', 'Custom Pricing deleted successfully');
    }
    
}