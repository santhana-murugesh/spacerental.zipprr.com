<?php

namespace App\Http\Controllers\Vendor;

use App\Http\Controllers\Controller;
use App\Http\Helpers\VendorPermissionHelper;
use App\Models\Holiday;
use App\Models\Hotel;
use App\Models\Language;
use App\Models\Room;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;

class HolidayController extends Controller
{
    public function index(Request $request)
    {
        $hotel_id = null;
        $room_id = null;
        if (request()->filled('hotel_id')) {
            $hotel_id = $request->hotel_id;
            if ($hotel_id == "ALL") {
                $hotel_id = null;
            }
        }
        if (request()->filled('room_id')) {
            $room_id = $request->room_id;
            if ($room_id == "ALL") {
                $room_id = null;
            }
        }
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $current_package = VendorPermissionHelper::packagePermission(Auth::guard('vendor')->user()->id);

        $hotels = Hotel::join('hotel_contents', 'hotels.id', '=', 'hotel_contents.hotel_id')
            ->where('hotels.vendor_id', Auth::guard('vendor')->user()->id)
            ->where('hotel_contents.language_id', $language->id)
            ->select('hotels.id', 'hotel_contents.title')
            ->get();

        $rooms = Room::join('room_contents', 'rooms.id', '=', 'room_contents.room_id')
            ->where('rooms.vendor_id', Auth::guard('vendor')->user()->id)
            ->where('room_contents.language_id', $language->id)
            ->select('rooms.id', 'room_contents.title')
            ->get();

        $globalHoliday = Holiday::join('hotel_contents', 'holidays.hotel_id', '=', 'hotel_contents.hotel_id')
            ->leftJoin('room_contents', 'holidays.room_id', '=', 'room_contents.room_id')
            ->where('holidays.vendor_id', Auth::guard('vendor')->user()->id)
            ->where('hotel_contents.language_id', $language->id)
            ->when($hotel_id, function ($query) use ($hotel_id) {
                return $query->where('holidays.hotel_id', $hotel_id);
            })
            ->when($room_id, function ($query) use ($room_id) {
                return $query->where('holidays.room_id', $room_id);
            })
            ->select(
                'holidays.id', 
                'holidays.date', 
                'holidays.room_id',
                'hotel_contents.title', 
                'hotel_contents.slug', 
                'hotel_contents.hotel_id',
                'room_contents.title as room_title'
            )
            ->get();

        return view('vendors.hotel.holiday.index', compact('globalHoliday', 'hotels', 'rooms'));
    }

    public function store(Request $request)
    {
        $vendorId = Auth::guard('vendor')->user()->id;
        $current_package = VendorPermissionHelper::packagePermission($vendorId);
        $defaultLang = Language::query()->where('is_default', 1)->first();

        if ($current_package == '[]') {
            Session::flash('warning', __('Please Buy a plan to add the holiday') . '!');
            return Response::json([
                'redirect' => route('vendor.hotel_management.hotel.holiday', ['language' => $defaultLang->code])
            ], 200);
        }

        $rules = [
            'date' => 'required',
            'hotel_id' => 'required',
            'room_id' => 'required',
        ];
        
        $messages = [
            'date.required' => 'The date field is required',
            'hotel_id.required' => 'The hotel field is required',
            'room_id.required' => 'The room field is required',
        ];

        $validator = Validator::make($request->all(), $rules, $messages);
        if ($validator->fails()) {
            return Response::json(
                [
                    'errors' => $validator->getMessageBag()->toArray()
                ],
                400
            );
        }

        $date = date('Y-m-d', strtotime($request->date));

        // Check if a holiday already exists for this exact combination
        $existingHoliday = Holiday::where('vendor_id', $vendorId)
            ->where('date', $date)
            ->where('hotel_id', $request->hotel_id)
            ->where('room_id', $request->room_id)
            ->exists();

        if ($existingHoliday) {
            Session::flash('warning', __('A holiday already exists for this date, hotel, and room combination') . '!');
            return Response::json(['status' => 'success'], 200);
        }

        Holiday::create([
            'date' => $date,
            'vendor_id' => $vendorId,
            'hotel_id' => $request->hotel_id,
            'room_id' => $request->room_id,
        ]);

        Session::flash('success', __('Holiday added successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {
        $holiday = Holiday::findOrFail($id);
        $holiday->delete();
        return redirect()->back()->with('success', __('Holiday deleted successfully') . '!');
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $holiday = Holiday::findOrFail($id);
            $holiday->delete();
        }

        Session::flash('success', __('Holidays deleted successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }
}