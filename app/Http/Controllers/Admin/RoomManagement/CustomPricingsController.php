<?php

namespace App\Http\Controllers\Admin\RoomManagement;
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

class CustomPricingsController extends Controller
{
    public function index(Request $request)
    {
        $hotel_id = $request->filled('hotel_id') && $request->hotel_id !== 'ALL'
            ? $request->hotel_id
            : null;
    
        $language = Language::where('code', $request->language)->firstOrFail();
        $title = $request->input('title');
    
        $hotels = Hotel::join('hotel_contents', 'hotels.id', '=', 'hotel_contents.hotel_id')
            ->where('hotel_contents.language_id', $language->id)
            ->select('hotels.id', 'hotel_contents.title', 'hotel_contents.category_id')
            ->get();
    
        $categoryIds = $hotels->pluck('category_id')->filter()->unique();
        $categories = HotelContent::whereIn('category_id', $categoryIds)
            ->where('language_id', $language->id)
            ->get()
            ->keyBy('category_id');
    
        $hotels->transform(function ($hotel) use ($categories) {
            $hotel->category_name = $categories[$hotel->category_id]->name ?? null;
            return $hotel;
        });
    
        $room_contents = RoomContent::where('language_id', $language->id)
            ->when($title, function ($query) use ($title) {
                $query->where('title', 'like', '%' . $title . '%');
            })
            ->get();
    
        $hourlyPrices = BookingHour::with(['room', 'hotel'])
            ->when($hotel_id, function ($query) use ($hotel_id) {
                $query->where('hotel_id', $hotel_id);
            })
            ->get();
    
        $rooms = Room::with(['room_content' => function ($query) use ($language) {
                $query->where('language_id', $language->id);
            }])
            ->get();
    
        $customPricings = CustomPricing::with(['bookingHour'])
            ->join('hotel_contents', 'custom_pricings.hotel_id', '=', 'hotel_contents.hotel_id')
            ->leftJoin('room_contents', 'custom_pricings.room_id', '=', 'room_contents.room_id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('room_contents.language_id', $language->id)
            ->when($hotel_id, function ($query) use ($hotel_id) {
                $query->where('custom_pricings.hotel_id', $hotel_id);
            })
            ->when($title, function ($query) use ($title) {
                $query->where('room_contents.title', 'like', '%' . $title . '%');
            })
            ->select(
                'custom_pricings.id',
                'custom_pricings.date',
                'custom_pricings.price',
                'custom_pricings.room_id',
                'custom_pricings.vendor_id',
                'hotel_contents.title as hotel_title',
                'custom_pricings.booking_hours_id',
                'room_contents.title as room_title',
                'hotel_contents.slug',
                'hotel_contents.hotel_id',
                'hotel_contents.category_id'
            )
            ->get();
    
        return view('admin.room.custompricing', compact(
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
    
        // Get the room to determine the vendor_id
        $room = Room::findOrFail($request->room_id);
        $vendorId = $room->vendor_id;
    
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
                        'vendor_id' => $vendorId
                    ]);
                } else {
                    CustomPricing::create([
                        'hotel_id' => $request->hotel_id,
                        'room_id' => $request->room_id,
                        'date' => $request->date,
                        'booking_hours_id' => $hourId,
                        'price' => $price,
                        'vendor_id' => $vendorId
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
    return view('admin.room.customedit', compact('customPricing', 'hotels', 'room_contents', 'hourlyPrices'));
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

    // Get the room to determine the vendor_id
    $room = Room::findOrFail($request->room_id);
    $vendorId = $room->vendor_id;

    $customPricing = CustomPricing::findOrFail($id);
    $customPricing->update([
        'hotel_id' => $request->hotel_id,
        'room_id' => $request->room_id,
        'date' => $request->date,
        'booking_hours_id' => $request->booking_hours_id,
        'price' => $request->price,
        'vendor_id' => $vendorId
    ]);

    return redirect()->back()->with('success', 'Custom Pricing Updated Successfully!');
}

public function destroySingle($id)
{
    $pricing = CustomPricing::findOrFail($id);
    $pricing->delete();

    return redirect()->back()->with('success', 'Custom Pricing deleted successfully');
}

}
