<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Models\Amenitie;
use App\Models\BasicSettings\Basic;
use App\Models\Booking;
use App\Models\BookingHour;
use App\Models\CustomPricing;
use App\Models\Holiday;
use App\Models\Hotel;
use App\Models\HourlyRoomPrice;
use App\Models\Room;
use App\Models\RoomContent;
use App\Models\RoomImage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use App\Models\HotelContent;
use App\Models\Vendor;
use App\Models\Location\City;
use App\Models\Location\Country;
use App\Models\Location\State;
use App\Models\RoomCategory;
use App\Models\RoomReview;
use App\Models\Visitor;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class RoomController extends Controller
{
    public function index(Request $request)
    {
        $view = Basic::query()->pluck('room_view')->first();
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();

        $information['bgImg'] = $misc->getBreadcrumb();

        $information['pageHeading'] = $misc->getPageHeading($language);

        $information['language'] = $language;
        $information['seoInfo'] = $language->seoInfo()->select('meta_keyword_rooms', 'meta_description_rooms')->first();

        $information['currencyInfo'] = $this->getCurrencyInfo();

        $title = $address = $category = $ratings = $checkInDates = $amenitie = $hotelId = $country = $state = $city = $location = $adult = $children = null;

        if ($request->filled('checkInDates')) {
            $checkInDates = $request->checkInDates;
        }

        if ($request->filled('checkInTimes')) {
            $checkInTimes = $request->checkInTimes;
            try {
                $checkInTimes = Carbon::parse($checkInTimes)->format('H:i:s');
            } catch (\Exception $e) {
                $checkInTimes = '00:00:00';
            }
        } else {
            $checkInTimes = null;
        }

        if ($request->filled('hour')) {
            $hour = $request->hour;
        } else {
            $hour  = BookingHour::max('hour');
        }

        $rooms = Room::get();

        $roomtimeIds = [];
        if ($checkInDates) {
            foreach ($rooms as $room) {

                $id = $room->id;

                $check_in_time = date('H:i:s', strtotime($checkInTimes));
                $check_in_date = date('Y-m-d', strtotime($checkInDates));
                $check_in_date_time = $check_in_date . ' ' . $check_in_time;

                $totalRoom = Room::findOrFail($id)->number_of_rooms_of_this_same_type;
                $preparation_time = $room->preparation_time;
                $bookingStatus = false;

                $check_out_time = date('H:i:s', strtotime($check_in_time . " +{$hour} hour"));

                $next_booking_time = date('H:i:s', strtotime($check_out_time . " +$preparation_time min"));

                list($current_hour, $current_minute, $current_second) = explode(':', $check_in_time);
                $total_hours = (int)$current_hour + $hour;
                $next_booking_time_for_next_day = sprintf('%02d:%02d:%02d', $total_hours, $current_minute, $current_second);

                $checkoutTimeLimit = '23:59:59';

                if ($checkoutTimeLimit < $next_booking_time_for_next_day) {
                    $checkoutDate = date('Y-m-d', strtotime($check_in_date . ' +1 day'));
                } else {
                    $checkoutDate = date('Y-m-d', strtotime($check_in_date));
                }

                $check_out_date_time = $checkoutDate . ' ' . $next_booking_time;

                $holiday = Holiday::Where('hotel_id', $room->hotel_id)->get();

                $holidays  = array_map(
                    function ($holiday) {
                        return \Carbon\Carbon::parse($holiday['date'])->format('m/d/Y');
                    },
                    $holiday->toArray()
                );

                $convertedHolidays = array_map(
                    function ($holiday) {
                        return \DateTime::createFromFormat('m/d/Y', $holiday)->format('Y-m-d');
                    },
                    $holidays
                );

                if (!in_array($checkoutDate, $convertedHolidays) && !in_array($check_in_date, $convertedHolidays)) {

                    $totalBookingDone = Booking::where('room_id', $id)
                        ->where('payment_status', '!=', 2)
                        ->where(function ($query) use ($check_in_date_time, $check_out_date_time) {
                            $query->where(function ($q) use ($check_in_date_time, $check_out_date_time) {
                                $q->whereBetween('check_in_date_time', [$check_in_date_time, $check_out_date_time])
                                    ->orWhereBetween('check_out_date_time', [$check_in_date_time, $check_out_date_time]);
                            })
                                ->orWhere(function ($q) use ($check_in_date_time, $check_out_date_time) {
                                    $q->where('check_in_date_time', '<=', $check_in_date_time)
                                        ->where('check_out_date_time', '>=', $check_out_date_time);
                                });
                        })
                        ->count();
                } else {
                    $totalBookingDone = 999999;
                }
                if ($totalRoom > $totalBookingDone) {
                    $bookingStatus = true;
                }

                if (!$bookingStatus) {
                    if (!in_array($id, $roomtimeIds)) {
                        array_push($roomtimeIds, $id);
                    }
                }
            }
        }

        $roomIds = [];
        if ($request->filled('title')) {
            $title = $request->title;

            $room_contents = RoomContent::where('language_id', $language->id)
                ->where('title', 'like', '%' . $title . '%')
                ->get()
                ->pluck('room_id');
            foreach ($room_contents as $room_content) {
                if (!in_array($room_content, $roomIds)) {
                    array_push($roomIds, $room_content);
                }
            }
        }

        $countryIds = [];
        if ($request->filled('country')) {
            $country = $request->country;
            $hotel_contents = HotelContent::where('language_id', $language->id)
                ->where('country_id', $country)
                ->get()
                ->pluck('hotel_id');
            foreach ($hotel_contents as $hotel_content) {
                if (!in_array($hotel_content, $countryIds)) {
                    array_push($countryIds, $hotel_content);
                }
            }
        }
        $stateIds = [];
        if ($request->filled('state')) {
            $state = $request->state;
            $hotel_contents = HotelContent::where('language_id', $language->id)
                ->where('state_id', $state)
                ->get()
                ->pluck('hotel_id');
            foreach ($hotel_contents as $hotel_content) {
                if (!in_array($hotel_content, $stateIds)) {
                    array_push($stateIds, $hotel_content);
                }
            }
        }

        $cityIds = [];
        if ($request->filled('city')) {
            $city = $request->city;
            $hotel_contents = HotelContent::where('language_id', $language->id)
                ->where('city_id', $city)
                ->get()
                ->pluck('hotel_id');
            foreach ($hotel_contents as $hotel_content) {
                if (!in_array($hotel_content, $cityIds)) {
                    array_push($cityIds, $hotel_content);
                }
            }
        }

        if ($request->filled('hotelId')) {
            $hotelId = $request->hotelId;
        }

        $category_roomIds = [];
        if ($request->filled('category')) {
            $category = $request->category;

            $category_content = RoomCategory::where([['language_id', $language->id], ['slug', $category]])->first();

            if (!empty($category_content)) {
                $category_id = $category_content->id;
                $contents = RoomContent::where('language_id', $language->id)
                    ->where('room_category', $category_id)
                    ->get()
                    ->pluck('room_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $category_roomIds)) {
                        array_push($category_roomIds, $content);
                    }
                }
            }
        }


        $ratingIds = [];
        if ($request->filled('ratings')) {
            $ratings = $request->ratings;
            $contents = Room::where('average_rating', '>=', $ratings)
                ->get()
                ->pluck('id');
            foreach ($contents as $content) {
                if (!in_array($content, $ratingIds)) {
                    array_push($ratingIds, $content);
                }
            }
        }

        $amenitieIds = [];
        if ($request->filled('amenitie')) {
            $amenitie = $request->amenitie;
            $array = explode(',', $amenitie);

            $contents = RoomContent::where('language_id', $language->id)
                ->get(['room_id', 'amenities']);

            foreach ($contents as $content) {
                $amenities = (json_decode($content->amenities));
                $roomId = $content->room_id;
                $diff1 = array_diff($array, $amenities);
                $diff2 = array_diff($array, $amenities);

                if (empty($diff1) && empty($diff2)) {

                    array_push($amenitieIds, $roomId);
                }
            }
        }

        $adultIds = [];
        if ($request->filled('adult')) {
            $adult = $request->adult;
            $contents = Room::where('adult', '>=', $adult)
                ->get()
                ->pluck('id');

            foreach ($contents as $content) {
                if (!in_array($content, $adultIds)) {
                    array_push($adultIds, $content);
                }
            }
        }

        $childrenIds = [];
        if ($request->filled('children')) {
            $children = $request->children;
            $contents = Room::where('children', '>=',  $children)
                ->get()
                ->pluck('id');
            foreach ($contents as $content) {
                if (!in_array($content, $childrenIds)) {
                    array_push($childrenIds, $content);
                }
            }
        }

        //search by location
        $locationIds = [];
        $addressIds = [];
        $bs = Basic::select('google_map_api_key_status', 'radius')->first();
        $radius = $bs->google_map_api_key_status == 1 ? $bs->radius : 5000;

        if ($request->filled('location')) {

            if ($bs->google_map_api_key_status == 1) {
                $location = $request->location;
                $hotelIds = HotelContent::where('language_id', $language->id)
                    ->where('address', 'like', '%' . $location . '%')
                    ->distinct()
                    ->pluck('hotel_id')
                    ->toArray();

                $serviceLog = Hotel::whereIn('id', $hotelIds)->select('latitude', 'longitude')->first();
                $locationIds = $serviceLog;
            } else {
                $address = $request->location;
                $contents = HotelContent::Where('language_id', $language->id)
                    ->where('address', 'like', '%' . $address . '%')
                    ->get()
                    ->pluck('hotel_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $addressIds)) {
                        array_push($addressIds, $content);
                    }
                }
            }
        }

        if ($request->filled('sort')) {
            if ($request['sort'] == 'new') {
                $order_by_column = 'rooms.id';
                $order = 'desc';
            } elseif ($request['sort'] == 'old') {
                $order_by_column = 'rooms.id';
                $order = 'asc';
            } else {
                $order_by_column = 'rooms.id';
                $order = 'desc';
            }
        } else {
            $order_by_column = 'rooms.id';
            $order = 'desc';
        }


        $featured_contents = RoomContent::join('rooms', 'rooms.id', '=', 'room_contents.room_id')
            ->Join('room_features', 'rooms.id', '=', 'room_features.room_id')
            ->Join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
            ->Join('room_categories', 'room_contents.room_category', '=', 'room_categories.id')
            ->Join('hotel_contents', 'rooms.hotel_id', '=', 'hotel_contents.hotel_id')
            ->Join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('room_categories.status', 1)
            ->where('hotel_categories.status', 1)
            ->where('room_contents.language_id', $language->id)
            ->where('room_features.order_status', '=', 'apporved')
            ->where('rooms.status',  '=',    '1')
            ->where('hotels.status',  '=',    '1')
            ->whereDate('room_features.end_date', '>=', Carbon::now()->format('Y-m-d'))
            ->when('rooms.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'rooms.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('rooms.vendor_id', '=', 0);
                    });
            })
            ->when('rooms.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'rooms.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('rooms.vendor_id', '=', 0);
                    });
            })
            ->when($category, function ($query) use ($category_roomIds) {
                return $query->whereIn('rooms.id', $category_roomIds);
            })

            ->when($title, function ($query) use ($roomIds) {
                return $query->whereIn('rooms.id', $roomIds);
            })
            ->when($hotelId, function ($query) use ($hotelId) {
                return $query->where('rooms.hotel_id', $hotelId);
            })

            ->when($ratings, function ($query) use ($ratingIds) {
                return $query->whereIn('rooms.id', $ratingIds);
            })
            ->when($amenitie, function ($query) use ($amenitieIds) {
                return $query->whereIn('rooms.id', $amenitieIds);
            })
            ->when($adult, function ($query) use ($adultIds) {
                return $query->whereIn('rooms.id', $adultIds);
            })
            ->when($children, function ($query) use ($childrenIds) {
                return $query->whereIn('rooms.id', $childrenIds);
            })
            ->when($checkInDates, function ($query) use ($roomtimeIds) {
                return $query->whereNotIn('rooms.id', $roomtimeIds);
            })
            ->when($country, function ($query) use ($countryIds) {
                return $query->whereIn('rooms.hotel_id', $countryIds);
            })
            ->when($state, function ($query) use ($stateIds) {
                return $query->whereIn('rooms.hotel_id', $stateIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('rooms.hotel_id', $cityIds);
            })

            ->when($address, function ($query) use ($addressIds) {
                return $query->whereIn('rooms.hotel_id', $addressIds);
            })

            ->when($location, function ($query) use ($locationIds, $radius) {
                if (is_null($locationIds)) {
                    return $query->whereRaw('1=0');
                }
                return $query->whereRaw("
            (6371000 * acos(
            cos(radians(?)) *
            cos(radians(hotels.latitude)) *
            cos(radians(hotels.longitude) - radians(?)) +
            sin(radians(?)) *
            sin(radians(hotels.latitude))
            )) < ?
            ", [$locationIds->latitude, $locationIds->longitude, $locationIds->latitude, $radius]);
            })
            ->select(
                'rooms.*',
                'room_contents.title',
                'room_contents.slug',
                'room_contents.amenities',
                'hotels.id as hotelId',
                'hotels.stars as stars',
                'hotels.latitude as latitude',
                'hotels.longitude as longitude',
                'hotels.logo as hotelImage',
                'hotel_contents.title as hotelName',
                'hotel_contents.slug as hotelSlug',
                'hotel_contents.city_id',
                'hotel_contents.state_id',
                'hotel_contents.country_id'
            )
            ->orderBy($order_by_column, $order)
            ->inRandomOrder()
            ->limit(3)
            ->get();

        $totalFeatured_content = Count($featured_contents);

        $featured_contentsIds = [];
        if ($featured_contents) {

            foreach ($featured_contents as $content) {
                if (!in_array($content->id, $featured_contentsIds)) {
                    array_push($featured_contentsIds, $content->id);
                }
            }
        }

        $room_contents = RoomContent::join('rooms', 'rooms.id', '=', 'room_contents.room_id')
            ->Join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
            ->Join('room_categories', 'room_contents.room_category', '=', 'room_categories.id')
            ->Join('hotel_contents', 'rooms.hotel_id', '=', 'hotel_contents.hotel_id')
            ->Join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('room_categories.status', 1)
            ->where('hotel_categories.status', 1)
            ->where('room_contents.language_id', $language->id)
            ->where('rooms.status',  '=',    '1')
            ->where('hotels.status',  '=',    '1')
            ->when('rooms.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'rooms.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('rooms.vendor_id', '=', 0);
                    });
            })
            ->when('rooms.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'rooms.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('rooms.vendor_id', '=', 0);
                    });
            })
            ->when($title, function ($query) use ($roomIds) {
                return $query->whereIn('rooms.id', $roomIds);
            })

            ->when($hotelId, function ($query) use ($hotelId) {
                return $query->where('rooms.hotel_id', $hotelId);
            })
            ->when($category, function ($query) use ($category_roomIds) {
                return $query->whereIn('rooms.id', $category_roomIds);
            })
            ->when($ratings, function ($query) use ($ratingIds) {
                return $query->whereIn('rooms.id', $ratingIds);
            })
            ->when($amenitie, function ($query) use ($amenitieIds) {
                return $query->whereIn('rooms.id', $amenitieIds);
            })
            ->when($adult, function ($query) use ($adultIds) {
                return $query->whereIn('rooms.id', $adultIds);
            })
            ->when($children, function ($query) use ($childrenIds) {
                return $query->whereIn('rooms.id', $childrenIds);
            })
            ->when($checkInDates, function ($query) use ($roomtimeIds) {
                return $query->whereNotIn('rooms.id', $roomtimeIds);
            })
            ->when($country, function ($query) use ($countryIds) {
                return $query->whereIn('rooms.hotel_id', $countryIds);
            })
            ->when($state, function ($query) use ($stateIds) {
                return $query->whereIn('rooms.hotel_id', $stateIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('rooms.hotel_id', $cityIds);
            })
            ->when($featured_contents, function ($query) use ($featured_contentsIds) {
                return $query->whereNotIn('rooms.id', $featured_contentsIds);
            })
            ->when($address, function ($query) use ($addressIds) {
                return $query->whereIn('rooms.hotel_id', $addressIds);
            })

            ->when($location, function ($query) use ($locationIds, $radius) {
                if (is_null($locationIds)) {
                    return $query->whereRaw('1=0');
                }
                return $query->whereRaw("
            (6371000 * acos(
            cos(radians(?)) *
            cos(radians(hotels.latitude)) *
            cos(radians(hotels.longitude) - radians(?)) +
            sin(radians(?)) *
            sin(radians(hotels.latitude))
            )) < ?
            ", [$locationIds->latitude, $locationIds->longitude, $locationIds->latitude, $radius]);
            })
            ->select(
                'rooms.*',
                'room_contents.title',
                'room_contents.slug',
                'room_contents.amenities',
                'hotels.id as hotelId',
                'hotels.stars as stars',
                'hotels.latitude as latitude',
                'hotels.longitude as longitude',
                'hotels.logo as hotelImage',
                'hotel_contents.title as hotelName',
                'hotel_contents.slug as hotelSlug',
                'hotel_contents.city_id',
                'hotel_contents.state_id',
                'hotel_contents.country_id'
            )
            ->orderBy($order_by_column, $order)
            ->get();


        if ($totalFeatured_content == 3) {
            $perPage = 6;
        } elseif ($totalFeatured_content == 2) {
            $perPage = 6;
        } elseif ($totalFeatured_content == 1) {
            $perPage = 6;
        } else {
            $perPage = 6;
        }

        $page = 1;

        $offset = ($page - 1) * $perPage;

        $currentPageData = $room_contents->slice($offset, $perPage);

        $information['categories'] = RoomCategory::where('language_id', $language->id)->where('status', 1)
            ->orderBy('serial_number', 'asc')->get();

        $information['vendors'] = Vendor::join('memberships', 'vendors.id', '=', 'memberships.vendor_id')
            ->where([
                ['memberships.status', '=', 1],
                ['memberships.start_date', '<=', Carbon::now()->format('Y-m-d')],
                ['memberships.expire_date', '>=', Carbon::now()->format('Y-m-d')]
            ])
            ->get();

        $information['countries'] = Country::where('language_id', $language->id)
            ->orderBy('id', 'asc')->get();

        $information['states'] = State::where('language_id', $language->id)
            ->orderBy('id', 'asc')->get();

        $information['cities'] = City::where('language_id', $language->id)
            ->orderBy('id', 'asc')->get();

        $information['room_contents'] = $room_contents;
        $information['featured_contents'] = $featured_contents;
        $information['currentPageData'] = $currentPageData;
        $information['perPage'] = $perPage;
        $information['bookingHours'] =  BookingHour::orderBy('hour', 'asc')->get();
        $information['amenities'] =  Amenitie::Where('language_id', $language->id)->get();
        $information['hotels'] =  Hotel::Join('hotel_contents', 'hotels.id', '=', 'hotel_contents.hotel_id')
            ->where('hotel_contents.language_id', $language->id)
            ->select(
                'hotels.id',
                'hotel_contents.title',
            )->orderBy('hotels.id', 'desc')
            ->get();

        $information['adultNumber'] = Room::where('status', 1)->max('adult');
        $information['childrenNumber'] = Room::where('status', 1)->max('children');

        // Add 2-hour price data to featured_contents and currentPageData
        $featured_contents = $featured_contents->map(function ($room) {
            $twoHourPrice = \App\Models\HourlyRoomPrice::where('room_id', $room->id)
                ->join('booking_hours', 'hourly_room_prices.hour_id', '=', 'booking_hours.id')
                ->where('booking_hours.hour', 2)
                ->where('hourly_room_prices.price', '!=', null)
                ->value('hourly_room_prices.price');
            
            $room->two_hour_price = $twoHourPrice ? symbolPrice($twoHourPrice) : null;
            return $room;
        });

        $currentPageData = $currentPageData->map(function ($room) {
            $twoHourPrice = \App\Models\HourlyRoomPrice::where('room_id', $room->id)
                ->join('booking_hours', 'hourly_room_prices.hour_id', '=', 'booking_hours.id')
                ->where('booking_hours.hour', 2)
                ->where('hourly_room_prices.price', '!=', null)
                ->value('hourly_room_prices.price');
            
            $room->two_hour_price = $twoHourPrice ? symbolPrice($twoHourPrice) : null;
            return $room;
        });

        if ($view == 0) {
            return view('frontend.room.room-map', $information);
        } else {
            return view('frontend.room.room-gird', $information);
        }
    }

    public function getAddress(Request $request)
    {
        if ($request->country_id) {
            $country = Country::Where('id', $request->country_id)->first()
                ->name;
        }
        if ($request->state_id) {
            $state = State::Where('id', $request->state_id)->first()
                ->name;
        }
        if ($request->city_id) {
            $city = City::Where('id', $request->city_id)->first()
                ->name;
        }
        $address = '';
        if ($request->city_id) {
            if ($city) {
                $address .= $city;
            }
        }
        if ($request->state_id) {
            if ($state) {
                $address .= ($address ? ', ' : '') . $state;
            }
        }
        if ($request->country_id) {
            if ($country) {
                $address .= ($address ? ', ' : '') . $country;
            }
        }

        return $address;
    }

    public function search_room(Request $request)
    {
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();
        $information['language'] = $language;

        $information['currencyInfo'] = $this->getCurrencyInfo();
        $title = $address = $category = $stars = $ratings = $amenitie = $hotelId = $country = $state = $city = $location = null;




        $roomIds = [];
        if ($request->filled('title')) {
            $title = $request->title;

            $room_contents = RoomContent::where('language_id', $language->id)
                ->where('title', 'like', '%' . $title . '%')
                ->get()
                ->pluck('room_id');
            foreach ($room_contents as $room_content) {
                if (!in_array($room_content, $roomIds)) {
                    array_push($roomIds, $room_content);
                }
            }
        }

        $countryIds = [];
        if ($request->filled('country')) {
            $country = $request->country;
            $hotel_contents = HotelContent::where('language_id', $language->id)
                ->where('country_id', $country)
                ->get()
                ->pluck('hotel_id');
            foreach ($hotel_contents as $hotel_content) {
                if (!in_array($hotel_content, $countryIds)) {
                    array_push($countryIds, $hotel_content);
                }
            }
        }
        $stateIds = [];
        if ($request->filled('state')) {
            $state = $request->state;
            $hotel_contents = HotelContent::where('language_id', $language->id)
                ->where('state_id', $state)
                ->get()
                ->pluck('hotel_id');
            foreach ($hotel_contents as $hotel_content) {
                if (!in_array($hotel_content, $stateIds)) {
                    array_push($stateIds, $hotel_content);
                }
            }
        }

        $cityIds = [];
        if ($request->filled('city')) {
            $city = $request->city;
            $hotel_contents = HotelContent::where('language_id', $language->id)
                ->where('city_id', $city)
                ->get()
                ->pluck('hotel_id');
            foreach ($hotel_contents as $hotel_content) {
                if (!in_array($hotel_content, $cityIds)) {
                    array_push($cityIds, $hotel_content);
                }
            }
        }

        if ($request->filled('hotelId')) {
            $hotelId = $request->hotelId;
        }

        $category_roomIds = [];
        if ($request->filled('category')) {
            $category = $request->category;

            $category_content = RoomCategory::where([['language_id', $language->id], ['slug', $category]])->first();

            if (!empty($category_content)) {
                $category_id = $category_content->id;
                $contents = RoomContent::where('language_id', $language->id)
                    ->where('room_category', $category_id)
                    ->get()
                    ->pluck('room_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $category_roomIds)) {
                        array_push($category_roomIds, $content);
                    }
                }
            }
        }

        $ratingIds = [];
        if ($request->filled('ratings')) {
            $ratings = $request->ratings;
            $contents = Room::where('average_rating', '>=', $ratings)
                ->get()
                ->pluck('id');
            foreach ($contents as $content) {
                if (!in_array($content, $ratingIds)) {
                    array_push($ratingIds, $content);
                }
            }
        }

        $starsIds = [];
        if ($request->filled('stars')) {
            $stars = $request->stars;
            $contents = Hotel::where('stars', $stars)
                ->get()
                ->pluck('id');
            foreach ($contents as $content) {
                if (!in_array($content, $starsIds)) {
                    array_push($starsIds, $content);
                }
            }
        }

        $adultIds = [];
        if ($request->filled('adult')) {
            $adult = $request->adult;
            $contents = Room::where('adult', '>=', $adult)
                ->get()
                ->pluck('id');

            foreach ($contents as $content) {
                if (!in_array($content, $adultIds)) {
                    array_push($adultIds, $content);
                }
            }
        }
        $childrenIds = [];
        if ($request->filled('children')) {
            $children = $request->children;
            $contents = Room::where('children', '>=',  $children)
                ->get()
                ->pluck('id');
            foreach ($contents as $content) {
                if (!in_array($content, $childrenIds)) {
                    array_push($childrenIds, $content);
                }
            }
        }

        $amenitieIds = [];
        if ($request->filled('amenitie')) {
            $amenitie = $request->amenitie;
            $array = explode(',', $amenitie);

            $contents = RoomContent::where('language_id', $language->id)
                ->get(['room_id', 'amenities']);

            foreach ($contents as $content) {
                $amenities = (json_decode($content->amenities));
                $roomId = $content->room_id;
                $diff1 = array_diff($array, $amenities);
                $diff2 = array_diff($array, $amenities);

                if (empty($diff1) && empty($diff2)) {

                    array_push($amenitieIds, $roomId);
                }
            }
        }

        //search by location
        $locationIds = [];
        $addressIds = [];
        $bs = Basic::select('google_map_api_key_status', 'radius')->first();
        $radius = $bs->google_map_api_key_status == 1 ? $bs->radius : 5000;

        if ($request->filled('location_val')) {

            if ($bs->google_map_api_key_status == 1) {
                $location = $request->location_val;
                $hotelIds = HotelContent::where('language_id', $language->id)
                    ->where('address', 'like', '%' . $location . '%')
                    ->distinct()
                    ->pluck('hotel_id')
                    ->toArray();

                $serviceLog = Hotel::whereIn('id', $hotelIds)->select('latitude', 'longitude')->first();
                $locationIds = $serviceLog;
            } else {
                $address = $request->location_val;

                $contents = HotelContent::Where('language_id', $language->id)
                    ->where('address', 'like', '%' . $address . '%')
                    ->get()
                    ->pluck('hotel_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $addressIds)) {
                        array_push($addressIds, $content);
                    }
                }
            }
        }

        if ($request->filled('sort')) {
            if ($request['sort'] == 'new') {
                $order_by_column = 'rooms.id';
                $order = 'desc';
            } elseif ($request['sort'] == 'old') {
                $order_by_column = 'rooms.id';
                $order = 'asc';
            } elseif ($request['sort'] == 'starhigh') {
                $order_by_column = 'hotels.stars';
                $order = 'desc';
            } elseif ($request['sort'] == 'starlow') {
                $order_by_column = 'hotels.stars';
                $order = 'asc';
            } elseif ($request['sort'] == 'reviewshigh') {
                $order_by_column = 'rooms.average_rating';
                $order = 'desc';
            } elseif ($request['sort'] == 'reviewslow') {
                $order_by_column = 'rooms.average_rating';
                $order = 'asc';
            } else {
                $order_by_column = 'rooms.id';
                $order = 'desc';
            }
        } else {
            $order_by_column = 'rooms.id';
            $order = 'desc';
        }

        $featured_contents = RoomContent::join('rooms', 'rooms.id', '=', 'room_contents.room_id')
            ->Join('room_features', 'rooms.id', '=', 'room_features.room_id')
            ->Join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
            ->Join('room_categories', 'room_contents.room_category', '=', 'room_categories.id')
            ->Join('hotel_contents', 'rooms.hotel_id', '=', 'hotel_contents.hotel_id')
            ->Join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('room_categories.status', 1)
            ->where('hotel_categories.status', 1)
            ->where('room_contents.language_id', $language->id)
            ->where('room_features.order_status', '=', 'apporved')
            ->where('rooms.status',  '=', '1')
            ->where('hotels.status',  '=', '1')
            ->whereDate('room_features.end_date', '>=', Carbon::now()->format('Y-m-d'))
            ->when('rooms.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'rooms.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('rooms.vendor_id', '=', 0);
                    });
            })
            ->when('rooms.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'rooms.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('rooms.vendor_id', '=', 0);
                    });
            })
            ->when($category, function ($query) use ($category_roomIds) {
                return $query->whereIn('rooms.id', $category_roomIds);
            })

            ->when($title, function ($query) use ($roomIds) {
                return $query->whereIn('rooms.id', $roomIds);
            })
            ->when($hotelId, function ($query) use ($hotelId) {
                return $query->where('rooms.hotel_id', $hotelId);
            })
            ->when($category, function ($query) use ($category_roomIds) {
                return $query->whereIn('rooms.id', $category_roomIds);
            })
            ->when($ratings, function ($query) use ($ratingIds) {
                return $query->whereIn('rooms.id', $ratingIds);
            })
            ->when($stars, function ($query) use ($starsIds) {
                return $query->whereIn('rooms.hotel_id', $starsIds);
            })
            ->when($country, function ($query) use ($countryIds) {
                return $query->whereIn('rooms.hotel_id', $countryIds);
            })
            ->when($state, function ($query) use ($stateIds) {
                return $query->whereIn('rooms.hotel_id', $stateIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('rooms.hotel_id', $cityIds);
            })
            ->when($address, function ($query) use ($addressIds) {
                return $query->whereIn('rooms.hotel_id', $addressIds);
            })
            ->when($location, function ($query) use ($locationIds, $radius) {
                if (is_null($locationIds)) {
                    return $query->whereRaw('1=0');
                }
                return $query->whereRaw("
            (6371000 * acos(
            cos(radians(?)) *
            cos(radians(hotels.latitude)) *
            cos(radians(hotels.longitude) - radians(?)) +
            sin(radians(?)) *
            sin(radians(hotels.latitude))
            )) < ?
            ", [$locationIds->latitude, $locationIds->longitude, $locationIds->latitude, $radius]);
            })
            ->select(
                'rooms.*',
                'room_contents.title',
                'room_contents.slug',
                'room_contents.amenities',
                'hotels.id as hotelId',
                'hotels.stars as stars',
                'hotels.latitude as latitude',
                'hotels.longitude as longitude',
                'hotels.logo as hotelImage',
                'hotel_contents.title as hotelName',
                'hotel_contents.slug as hotelSlug',
                'hotel_contents.city_id',
                'hotel_contents.state_id',
                'hotel_contents.country_id'
            )

            ->orderBy($order_by_column, $order)
            ->inRandomOrder()
            ->limit(3)
            ->get();

        $totalFeatured_content = Count($featured_contents);

        $featured_contentsIds = [];
        if ($featured_contents) {

            foreach ($featured_contents as $content) {
                if (!in_array($content->id, $featured_contentsIds)) {
                    array_push($featured_contentsIds, $content->id);
                }
            }
        }

        $room_contents = RoomContent::join('rooms', 'rooms.id', '=', 'room_contents.room_id')
            ->Join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
            ->Join('room_categories', 'room_contents.room_category', '=', 'room_categories.id')
            ->Join('hotel_contents', 'rooms.hotel_id', '=', 'hotel_contents.hotel_id')
            ->Join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('room_categories.status', 1)
            ->where('hotel_categories.status', 1)
            ->where('room_contents.language_id', $language->id)
            ->where('rooms.status',  '=',    '1')
            ->where('hotels.status',  '=',    '1')
            ->when('rooms.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'rooms.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('rooms.vendor_id', '=', 0);
                    });
            })
            ->when('rooms.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'rooms.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('rooms.vendor_id', '=', 0);
                    });
            })
            ->when($title, function ($query) use ($roomIds) {
                return $query->whereIn('rooms.id', $roomIds);
            })
            ->when($hotelId, function ($query) use ($hotelId) {
                return $query->where('rooms.hotel_id', $hotelId);
            })
            ->when($category, function ($query) use ($category_roomIds) {
                return $query->whereIn('rooms.id', $category_roomIds);
            })
            ->when($ratings, function ($query) use ($ratingIds) {
                return $query->whereIn('rooms.id', $ratingIds);
            })
            ->when($stars, function ($query) use ($starsIds) {
                return $query->whereIn('rooms.hotel_id', $starsIds);
            })
            ->when($country, function ($query) use ($countryIds) {
                return $query->whereIn('rooms.hotel_id', $countryIds);
            })
            ->when($state, function ($query) use ($stateIds) {
                return $query->whereIn('rooms.hotel_id', $stateIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('rooms.hotel_id', $cityIds);
            })
            ->when($featured_contents, function ($query) use ($featured_contentsIds) {
                return $query->whereNotIn('rooms.id', $featured_contentsIds);
            })
            ->when($address, function ($query) use ($addressIds) {
                return $query->whereIn('rooms.hotel_id', $addressIds);
            })
            ->when($location, function ($query) use ($locationIds, $radius) {
                if (is_null($locationIds)) {
                    return $query->whereRaw('1=0');
                }
                return $query->whereRaw("
            (6371000 * acos(
            cos(radians(?)) *
            cos(radians(hotels.latitude)) *
            cos(radians(hotels.longitude) - radians(?)) +
            sin(radians(?)) *
            sin(radians(hotels.latitude))
            )) < ?
            ", [$locationIds->latitude, $locationIds->longitude, $locationIds->latitude, $radius]);
            })
            ->select(
                'rooms.*',
                'room_contents.title',
                'room_contents.slug',
                'room_contents.amenities',
                'hotels.id as hotelId',
                'hotels.stars as stars',
                'hotels.latitude as latitude',
                'hotels.longitude as longitude',
                'hotels.logo as hotelImage',
                'hotel_contents.title as hotelName',
                'hotel_contents.slug as hotelSlug',
                'hotel_contents.city_id',
                'hotel_contents.state_id',
                'hotel_contents.country_id'
            )
            ->orderBy($order_by_column, $order)
            ->get();


        if ($totalFeatured_content == 3) {
            $perPage = 9;
        } elseif ($totalFeatured_content == 2) {
            $perPage = 10;
        } elseif ($totalFeatured_content == 1) {
            $perPage = 11;
        } else {
            $perPage = 12;
        }

        $page = $request->query('page');

        $offset = ($page - 1) * $perPage;

        // Get the subset of data for the current page
        $currentPageData = $room_contents->slice($offset, $perPage);

        $information['room_contents'] = $room_contents;
        $information['featured_contents'] = $featured_contents;
        $information['currentPageData'] = $currentPageData;

        $information['perPage'] = $perPage;
        $information['adultNumber'] = Room::where('status', 1)->max('adult');
        $information['childrenNumber'] = Room::where('status', 1)->max('children');

        // Add 2-hour price data to featured_contents and currentPageData
        $featured_contents = $featured_contents->map(function ($room) {
            $twoHourPrice = \App\Models\HourlyRoomPrice::where('room_id', $room->id)
                ->join('booking_hours', 'hourly_room_prices.hour_id', '=', 'booking_hours.id')
                ->where('booking_hours.hour', 2)
                ->where('hourly_room_prices.price', '!=', null)
                ->value('hourly_room_prices.price');
            
            $room->two_hour_price = $twoHourPrice ? symbolPrice($twoHourPrice) : null;
            return $room;
        });

        $currentPageData = $currentPageData->map(function ($room) {
            $twoHourPrice = \App\Models\HourlyRoomPrice::where('room_id', $room->id)
                ->join('booking_hours', 'hourly_room_prices.hour_id', '=', 'booking_hours.id')
                ->where('booking_hours.hour', 2)
                ->where('hourly_room_prices.price', '!=', null)
                ->value('hourly_room_prices.price');
            
            $room->two_hour_price = $twoHourPrice ? symbolPrice($twoHourPrice) : null;
            return $room;
        });

        // Check if this is an AJAX request
        if ($request->ajax()) {
            return view('frontend.room.search-room', $information)->render();
        }
        
        // For direct access, return full page with layout
        $information['bgImg'] = $misc->getBreadcrumb();
        $information['pageHeading'] = $misc->getPageHeading($language);
        $information['seoInfo'] = $language->seoInfo()->select('meta_keyword_rooms', 'meta_description_rooms')->first();
        $information['basicInfo'] = Basic::first();
        $information['currentLanguageInfo'] = $language;
        
        // Add additional data needed for the search form
        $information['hotelCategories'] = \App\Models\HotelCategory::where('language_id', $language->id)->where('status', 1)
            ->orderBy('serial_number', 'asc')->get();
        
        // Add data for filter dropdowns
        $information['hotels'] = Hotel::join('hotel_contents', 'hotels.id', '=', 'hotel_contents.hotel_id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('hotels.status', 1)
            ->select('hotels.id', 'hotel_contents.title')
            ->get();
            
        // Add location data for filters
        $information['countries'] = \App\Models\Location\Country::where('language_id', $language->id)->get();
        $information['states'] = \App\Models\Location\State::where('language_id', $language->id)->get();
        $information['cities'] = \App\Models\Location\City::where('language_id', $language->id)->get();
        
        
        return view('frontend.room.search-room-full', $information);
    }

    public function details($slug, $id)
    {
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();
        $information['bgImg'] = $misc->getBreadcrumb();
        $information['pageHeading'] = $misc->getPageHeading($language);
    
        $vendorId = Room::where('id', $id)->pluck('vendor_id')->first();
    
        // Get the room content with hotel information
        $roomContent = RoomContent::join('rooms', 'rooms.id', '=', 'room_contents.room_id')
            ->join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
            ->join('room_categories', 'room_contents.room_category', '=', 'room_categories.id')
            ->join('hotel_contents', 'rooms.hotel_id', '=', 'hotel_contents.hotel_id')
            ->join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('room_categories.status', 1)
            ->where('hotel_categories.status', 1)
            ->where('room_contents.language_id', $language->id)
            ->where('rooms.status', 1)
            ->where('hotels.status', 1)
            ->when($vendorId && $vendorId != 0, function ($query) {
                $query->join('memberships', 'rooms.vendor_id', '=', 'memberships.vendor_id')
                    ->where([
                        ['memberships.status', 1],
                        ['memberships.start_date', '<=', now()->format('Y-m-d')],
                        ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                    ]);
            })
            ->when($vendorId && $vendorId != 0, function ($query) {
                return $query->leftJoin('vendors', 'rooms.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where('vendors.status', 1)
                              ->orWhere('rooms.vendor_id', 0);
                    });
            })
            ->where('rooms.id', $id)
            ->select(
                'rooms.*',
                'room_contents.title',
                'room_contents.slug',
                'room_contents.amenities',
                'room_contents.room_category',
                'room_contents.meta_keyword',
                'room_contents.meta_description',
                'hotel_contents.address as address',
                'hotel_contents.title as hoteltitle',
                'hotel_contents.slug as hotelSlug',
                'room_contents.description',
                'hotels.id as hotelId',
                'hotels.logo as hotellogo',
                'hotels.stars as stars',
                'hotels.latitude as latitude',
                'hotels.longitude as longitude',
                'room_categories.name as categoryName',
                'room_categories.slug as categorySlug',
                'hotels.monday_slots',
                'hotels.tuesday_slots',
                'hotels.wednesday_slots',
                'hotels.thursday_slots',
                'hotels.friday_slots',
                'hotels.saturday_slots',
                'hotels.sunday_slots'
            )
            ->firstOrFail();
    
        // Get the full hotel model with all attributes
        $hotel = Hotel::findOrFail($roomContent->hotelId);
    
        if ($vendorId == 0) {
            $information['vendor'] = Admin::first();
            $information['userName'] = 'admin';
        } else {
            $information['vendor'] = Vendor::where('id', $vendorId)->first();
            $information['userName'] = $information['vendor']->username;
        }
    
        $information['roomContent'] = $roomContent;
        $information['roomImages'] = RoomImage::where('room_id', $id)->get();
        $information['hotel'] = $hotel; 
    
        $room_content = RoomContent::where('language_id', $language->id)->where('room_id', $id)->first();
        if (is_null($room_content)) {
            Session::flash('error', 'No Room information found for ' . $language->name . ' language');
            return redirect()->route('index');
        }
        $information['language'] = $language;
    
        $holiday = Holiday::where('room_id', $id)->get();
        $holidays = array_map(
            fn($holiday) => \Carbon\Carbon::parse($holiday['date'])->format('m/d/Y'),
            $holiday->toArray()
        );
    
        $information['holidayDates'] = $holidays;
    
        $convertedHolidays = array_map(
            fn($holiday) => \DateTime::createFromFormat('m/d/Y', $holiday)->format('Y-m-d'),
            $holidays
        );
    
        $latestCheckoutDate = Booking::where('room_id', $id)->max('check_out_date');
        $checkinDate = $latestCheckoutDate ? Carbon::parse($latestCheckoutDate)->addDay()->format('Y-m-d') : date('Y-m-d');
    
        while (in_array($checkinDate, $convertedHolidays)) {
            $checkinDate = Carbon::parse($checkinDate)->addDay()->format('Y-m-d');
        }
    
        $information['checkinDate'] = $checkinDate;
    
        $defaultPrices = HourlyRoomPrice::where('room_id', $id)
            ->join('booking_hours', 'hourly_room_prices.hour_id', '=', 'booking_hours.id')
            ->whereNotNull('hourly_room_prices.price')
            ->orderBy('booking_hours.serial_number')
            ->select(
                'hourly_room_prices.*', 
                'booking_hours.serial_number', 
                'booking_hours.hour'
            )
            ->get()
            ->keyBy('hour_id');
    
        $customPrices = CustomPricing::where('room_id', $id)
            ->whereDate('date', $checkinDate)
            ->with('bookingHour')
            ->get()
            ->keyBy('booking_hours_id');
    
        $hourlyPrices = collect($customPrices)->map(function ($customPrice) use ($defaultPrices) {
            $hour_id = $customPrice->booking_hours_id; 
            $priceData = $defaultPrices[$hour_id] ?? new HourlyRoomPrice();
            $priceData->price = $customPrice->price;
            $priceData->is_custom = true;
            $priceData->hour_id = $hour_id;
            $priceData->serial_number = $customPrice->bookingHour->serial_number ?? null;
            $priceData->hour = $customPrice->bookingHour->hour ?? null;
            return $priceData;
        });
    
        $defaultPrices->each(function ($price) use (&$hourlyPrices) {
            if (!$hourlyPrices->has($price->hour_id)) {
                $price->is_custom = false;
                $hourlyPrices->put($price->hour_id, $price);
            }
        });
    
        $hourlyPrices = $hourlyPrices->sortBy('serial_number')->values();
        $information['hourlyPrices'] = $hourlyPrices;
    
        // Fetch room reviews
        $reviews = RoomReview::where('room_id', $id)->orderByDesc('id')->get();
        $reviews->map(fn($review) => $review['user'] = $review->userInfo()->first());
        
        $information['reviews'] = $reviews;
        $information['numOfReview'] = count($reviews);
    
        // Fetch related rooms
        $rooms = RoomContent::join('rooms', 'rooms.id', '=', 'room_contents.room_id')
            ->join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
            ->join('room_categories', 'room_contents.room_category', '=', 'room_categories.id')
            ->join('hotel_contents', 'rooms.hotel_id', '=', 'hotel_contents.hotel_id')
            ->join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('room_categories.status', 1)
            ->where('hotel_categories.status', 1)
            ->where('room_contents.language_id', $language->id)
            ->where('rooms.status', 1)
            ->where('hotels.status', 1)
            ->where('rooms.id', '!=', $id)
            ->when($vendorId && $vendorId != 0, function ($query) {
                $query->join('memberships', 'rooms.vendor_id', '=', 'memberships.vendor_id')
                    ->where([
                        ['memberships.status', 1],
                        ['memberships.start_date', '<=', now()->format('Y-m-d')],
                        ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                    ]);
            })
            ->when($vendorId && $vendorId != 0, function ($query) {
                return $query->leftJoin('vendors', 'rooms.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where('vendors.status', 1)
                              ->orWhere('rooms.vendor_id', 0);
                    });
            })
            ->where('room_contents.room_category', $roomContent->room_category)
            ->select(
                'rooms.*',
                'room_contents.title',
                'room_contents.slug',
                'room_contents.amenities',
                'room_contents.meta_keyword',
                'room_contents.meta_description',
                'hotel_contents.address',
                'room_contents.description',
                'hotel_contents.title as hotelName',
                'hotel_contents.slug as hotelSlug',
                'hotels.id as hotelId',
                'hotels.stars as stars',
                'hotels.logo as hotelImage',
                'hotels.latitude as latitude',
                'hotels.longitude as longitude',
            )
            ->limit(4)
            ->get();
    
        $information['rooms'] = $rooms;
    
        return view('frontend.room.room-details', $information);
    }
    
        public function detailsData($slug, $id)
    {
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();
        
        // Get room content
        $roomContent = RoomContent::where('room_id', $id)
            ->where('language_id', $language->id)
            ->first();
            
        if (!$roomContent) {
            return response()->json(['error' => 'Room not found'], 404);
        }
        
        // Get room
        $room = Room::findOrFail($id);
        
        // Get room images
        $roomImages = RoomImage::where('room_id', $id)->get();
        $images = [];
        foreach ($roomImages as $image) {
            $images[] = [
                'url' => asset('assets/img/room/room-gallery/' . $image->image),
                'thumbnail' => asset('assets/img/room/room-gallery/' . $image->image)
            ];
        }
        
        // Get amenities
        $amenities = [];
        if ($roomContent->amenities) {
            $amenityIds = json_decode($roomContent->amenities);
            foreach ($amenityIds as $amenityId) {
                $amenity = \App\Models\Amenitie::find($amenityId);
                if ($amenity) {
                    $amenities[] = [
                        'title' => $amenity->title,
                        'icon' => $amenity->icon
                    ];
                }
            }
        }
        
        // Get pricing
        $pricing = [];
        $hourlyPrices = HourlyRoomPrice::where('room_id', $id)
            ->join('booking_hours', 'hourly_room_prices.hour_id', '=', 'booking_hours.id')
            ->whereNotNull('hourly_room_prices.price')
            ->orderBy('booking_hours.serial_number')
            ->select('hourly_room_prices.*', 'booking_hours.hour')
            ->get();
            
        foreach ($hourlyPrices as $price) {
            $pricing[] = [
                'duration' => $price->hour . ' Hrs',
                'price' => symbolPrice($price->price)
            ];
        }
        
        // Get location info
        $location = '';
        if ($room->city_id) {
            $city = \App\Models\Location\City::find($room->city_id);
            if ($city) $location .= $city->name;
        }
        if ($room->state_id) {
            $state = \App\Models\Location\State::find($room->state_id);
            if ($state) $location .= ($location ? ', ' : '') . $state->name;
        }
        if ($room->country_id) {
            $country = \App\Models\Location\Country::find($room->country_id);
            if ($country) $location .= ($location ? ', ' : '') . $country->name;
        }
        
        return response()->json([
            'id' => $room->id,
            'title' => $roomContent->title,
            'beds' => $room->bed ? $room->bed . ' Beds' : 'N/A',
            'bathrooms' => $room->bathroom ? $room->bathroom . ' Bathrooms' : 'N/A',
            'guests' => ($room->adult + $room->children) . ' Guests',
            'area' => $room->area ? $room->area . ' sq ft' : 'N/A',
            'location' => $location ?: 'N/A',
            'rating' => number_format($room->average_rating, 1) . ' (' . totalRoomReview($room->id) . ' reviews)',
            'images' => $images,
            'amenities' => $amenities,
            'pricing' => $pricing
        ]);
    }
    
    public function getPrice(Request $request, $slug, $id)
    {
        $check_in_time = date('H:i:s', strtotime($request->checkInTime));
        $check_in_date = date('Y-m-d', strtotime($request->checkInDates));
        $check_in_date_time = $check_in_date . ' ' . $check_in_time;
    
        $room = Room::findOrFail($id);
        $totalRoom = $room->number_of_rooms_of_this_same_type;
    
        $customPrices = CustomPricing::where('room_id', $id)
            ->whereDate('date', $check_in_date)
            ->with('bookingHour') 
            ->get();
    
        $holidays = Holiday::where('hotel_id', $id)->pluck('date')->toArray();
        $convertedHolidays = array_map(fn($date) => date('Y-m-d', strtotime($date)), $holidays);
    
        $preparation_time = $room->preparation_time;
        $maxhour = 99;
        $hours = BookingHour::orderBy('hour', 'desc')->get();
        $bookingStatus = false;
    
        foreach ($hours as $hour) {
            $check_out_time = date('H:i:s', strtotime($check_in_time . " +{$hour->hour} hour"));
            $next_booking_time = date('H:i:s', strtotime($check_out_time . " +$preparation_time min"));
    
            $checkoutDate = (strtotime($check_out_time) >= strtotime('23:59:59'))
                ? date('Y-m-d', strtotime($check_in_date . ' +1 day'))
                : $check_in_date;
    
            $check_out_date_time = $checkoutDate . ' ' . $next_booking_time;
    
            $totalBookingDone = Booking::where('room_id', $id)
                ->where('payment_status', '!=', 2)
                ->where(function ($query) use ($check_in_date_time, $check_out_date_time) {
                    $query->where(function ($q) use ($check_in_date_time, $check_out_date_time) {
                        $q->whereBetween('check_in_date_time', [$check_in_date_time, $check_out_date_time])
                            ->orWhereBetween('check_out_date_time', [$check_in_date_time, $check_out_date_time]);
                    })->orWhere(function ($q) use ($check_in_date_time, $check_out_date_time) {
                        $q->where('check_in_date_time', '<=', $check_in_date_time)
                            ->where('check_out_date_time', '>=', $check_out_date_time);
                    });
                })->count();
    
            if (in_array($checkoutDate, $convertedHolidays)) {
                $totalBookingDone = 999999;
            }
    
            if ($totalRoom > $totalBookingDone) {
                $bookingStatus = true;
                $maxhour = $hour->hour;
                break;
            }
        }
    
        if ($bookingStatus) {
            $hourlyPrices = HourlyRoomPrice::where('hourly_room_prices.room_id', $id)
                ->join('booking_hours', 'hourly_room_prices.hour_id', '=', 'booking_hours.id')
                ->orderBy('booking_hours.serial_number')
                ->where('hourly_room_prices.hour', '<=', $maxhour)
                ->select('hourly_room_prices.*', 'booking_hours.serial_number', 'booking_hours.hour')
                ->get();
    
            $customPricingMap = $customPrices->keyBy('booking_hours_id');
    
            $hourlyPrices->transform(function ($price) use ($customPricingMap) {
                if (isset($customPricingMap[$price->hour_id])) {
                    $price->price = $customPricingMap[$price->hour_id]->price;
                }
                return $price;
            });
    
            $information['hourlyPrices'] = $hourlyPrices;
        } else {
            $information['hourlyPrices'] = [];
        }
    
        return view('frontend.room.room-price', $information)->render();
    }
    public function storeReview(Request $request, $id)
    {

        $rule = ['rating' => 'required'];

        $validator = Validator::make($request->all(), $rule);

        if ($validator->fails()) {
            return redirect()->back()
                ->with('error', 'The rating field is required for product review.')
                ->withInput();
        }

        $user = Auth::guard('web')->user();

        if ($user) {

            $booking = Booking::Where([['user_id', $user->id], ['room_id', $id]])->get();

            if ($booking != '[]') {
                $room = Room::find($id);
                RoomReview::updateOrCreate(
                    ['user_id' => $user->id, 'room_id' => $id],
                    [
                        'review' => $request->review,
                        'rating' => $request->rating,
                        'hotel_id' => $room->hotel_id
                    ]
                );

                $roomreviews = RoomReview::where('room_id', $id)->get();
                $hotelreviews = RoomReview::where('hotel_id', $room->hotel_id)->get();

                $totalRating = 0;
                $totalhotelRating = 0;

                foreach ($roomreviews as $review) {
                    $totalRating += $review->rating;
                }

                $numOfReview = count($roomreviews);

                $averageRating = $totalRating / $numOfReview;


                foreach ($hotelreviews as $review) {
                    $totalhotelRating += $review->rating;
                }

                $numOfHotelReview = count($hotelreviews);

                $hotelaverageRating = $totalhotelRating / $numOfHotelReview;

                // finally, store the average rating of this hotel
                $room->update(['average_rating' => $averageRating]);
                Hotel::find($room->hotel_id)->update(['average_rating' => $hotelaverageRating]);

                Session::flash('success', 'Your review submitted successfully.');
            } else {
                Session::flash('error', 'You have to Booked First!');
            }
        } else {
        }
        return redirect()->back();
    }

    public function store_visitor(Request $request)
    {
        $request->validate([
            'room_id'
        ]);
        $ipAddress = \Request::ip();
        $check = Visitor::where([['room_id', $request->room_id], ['ip_address', $ipAddress], ['date', Carbon::now()->format('y-m-d')]])->first();
        $room = Room::where('id', $request->room_id)->first();
        if ($room) {
            if (!$check) {
                $visitor = new Visitor();
                $visitor->room_id = $request->room_id;
                $visitor->ip_address = $ipAddress;
                $visitor->vendor_id = $room->vendor_id;
                $visitor->date = Carbon::now()->format('y-m-d');
                $visitor->save();
            }
        }
    }

    public function filterByBounds(Request $request)
    {
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();

        // Get map bounds from request
        $north = $request->input('north');
        $south = $request->input('south');
        $east = $request->input('east');
        $west = $request->input('west');

        // Get other filter parameters
        $category = $request->input('category');
        $hotelId = $request->input('hotelId');
        $country = $request->input('country');
        $state = $request->input('state');
        $city = $request->input('city');
        $ratings = $request->input('ratings');
        $adult = $request->input('adult');
        $children = $request->input('children');
        $hour = $request->input('hour');
        $sort = $request->input('sort');

        // Initialize filter arrays
        $roomIds = [];
        $category_roomIds = [];
        $ratingIds = [];
        $adultIds = [];
        $childrenIds = [];
        $countryIds = [];
        $stateIds = [];
        $cityIds = [];

        // Apply filters
        if ($category) {
            $category_content = RoomCategory::where([['language_id', $language->id], ['slug', $category]])->first();
            if (!empty($category_content)) {
                $category_id = $category_content->id;
                $contents = RoomContent::where('language_id', $language->id)
                    ->where('room_category', $category_id)
                    ->get()
                    ->pluck('room_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $category_roomIds)) {
                        array_push($category_roomIds, $content);
                    }
                }
            }
        }

        if ($ratings) {
            $contents = Room::where('average_rating', '>=', $ratings)
                ->get()
                ->pluck('id');
            foreach ($contents as $content) {
                if (!in_array($content, $ratingIds)) {
                    array_push($ratingIds, $content);
                }
            }
        }

        if ($adult) {
            $contents = Room::where('adult', '>=', $adult)
                ->get()
                ->pluck('id');
            foreach ($contents as $content) {
                if (!in_array($content, $adultIds)) {
                    array_push($adultIds, $content);
                }
            }
        }

        if ($children) {
            $contents = Room::where('children', '>=', $children)
                ->get()
                ->pluck('id');
            foreach ($contents as $content) {
                if (!in_array($content, $childrenIds)) {
                    array_push($childrenIds, $content);
                }
            }
        }

        if ($country) {
            $hotel_contents = HotelContent::where('language_id', $language->id)
                ->where('country_id', $country)
                ->get()
                ->pluck('hotel_id');
            foreach ($hotel_contents as $hotel_content) {
                if (!in_array($hotel_content, $countryIds)) {
                    array_push($countryIds, $hotel_content);
                }
            }
        }

        if ($state) {
            $hotel_contents = HotelContent::where('language_id', $language->id)
                ->where('state_id', $state)
                ->get()
                ->pluck('hotel_id');
            foreach ($hotel_contents as $hotel_content) {
                if (!in_array($hotel_content, $stateIds)) {
                    array_push($stateIds, $hotel_content);
                }
            }
        }

        if ($city) {
            $hotel_contents = HotelContent::where('language_id', $language->id)
                ->where('city_id', $city)
                ->get()
                ->pluck('hotel_id');
            foreach ($hotel_contents as $hotel_content) {
                if (!in_array($hotel_content, $cityIds)) {
                    array_push($cityIds, $hotel_content);
                }
            }
        }

        // Set sort order
        if ($sort) {
            if ($sort == 'new') {
                $order_by_column = 'rooms.id';
                $order = 'desc';
            } elseif ($sort == 'old') {
                $order_by_column = 'rooms.id';
                $order = 'asc';
            } elseif ($sort == 'starhigh') {
                $order_by_column = 'hotels.stars';
                $order = 'desc';
            } elseif ($sort == 'starlow') {
                $order_by_column = 'hotels.stars';
                $order = 'asc';
            } elseif ($sort == 'reviewshigh') {
                $order_by_column = 'rooms.average_rating';
                $order = 'desc';
            } elseif ($sort == 'reviewslow') {
                $order_by_column = 'rooms.average_rating';
                $order = 'asc';
            } else {
                $order_by_column = 'rooms.id';
                $order = 'desc';
            }
        } else {
            $order_by_column = 'rooms.id';
            $order = 'desc';
        }

        // Build the query with map bounds filtering
        $query = RoomContent::join('rooms', 'rooms.id', '=', 'room_contents.room_id')
            ->Join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
            ->Join('room_categories', 'room_contents.room_category', '=', 'room_categories.id')
            ->Join('hotel_contents', 'rooms.hotel_id', '=', 'hotel_contents.hotel_id')
            ->Join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('room_categories.status', 1)
            ->where('hotel_categories.status', 1)
            ->where('room_contents.language_id', $language->id)
            ->where('rooms.status', '=', '1')
            ->where('hotels.status', '=', '1')
            ->when('rooms.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'rooms.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('rooms.vendor_id', '=', 0);
                    });
            })
            ->when('rooms.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'rooms.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('rooms.vendor_id', '=', 0);
                    });
            })
            ->when($hotelId, function ($query) use ($hotelId) {
                return $query->where('rooms.hotel_id', $hotelId);
            })
            ->when($category, function ($query) use ($category_roomIds) {
                return $query->whereIn('rooms.id', $category_roomIds);
            })
            ->when($ratings, function ($query) use ($ratingIds) {
                return $query->whereIn('rooms.id', $ratingIds);
            })
            ->when($adult, function ($query) use ($adultIds) {
                return $query->whereIn('rooms.id', $adultIds);
            })
            ->when($children, function ($query) use ($childrenIds) {
                return $query->whereIn('rooms.id', $childrenIds);
            })
            ->when($country, function ($query) use ($countryIds) {
                return $query->whereIn('rooms.hotel_id', $countryIds);
            })
            ->when($state, function ($query) use ($stateIds) {
                return $query->whereIn('rooms.hotel_id', $stateIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('rooms.hotel_id', $cityIds);
            });

        // Add map bounds filtering
        if ($north && $south && $east && $west) {
            $query->whereBetween('hotels.latitude', [$south, $north])
                  ->whereBetween('hotels.longitude', [$west, $east]);
        }

        $rooms = $query->select(
                'rooms.*',
                'room_contents.title',
                'room_contents.slug',
                'room_contents.description',
                'room_contents.amenities',
                'hotels.id as hotelId',
                'hotels.stars as stars',
                'hotels.latitude as latitude',
                'hotels.longitude as longitude',
                'hotels.logo as hotelImage',
                'hotel_contents.title as hotelName',
                'hotel_contents.slug as hotelSlug',
                'hotel_contents.city_id',
                'hotel_contents.state_id',
                'hotel_contents.country_id'
            )
            ->orderBy($order_by_column, $order)
            ->get();

        // Add amenities data to rooms
        $rooms = $rooms->map(function ($room) {
            if ($room->amenities) {
                $amenitiesArray = json_decode($room->amenities);
                $amenityNames = [];
                $amenityDetails = [];
                foreach ($amenitiesArray as $amenityId) {
                    $amenity = \App\Models\Amenitie::find($amenityId);
                    if ($amenity) {
                        $amenityNames[] = $amenity->title;
                        $amenityDetails[] = [
                            'id' => $amenity->id,
                            'title' => $amenity->title,
                            'icon' => $amenity->icon
                        ];
                    }
                }
                $room->amenity_names = $amenityNames;
                $room->amenity_details = $amenityDetails;
            } else {
                $room->amenity_names = [];
                $room->amenity_details = [];
            }
            return $room;
        });

        // Add 2-hour price data to rooms
        $rooms = $rooms->map(function ($room) {
            $twoHourPrice = HourlyRoomPrice::where('room_id', $room->id)
                ->where('hour_id', 1) // Assuming 1 is the 2-hour price ID
                ->first();
            
            $room->two_hour_price = $twoHourPrice ? '$' . $twoHourPrice->price : '$50';
            return $room;
        });

        return response()->json([
            'success' => true,
            'rooms' => $rooms,
            'count' => $rooms->count()
        ]);
    }

    public function getAvailableTimeSlots(Request $request)
    {
        $roomId = $request->roomId;
        $date = $request->date;
        
        if (!$roomId || !$date) {
            return response()->json([
                'success' => false,
                'message' => 'Room ID and date are required'
            ]);
        }

        // Get the room and its hotel
        $room = Room::findOrFail($roomId);
        $hotel = Hotel::findOrFail($room->hotel_id);
        
        // Get the day of week from the date
        $dayOfWeek = strtolower(date('l', strtotime($date)));
        $slotColumn = $dayOfWeek . '_slots';
        
        // Get the time slots for that day
        $timeSlots = [];
        if ($hotel->$slotColumn) {
            $slots = json_decode($hotel->$slotColumn, true);
            if (is_array($slots)) {
                foreach ($slots as $slot) {
                    if (isset($slot['start']) && isset($slot['end'])) {
                        // Generate multiple time slots within the start and end time range
                        $startTime = $slot['start'];
                        $endTime = $slot['end'];
                        
                        // Convert times to minutes for easier manipulation
                        $startMinutes = $this->timeToMinutes($startTime);
                        $endMinutes = $this->timeToMinutes($endTime);
                        
                        // Generate time slots every 30 minutes (like the blade system)
                        $interval = 30; // 30 minutes
                        
                        for ($currentMinutes = $startMinutes; $currentMinutes < $endMinutes; $currentMinutes += $interval) {
                            $currentTime = $this->minutesToTime($currentMinutes);
                            $nextTime = $this->minutesToTime($currentMinutes + $interval);
                            
                            // Only add if the next time doesn't exceed the end time
                            if ($currentMinutes + $interval <= $endMinutes) {
                                $timeSlots[] = [
                                    'start_time' => $currentTime,
                                    'end_time' => $nextTime
                                ];
                            }
                        }
                        
                        // Add the final slot if there's remaining time
                        $remainingMinutes = $endMinutes - $startMinutes;
                        if ($remainingMinutes > 0 && $remainingMinutes % $interval != 0) {
                            $lastStartMinutes = $startMinutes + (floor($remainingMinutes / $interval) * $interval);
                            if ($lastStartMinutes < $endMinutes) {
                                $timeSlots[] = [
                                    'start_time' => $this->minutesToTime($lastStartMinutes),
                                    'end_time' => $endTime
                                ];
                            }
                        }
                    }
                }
            }
        }
        
        return response()->json([
            'success' => true,
            'timeSlots' => $timeSlots
        ]);
    }

    public function getCustomPricing(Request $request)
    {
        $roomId = $request->roomId;
        $date = $request->date;
        
        if (!$roomId || !$date) {
            return response()->json([
                'success' => false,
                'message' => 'Room ID and date are required'
            ]);
        }

        // Get the room to find its hotel_id
        $room = Room::findOrFail($roomId);
        
        // Get custom pricing for this room, date, and hotel
        $customPricings = CustomPricing::where('room_id', $roomId)
            ->where('hotel_id', $room->hotel_id)
            ->where('date', $date)
            ->with('bookingHour')
            ->get();

        // Get default hourly prices for this room
        $defaultPrices = HourlyRoomPrice::where('room_id', $roomId)
            ->join('booking_hours', 'hourly_room_prices.hour_id', '=', 'booking_hours.id')
            ->orderBy('booking_hours.serial_number')
            ->select('hourly_room_prices.*', 'booking_hours.hour')
            ->get();

        // Merge custom pricing with default pricing
        $hourlyPrices = [];
        foreach ($defaultPrices as $defaultPrice) {
            $customPrice = $customPricings->where('booking_hours_id', $defaultPrice->hour_id)->first();
            
            $hourlyPrices[] = [
                'hour_id' => $defaultPrice->hour_id,
                'hour' => $defaultPrice->hour,
                'price' => $customPrice ? $customPrice->price : $defaultPrice->price,
                'is_custom' => $customPrice ? true : false
            ];
        }

        return response()->json([
            'success' => true,
            'hourlyPrices' => $hourlyPrices,
            'hasCustomPricing' => $customPricings->count() > 0
        ]);
    }
    
    private function timeToMinutes($time)
    {
        // Handle different time formats (e.g., "11:00 AM", "11:00", "23:00")
        $time = trim($time);
        
        // If time contains AM/PM, convert to 24-hour format
        if (stripos($time, 'AM') !== false || stripos($time, 'PM') !== false) {
            $time = date('H:i', strtotime($time));
        }
        
        $parts = explode(':', $time);
        $hours = (int)$parts[0];
        $minutes = isset($parts[1]) ? (int)$parts[1] : 0;
        
        return $hours * 60 + $minutes;
    }
    
    private function minutesToTime($minutes)
    {
        $hours = floor($minutes / 60);
        $mins = $minutes % 60;
        
        // Format as 12-hour time with AM/PM
        $time = sprintf('%02d:%02d', $hours, $mins);
        $formattedTime = date('g:i A', strtotime($time));
        
        return $formattedTime;
    }

    public function getRoomGallery($roomId)
    {
        try {
            $room = Room::findOrFail($roomId);
            $galleryImages = $room->room_galleries()->get();
            
            return response()->json([
                'success' => true,
                'images' => $galleryImages
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Room not found or error occurred',
                'error' => $e->getMessage()
            ]);
        }
    }

    public function getRoomImages(Request $request)
    {
        try {
            $roomId = $request->roomId;
            
            if (!$roomId) {
                return response()->json([
                    'success' => false,
                    'message' => 'Room ID is required'
                ]);
            }

            // Get room images from the room_images table
            $roomImages = RoomImage::where('room_id', $roomId)
                ->orderBy('id', 'asc')
                ->get(['id', 'room_id', 'image']);
            
            return response()->json([
                'success' => true,
                'roomImages' => $roomImages
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error occurred while fetching room images',
                'error' => $e->getMessage()
            ]);
        }
    }

    public function getRoomAmenities(Request $request)
    {
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();
        
        $roomId = $request->input('roomId');
        
        if (!$roomId) {
            return response()->json([
                'success' => false,
                'message' => 'Room ID is required'
            ], 400);
        }
        
        // Get room content
        $roomContent = RoomContent::where('room_id', $roomId)
            ->where('language_id', $language->id)
            ->first();
            
        if (!$roomContent) {
            return response()->json([
                'success' => false,
                'message' => 'Room not found'
            ], 404);
        }
        
        // Get amenities with full details
        $amenities = [];
        if ($roomContent->amenities) {
            $amenityIds = json_decode($roomContent->amenities);
            foreach ($amenityIds as $amenityId) {
                $amenity = \App\Models\Amenitie::find($amenityId);
                if ($amenity) {
                    $amenities[] = [
                        'id' => $amenity->id,
                        'title' => $amenity->title,
                        'icon' => $amenity->icon
                    ];
                }
            }
        }
        
        return response()->json([
            'success' => true,
            'amenities' => $amenities
        ]);
    }

    /**
     * API endpoint for searching rooms (used by React frontend)
     */
    public function apiSearchRooms(Request $request)
    {
        try {
            $misc = new MiscellaneousController();
            $language = $misc->getLanguage();
            
            // Get search parameters
            $activity = $request->input('activity');
            $location = $request->input('location');
            $date = $request->input('date');
            $priceRange = $request->input('priceRange');
            $rating = $request->input('rating');
            $amenities = $request->input('amenities');
            $sortBy = $request->input('sortBy', 'relevance');
            
            // Build the base query
            $query = Room::join('room_contents', 'rooms.id', '=', 'room_contents.room_id')
                ->join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
                ->join('hotel_contents', 'rooms.hotel_id', '=', 'hotel_contents.hotel_id')
                ->where('room_contents.language_id', $language->id)
                ->where('hotel_contents.language_id', $language->id)
                ->where('rooms.status', 1)
                ->where('hotels.status', 1);
            
            // Filter by activity (room title)
            if ($activity) {
                $query->where('room_contents.title', 'like', '%' . $activity . '%');
            }
            
            // Filter by location
            if ($location) {
                $query->where(function($q) use ($location) {
                    $q->where('hotel_contents.address', 'like', '%' . $location . '%')
                      ->orWhere('hotel_contents.city_id', 'like', '%' . $location . '%')
                      ->orWhere('hotel_contents.state_id', 'like', '%' . $location . '%')
                      ->orWhere('hotel_contents.country_id', 'like', '%' . $location . '%');
                });
            }
            
            // Filter by price range
            if ($priceRange) {
                switch ($priceRange) {
                    case '0-100':
                        $query->where('rooms.price', '<=', 100);
                        break;
                    case '100-200':
                        $query->whereBetween('rooms.price', [100, 200]);
                        break;
                    case '200-300':
                        $query->whereBetween('rooms.price', [200, 300]);
                        break;
                    case '300+':
                        $query->where('rooms.price', '>=', 300);
                        break;
                }
            }
            
            // Filter by rating
            if ($rating) {
                $query->where('hotels.average_rating', '>=', $rating);
            }
            
            // Filter by amenities
            if ($amenities && is_array($amenities)) {
                foreach ($amenities as $amenity) {
                    $query->whereRaw("JSON_CONTAINS(room_contents.amenities, ?)", [json_encode($amenity)]);
                }
            }
            
            // Apply sorting
            switch ($sortBy) {
                case 'price-low':
                    $query->orderBy('rooms.price', 'asc');
                    break;
                case 'price-high':
                    $query->orderBy('rooms.price', 'desc');
                    break;
                case 'rating':
                    $query->orderBy('hotels.average_rating', 'desc');
                    break;
                case 'relevance':
                default:
                    $query->orderBy('rooms.id', 'desc');
                    break;
            }
            
            // Get results with pagination
            $rooms = $query->select(
                'rooms.*',
                'room_contents.title',
                'room_contents.slug',
                'room_contents.amenities',
                'room_contents.description',
                'hotels.id as hotelId',
                'hotels.stars as stars',
                'hotels.average_rating',
                'hotels.latitude as latitude',
                'hotels.longitude as longitude',
                'hotels.logo as hotelImage',
                'hotel_contents.title as hotelName',
                'hotel_contents.address as hotelAddress',
                'hotel_contents.city_id',
                'hotel_contents.state_id',
                'hotel_contents.country_id'
            )
            ->paginate(12);
            
            // Transform the data for frontend consumption
            $transformedRooms = $rooms->getCollection()->map(function ($room) {
                // Get room images
                $roomImages = RoomImage::where('room_id', $room->id)->first();
                $imageUrl = null;
                
                if ($roomImages && $roomImages->image) {
                    // Construct full URL for React frontend
                    $baseUrl = request()->getSchemeAndHttpHost();
                    $imageUrl = $baseUrl . '/assets/img/room/featureImage/' . $roomImages->image;
                } elseif ($room->hotelImage) {
                    // Fallback to hotel image if room image not available
                    $baseUrl = request()->getSchemeAndHttpHost();
                    $imageUrl = $baseUrl . '/assets/img/hotel/' . $room->hotelImage;
                }
                
                // Get amenities names
                $amenityNames = [];
                if ($room->amenities) {
                    $amenityIds = json_decode($room->amenities);
                    foreach ($amenityIds as $amenityId) {
                        $amenity = \App\Models\Amenitie::find($amenityId);
                        if ($amenity) {
                            $amenityNames[] = $amenity->title;
                        }
                    }
                }
                
                return [
                    'id' => $room->id,
                    'name' => $room->title,
                    'slug' => $room->slug,
                    'location' => $room->hotelAddress ?: 'Location not specified',
                    'price' => '$' . number_format($room->price, 2) . '/night',
                    'rating' => $room->average_rating ?: 0,
                    'stars' => $room->stars ?: 0,
                    'image' => $imageUrl,
                    'amenities' => $amenityNames,
                    'description' => $room->description ?: 'No description available',
                    'hotelId' => $room->hotelId,
                    'hotelName' => $room->hotelName,
                    'latitude' => $room->latitude,
                    'longitude' => $room->longitude
                ];
            });
            
            return response()->json([
                'success' => true,
                'data' => [
                    'rooms' => $transformedRooms,
                    'pagination' => [
                        'current_page' => $rooms->currentPage(),
                        'last_page' => $rooms->lastPage(),
                        'per_page' => $rooms->perPage(),
                        'total' => $rooms->total()
                    ]
                ]
            ]);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error occurred while searching rooms',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
