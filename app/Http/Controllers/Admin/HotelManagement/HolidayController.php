<?php

namespace App\Http\Controllers\Admin\HotelManagement;

use App\Http\Controllers\Controller;
use App\Http\Helpers\VendorPermissionHelper;
use App\Models\Holiday;
use App\Models\Hotel;
use App\Models\Language;
use App\Models\Room;
use App\Models\Vendor;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;

class HolidayController extends Controller
{
    public function index(Request $request)
    {
        if ($request->vendor_id == 'admin') {
            $vendor_id = 0;
        } else {
            $vendor_id = $request->vendor_id;
        }
    
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
    
        if (is_numeric($vendor_id) && (int)$vendor_id == $vendor_id) {
            if ($vendor_id != 0) {
                $current_package = VendorPermissionHelper::packagePermission($vendor_id);
                if ($current_package == '[]') {
                    return redirect()->route('admin.hotel_management.hotel.holiday', [
                        'language'  => $language->code,
                        'vendor_id' => 'admin'
                    ]);
                }
            }
    
            // Get active vendors (for admin dropdown or vendor selection)
            $vendors = Vendor::join('memberships', 'vendors.id', '=', 'memberships.vendor_id')
                ->where([
                    ['memberships.status', '=', 1],
                    ['memberships.start_date', '<=', Carbon::now()->format('Y-m-d')],
                    ['memberships.expire_date', '>=', Carbon::now()->format('Y-m-d')]
                ])
                ->select('vendors.id', 'vendors.username')
                ->get();
    
            // Query for hotels - different conditions for admin vs vendor
            $hotelsQuery = Hotel::join('hotel_contents', 'hotels.id', '=', 'hotel_contents.hotel_id')
                ->where('hotel_contents.language_id', $language->id);
                
            if ($vendor_id != 0) {
                $hotelsQuery->where('hotels.vendor_id', $vendor_id);
            }
            
            $hotels = $hotelsQuery->select('hotels.id', 'hotel_contents.title')
                ->get();
    
            // Query for rooms - different conditions for admin vs vendor
            $roomsQuery = Room::join('room_contents', 'rooms.id', '=', 'room_contents.room_id')
                ->join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
                ->where('room_contents.language_id', $language->id);
                
            if ($vendor_id != 0) {
                $roomsQuery->where('hotels.vendor_id', $vendor_id);
            }
            
            $rooms = $roomsQuery->select('rooms.id', 'room_contents.title', 'rooms.hotel_id')
                ->get();
    
            // Query for holidays - different conditions for admin vs vendor
            $globalHolidayQuery = Holiday::join('hotel_contents', 'holidays.hotel_id', '=', 'hotel_contents.hotel_id')
                ->where('hotel_contents.language_id', $language->id);
                
            if ($vendor_id != 0) {
                $globalHolidayQuery->where('holidays.vendor_id', $vendor_id);
            }
            
            $globalHoliday = $globalHolidayQuery->select('holidays.id', 'holidays.date', 'hotel_contents.title', 'hotel_contents.slug', 'hotel_contents.hotel_id')
                ->get();
    
            return view('admin.hotel-management.holiday.index', compact('globalHoliday', 'vendors', 'hotels', 'rooms'));
        } else {
            return redirect()->route('admin.hotel_management.hotel.holiday', [
                'language'  => $language->code,
                'vendor_id' => 'admin'
            ]);
        }
    }

    public function store(Request $request)
    {
        if ($request->vendor_id == 'admin') {
            $vendor_id = 0;
        } else {
            $vendor_id = $request->vendor_id;
        }

        $rules = [
            'date' => 'required',
            'hotel_id' => 'required',
            'room_id' => 'required',
        ];


        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return Response::json(
                [
                    'errors' => $validator->getMessageBag()->toArray()
                ],
                400
            );
        }

        $holiday = Holiday::where('vendor_id', $vendor_id)->pluck('date')->toArray();
        $date = date('Y-m-d', strtotime($request->date));
            Holiday::create([
                'date' => $date,
                'vendor_id' => $vendor_id,
                'hotel_id' => $request->hotel_id,
                'room_id' => $request->room_id,
            ]);
            Session::flash('success', __('Holiday added successfully') . '!');
            return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {
        $UserStaffHoliday = Holiday::find($id);
        $UserStaffHoliday->delete();
        return redirect()->back()->with('success', __('Holiday delete successfully') . '!');
    }

    public function blukDestroy(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $UserStaffHoliday = Holiday::find($id);
            $UserStaffHoliday->delete();
        }

        Session::flash('success', __('Holiday delete successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }
    public function getRooms(Request $request)
    {
        $language = Language::where('code', $request->language)->first();
        $hotelId = $request->hotel_id;

        $rooms = Room::join('room_contents', 'rooms.id', '=', 'room_contents.room_id')
            ->where('rooms.hotel_id', $hotelId)
            ->where('room_contents.language_id', $language->id)
            ->select('rooms.id', 'room_contents.title')
            ->get();

        return response()->json($rooms);
    }
}
