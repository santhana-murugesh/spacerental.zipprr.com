<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use App\Http\Controllers\FrontEnd\MiscellaneousController;
use App\Models\Admin;
use App\Models\BasicSettings\Basic;
use App\Models\Booking;
use App\Models\BookingHour;
use App\Models\Holiday;
use App\Models\HomePage\CounterInformation;
use App\Models\HomePage\SectionContent;
use App\Models\HomePage\Testimony\Testimonial;
use App\Models\Hotel;
use App\Models\HotelCategory;
use App\Models\HotelContent;
use App\Models\HotelCounter;
use App\Models\HotelImage;
use App\Models\HourlyRoomPrice;
use App\Models\Journal\Blog;
use App\Models\Language;
use App\Models\Location\City;
use App\Models\Location\Country;
use App\Models\Location\State;
use App\Models\Room;
use App\Models\RoomContent;
use App\Models\RoomReview;
use App\Models\Vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;

class HotelController extends Controller
{
    public function getState(Request $request)
    {
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();
        if ($request->id) {
            $data['states'] = State::where('country_id', $request->id)->get();
            $data['cities'] = City::where('country_id', $request->id)->get();
        } else {
            $data['states'] = State::where('language_id', $language->id)->get();
            $data['cities'] = City::where('language_id', $language->id)->get();
        }

        return $data;
    }
    public function getCity(Request $request)
    {
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();
        if ($request->id) {
            $data = City::where('state_id', $request->id)->get();
        } else {
            $data = City::where('language_id', $language->id)->get();
        }
        return $data;
    }

    public function index(Request $request)
    {
        $view = Basic::query()->pluck('hotel_view')->first();
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();

        $information['bgImg'] = $misc->getBreadcrumb();

        $information['pageHeading'] = $misc->getPageHeading($language);

        $information['language'] = $language;
        $information['seoInfo'] = $language->seoInfo()->select('meta_keyword_hotels', 'meta_description_hotels')->first();

        $information['currencyInfo'] = $this->getCurrencyInfo();

        $title = $address = $category  = $ratings  = $country = $state = $city = $location =  null;

        $hotelIds = [];
        if ($request->filled('title')) {
            $title = $request->title;
            $hotel_contents = HotelContent::where('language_id', $language->id)
                ->where('title', 'like', '%' . $title . '%')
                ->get()
                ->pluck('hotel_id');
            foreach ($hotel_contents as $hotel_content) {
                if (!in_array($hotel_content, $hotelIds)) {
                    array_push($hotelIds, $hotel_content);
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


        $category_hotelIds = [];
        if ($request->filled('category')) {
            $category = $request->category;

            $category_content = HotelCategory::where([['language_id', $language->id], ['slug', $category]])->first();

            if (!empty($category_content)) {
                $category_id = $category_content->id;
                $contents = HotelContent::where('language_id', $language->id)
                    ->where('category_id', $category_id)
                    ->get()
                    ->pluck('hotel_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $category_hotelIds)) {
                        array_push($category_hotelIds, $content);
                    }
                }
            }
        }

        $ratingIds = [];
        if ($request->filled('ratings')) {
            $ratings = $request->ratings;
            $contents = Hotel::where('average_rating', '>=', $ratings)
                ->get()
                ->pluck('id');
            foreach ($contents as $content) {
                if (!in_array($content, $ratingIds)) {
                    array_push($ratingIds, $content);
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
                $order_by_column = 'hotels.id';
                $order = 'desc';
            } elseif ($request['sort'] == 'old') {
                $order_by_column = 'hotels.id';
                $order = 'asc';
            } else {
                $order_by_column = 'hotels.id';
                $order = 'desc';
            }
        } else {
            $order_by_column = 'hotels.id';
            $order = 'desc';
        }


        $featured_contents = Hotel::join('hotel_contents', 'hotel_contents.hotel_id', '=', 'hotels.id')
            ->Join('hotel_features', 'hotels.id', '=', 'hotel_features.hotel_id')
            ->join('hotel_categories', 'hotel_categories.id', '=', 'hotel_contents.category_id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('hotel_categories.status', 1)
            ->where('hotel_features.order_status', '=', 'apporved')
            ->where('hotels.status',  '=',  '1')
            ->has('room')
            ->whereDate('hotel_features.end_date', '>=', Carbon::now()->format('Y-m-d'))
            ->when('hotels.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'hotels.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('hotels.vendor_id', '=', 0);
                    });
            })
            ->when('hotels.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'hotels.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('hotels.vendor_id', '=', 0);
                    });
            })

            ->when($title, function ($query) use ($hotelIds) {
                return $query->whereIn('hotels.id', $hotelIds);
            })

            ->when($category, function ($query) use ($category_hotelIds) {
                return $query->whereIn('hotels.id', $category_hotelIds);
            })

            ->when($ratings, function ($query) use ($ratingIds) {
                return $query->whereIn('hotels.id', $ratingIds);
            })

            ->when($country, function ($query) use ($countryIds) {
                return $query->whereIn('hotels.id', $countryIds);
            })
            ->when($state, function ($query) use ($stateIds) {
                return $query->whereIn('hotels.id', $stateIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('hotels.id', $cityIds);
            })
            ->when($address, function ($query) use ($addressIds) {
                return $query->whereIn('hotels.id', $addressIds);
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
                'hotels.*',
                'hotel_contents.title',
                'hotel_contents.slug',
                'hotel_contents.city_id',
                'hotel_contents.state_id',
                'hotel_contents.country_id',
                'hotel_contents.amenities',
                'hotel_categories.name as categoryName',
                'hotel_categories.slug as categorySlug',
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


        $hotel_contentss = Hotel::join('hotel_contents', 'hotel_contents.hotel_id', '=', 'hotels.id')
            ->join('hotel_categories', 'hotel_categories.id', '=', 'hotel_contents.category_id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('hotels.status', '=',  '1')
            ->where('hotel_categories.status', 1)
            ->has('room')
            ->when('hotels.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'hotels.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('hotels.vendor_id', '=', 0);
                    });
            })
            ->when('hotels.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'hotels.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('hotels.vendor_id', '=', 0);
                    });
            })
            ->when($title, function ($query) use ($hotelIds) {
                return $query->whereIn('hotels.id', $hotelIds);
            })
            ->when($category, function ($query) use ($category_hotelIds) {
                return $query->whereIn('hotels.id', $category_hotelIds);
            })

            ->when($country, function ($query) use ($countryIds) {
                return $query->whereIn('hotels.id', $countryIds);
            })
            ->when($state, function ($query) use ($stateIds) {
                return $query->whereIn('hotels.id', $stateIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('hotels.id', $cityIds);
            })
            ->when($featured_contents, function ($query) use ($featured_contentsIds) {
                return $query->whereNotIn('hotels.id', $featured_contentsIds);
            })
            ->when($ratings, function ($query) use ($ratingIds) {
                return $query->whereIn('hotels.id', $ratingIds);
            })
            ->when($address, function ($query) use ($addressIds) {
                return $query->whereIn('hotels.id', $addressIds);
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
                'hotels.*',
                'hotel_contents.title',
                'hotel_contents.slug',
                'hotel_contents.city_id',
                'hotel_contents.state_id',
                'hotel_contents.country_id',
                'hotel_contents.amenities',
                'hotel_categories.name as categoryName',
                'hotel_categories.slug as categorySlug',
            )
            ->orderBy($order_by_column, $order)
            ->get();

        if ($totalFeatured_content == 3) {
            $perPage = 12;
        } elseif ($totalFeatured_content == 2) {
            $perPage = 13;
        } elseif ($totalFeatured_content == 1) {
            $perPage = 14;
        } else {
            $perPage = 15;
        }

        $page = 1;

        $offset = ($page - 1) * $perPage;

        $currentPageData = $hotel_contentss->slice($offset, $perPage);

        $information['categories'] = HotelCategory::where('language_id', $language->id)->where('status', 1)
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

        $information['hotel_contentss'] = $hotel_contentss;
        $information['featured_contents'] = $featured_contents;
        $information['currentPageData'] = $currentPageData;
        $information['perPage'] = $perPage;

        $information['bookingHours'] =  BookingHour::orderBy('hour', 'desc')->get();

        if ($view == 0) {
            return view('frontend.hotel.hotel-map', $information);
        } else {
            return view('frontend.hotel.hotel-gird', $information);
        }
    }

    public function search_hotel(Request $request)
    {
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();
        $information['language'] = $language;

        $information['currencyInfo'] = $this->getCurrencyInfo();
        $title = $address = $category  = $ratings = $stars = $checkInDates = $country = $state = $city = $location = null;

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
            $checkInTimes = '00:00:00';
        }

        $hourIds = [];
        if ($request->filled('hour')) {
            $hour = $request->hour;

            $hourhave = 'yes';

            $prices = HourlyRoomPrice::where([
                ['hour', $hour]
            ])
                ->whereNotNull('price')
                ->get()
                ->pluck('hotel_id');

            foreach ($prices as $price) {
                if (!in_array($price, $hourIds)) {
                    array_push($hourIds, $price);
                }
            }
        } else {
            $hour  = BookingHour::min('hour');
            $hourhave = null;
        }

        $hoteltimeIds = [];
        $hotelholidayIds = [];

        if ($checkInDates) {

            $hotels = Hotel::join('hotel_contents', 'hotel_contents.hotel_id', '=', 'hotels.id')
                ->join('hotel_categories', 'hotel_categories.id', '=', 'hotel_contents.category_id')
                ->where([['hotel_categories.status', 1], ['hotels.status', 1]])
                ->where('hotel_contents.language_id', $language->id)
                ->where('hotel_categories.status', 1)
                ->has('room')
                ->when('hotels.vendor_id' != "0", function ($query) {
                    return $query->leftJoin('memberships', 'hotels.vendor_id', '=', 'memberships.vendor_id')
                        ->where(function ($query) {
                            $query->where([
                                ['memberships.status', '=', 1],
                                ['memberships.start_date', '<=', now()->format('Y-m-d')],
                                ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                            ])->orWhere('hotels.vendor_id', '=', 0);
                        });
                })
                ->when('hotels.vendor_id' != "0", function ($query) {
                    return $query->leftJoin('vendors', 'hotels.vendor_id', '=', 'vendors.id')
                        ->where(function ($query) {
                            $query->where([
                                ['vendors.status', '=', 1],
                            ])->orWhere('hotels.vendor_id', '=', 0);
                        });
                })

                ->select('hotels.id')
                ->get();


            foreach ($hotels as $hotel) {

                $rooms = Room::where([['hotel_id', $hotel->id], ['status', 1]])->get();

                $totalHotelRoom = 0;
                $totalHotelRoomCount = count($rooms);

                foreach ($rooms as $room) {

                    $id = $room->id;

                    $check_in_time = date('H:i:s', strtotime($checkInTimes));
                    $check_in_date = date('Y-m-d', strtotime($checkInDates));
                    $check_in_date_time = $check_in_date . ' ' . $check_in_time;


                    $totalRoom = $room->number_of_rooms_of_this_same_type;
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
                    $convertedHolidays = array_map(function ($holiday) {
                        return \DateTime::createFromFormat('m/d/Y', $holiday)->format('Y-m-d');
                    }, $holidays);

                    if (!in_array($checkoutDate, $convertedHolidays)) {

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
                        $totalHotelRoom = $totalHotelRoom + 1;
                    }
                }

                if ($totalHotelRoomCount == $totalHotelRoom) {
                    if (!in_array($hotel->id, $hoteltimeIds)) {
                        array_push($hoteltimeIds, $hotel->id);
                    }
                }
            }



            foreach ($hotels as $hotel) {

                $holiday = Holiday::Where('hotel_id', $hotel->id)->get();

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

                $check_in_date = date('Y-m-d', strtotime($checkInDates));

                if (in_array($check_in_date, $convertedHolidays)) {

                    if (!in_array($hotel->id, $hotelholidayIds)) {
                        array_push($hotelholidayIds, $hotel->id);
                    }
                }
            }
        }


        $hotelIds = [];
        if ($request->filled('title')) {
            $title = $request->title;
            $hotel_contents = HotelContent::where('language_id', $language->id)
                ->where('title', 'like', '%' . $title . '%')
                ->get()
                ->pluck('hotel_id');
            foreach ($hotel_contents as $hotel_content) {
                if (!in_array($hotel_content, $hotelIds)) {
                    array_push($hotelIds, $hotel_content);
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

        $category_hotelIds = [];
        if ($request->filled('category')) {
            $category = $request->category;

            $category_content = HotelCategory::where([['language_id', $language->id], ['slug', $category]])->first();

            if (!empty($category_content)) {
                $category_id = $category_content->id;
                $contents = HotelContent::where('language_id', $language->id)
                    ->where('category_id', $category_id)
                    ->get()
                    ->pluck('hotel_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $category_hotelIds)) {
                        array_push($category_hotelIds, $content);
                    }
                }
            }
        }

        $ratingIds = [];
        if ($request->filled('ratings')) {
            $ratings = $request->ratings;
            $contents = Hotel::where('average_rating', '>=', $ratings)
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
                $order_by_column = 'hotels.id';
                $order = 'desc';
            } elseif ($request['sort'] == 'old') {
                $order_by_column = 'hotels.id';
                $order = 'asc';
            } elseif ($request['sort'] == 'starhigh') {
                $order_by_column = 'hotels.stars';
                $order = 'desc';
            } elseif ($request['sort'] == 'starlow') {
                $order_by_column = 'hotels.stars';
                $order = 'asc';
            } elseif ($request['sort'] == 'reviewshigh') {
                $order_by_column = 'hotels.average_rating';
                $order = 'desc';
            } elseif ($request['sort'] == 'reviewslow') {
                $order_by_column = 'hotels.average_rating';
                $order = 'asc';
            } else {
                $order_by_column = 'hotels.id';
                $order = 'desc';
            }
        } else {
            $order_by_column = 'hotels.id';
            $order = 'desc';
        }

        $featured_contents = Hotel::join('hotel_contents', 'hotel_contents.hotel_id', '=', 'hotels.id')
            ->Join('hotel_features', 'hotels.id', '=', 'hotel_features.hotel_id')
            ->join('hotel_categories', 'hotel_categories.id', '=', 'hotel_contents.category_id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('hotel_features.order_status', '=', 'apporved')
            ->where('hotels.status',  '=',  '1')
            ->where('hotel_categories.status', 1)
            ->has('room')
            ->whereDate('hotel_features.end_date', '>=', Carbon::now()->format('Y-m-d'))
            ->when('hotels.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'hotels.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('hotels.vendor_id', '=', 0);
                    });
            })
            ->when('hotels.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'hotels.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('hotels.vendor_id', '=', 0);
                    });
            })


            ->when($title, function ($query) use ($hotelIds) {
                return $query->whereIn('hotels.id', $hotelIds);
            })

            ->when($category, function ($query) use ($category_hotelIds) {
                return $query->whereIn('hotels.id', $category_hotelIds);
            })
            ->when($ratings, function ($query) use ($ratingIds) {
                return $query->whereIn('hotels.id', $ratingIds);
            })
            ->when($stars, function ($query) use ($starsIds) {
                return $query->whereIn('hotels.id', $starsIds);
            })
            ->when($hourhave, function ($query) use ($hourIds) {
                return $query->whereIn('hotels.id', $hourIds);
            })
            ->when($country, function ($query) use ($countryIds) {
                return $query->whereIn('hotels.id', $countryIds);
            })
            ->when($checkInDates, function ($query) use ($hoteltimeIds) {
                return $query->whereNotIn('hotels.id', $hoteltimeIds);
            })
            ->when($checkInDates, function ($query) use ($hotelholidayIds) {
                return $query->whereNotIn('hotels.id', $hotelholidayIds);
            })
            ->when($state, function ($query) use ($stateIds) {
                return $query->whereIn('hotels.id', $stateIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('hotels.id', $cityIds);
            })
            ->when($address, function ($query) use ($addressIds) {
                return $query->whereIn('hotels.id', $addressIds);
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
                'hotels.*',
                'hotel_contents.title',
                'hotel_contents.slug',
                'hotel_contents.city_id',
                'hotel_contents.state_id',
                'hotel_contents.country_id',
                'hotel_contents.amenities',
                'hotel_categories.name as categoryName',
                'hotel_categories.slug as categorySlug',
                \DB::raw('(SELECT COUNT(*) FROM rooms WHERE rooms.hotel_id = hotels.id AND rooms.status = 1) as room_count'),
                \DB::raw('(SELECT COUNT(*) FROM room_reviews WHERE room_reviews.hotel_id = hotels.id) as hotel_reviews_count')
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

        $hotel_contentss = Hotel::join('hotel_contents', 'hotel_contents.hotel_id', '=', 'hotels.id')
            ->join('hotel_categories', 'hotel_categories.id', '=', 'hotel_contents.category_id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('hotels.status', '=',  '1')
            ->where('hotel_categories.status', 1)
            ->has('room')
            ->when('hotels.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'hotels.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('hotels.vendor_id', '=', 0);
                    });
            })
            ->when('hotels.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'hotels.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('hotels.vendor_id', '=', 0);
                    });
            })
            ->when($title, function ($query) use ($hotelIds) {
                return $query->whereIn('hotels.id', $hotelIds);
            })

            ->when($category, function ($query) use ($category_hotelIds) {
                return $query->whereIn('hotels.id', $category_hotelIds);
            })

            ->when($country, function ($query) use ($countryIds) {
                return $query->whereIn('hotels.id', $countryIds);
            })
            ->when($state, function ($query) use ($stateIds) {
                return $query->whereIn('hotels.id', $stateIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('hotels.id', $cityIds);
            })
            ->when($featured_contents, function ($query) use ($featured_contentsIds) {
                return $query->whereNotIn('hotels.id', $featured_contentsIds);
            })
            ->when($checkInDates, function ($query) use ($hoteltimeIds) {
                return $query->whereNotIn('hotels.id', $hoteltimeIds);
            })
            ->when($checkInDates, function ($query) use ($hotelholidayIds) {
                return $query->whereNotIn('hotels.id', $hotelholidayIds);
            })
            ->when($ratings, function ($query) use ($ratingIds) {
                return $query->whereIn('hotels.id', $ratingIds);
            })
            ->when($stars, function ($query) use ($starsIds) {
                return $query->whereIn('hotels.id', $starsIds);
            })
            ->when($hourhave, function ($query) use ($hourIds) {
                return $query->whereIn('hotels.id', $hourIds);
            })
            ->when($address, function ($query) use ($addressIds) {
                return $query->whereIn('hotels.id', $addressIds);
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
                'hotels.*',
                'hotel_contents.title',
                'hotel_contents.slug',
                'hotel_contents.city_id',
                'hotel_contents.state_id',
                'hotel_contents.country_id',
                'hotel_contents.amenities',
                'hotel_categories.name as categoryName',
                'hotel_categories.slug as categorySlug',
                \DB::raw('(SELECT COUNT(*) FROM rooms WHERE rooms.hotel_id = hotels.id AND rooms.status = 1) as room_count'),
                \DB::raw('(SELECT COUNT(*) FROM room_reviews WHERE room_reviews.hotel_id = hotels.id) as hotel_reviews_count')
            )
            ->orderBy($order_by_column, $order)
            ->get();

        if ($totalFeatured_content == 3) {
            $perPage = 12;
        } elseif ($totalFeatured_content == 2) {
            $perPage = 13;
        } elseif ($totalFeatured_content == 1) {
            $perPage = 14;
        } else {
            $perPage = 15;
        }

        $page = $request->query('page');

        $offset = ($page - 1) * $perPage;

        // Get the subset of data for the current page
        $currentPageData = $hotel_contentss->slice($offset, $perPage);


        
        $information['hotel_contentss'] = $hotel_contentss;
        $information['featured_contents'] = $featured_contents;
        $information['currentPageData'] = $currentPageData;
        $information['perPage'] = $perPage;

        return view('frontend.hotel.search-hotel', $information)->render();
    }

    public function filterByBounds(Request $request)
    {
        // Return all hotels regardless of language
        // Frontend will handle language filtering
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
        $stars = $request->input('stars');
        $sort = $request->input('sort');

        // Initialize filter arrays
        $category_hotelIds = [];
        $ratingIds = [];
        $starsIds = [];
        $countryIds = [];
        $stateIds = [];
        $cityIds = [];

        // Apply filters
        if ($category) {
            $category_content = \App\Models\HotelCategory::where('slug', $category)->first();
            if (!empty($category_content)) {
                $category_id = $category_content->id;
                $contents = HotelContent::where('category_id', $category_id)
                    ->get()
                    ->pluck('hotel_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $category_hotelIds)) {
                        array_push($category_hotelIds, $content);
                    }
                }
            }
        }

        if ($ratings) {
            $contents = Hotel::where('average_rating', '>=', $ratings)
                ->get()
                ->pluck('id');
            foreach ($contents as $content) {
                if (!in_array($content, $ratingIds)) {
                    array_push($ratingIds, $content);
                }
            }
        }

        if ($stars) {
            $contents = Hotel::where('stars', $stars)
                ->get()
                ->pluck('id');
            foreach ($contents as $content) {
                if (!in_array($content, $starsIds)) {
                    array_push($starsIds, $content);
                }
            }
        }

        if ($country) {
            $hotel_contents = HotelContent::where('country_id', $country)
                ->get()
                ->pluck('hotel_id');
            foreach ($hotel_contents as $hotel_content) {
                if (!in_array($hotel_content, $countryIds)) {
                    array_push($countryIds, $hotel_content);
                }
            }
        }

        if ($state) {
            $hotel_contents = HotelContent::where('state_id', $state)
                ->get()
                ->pluck('hotel_id');
            foreach ($hotel_contents as $hotel_content) {
                if (!in_array($hotel_content, $stateIds)) {
                    array_push($stateIds, $hotel_content);
                }
            }
        }

        if ($city) {
            $hotel_contents = HotelContent::where('city_id', $city)
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
                $order_by_column = 'hotels.id';
                $order = 'desc';
            } elseif ($sort == 'old') {
                $order_by_column = 'hotels.id';
                $order = 'asc';
            } elseif ($sort == 'starhigh') {
                $order_by_column = 'hotels.stars';
                $order = 'desc';
            } elseif ($sort == 'starlow') {
                $order_by_column = 'hotels.stars';
                $order = 'asc';
            } elseif ($sort == 'reviewshigh') {
                $order_by_column = 'hotels.average_rating';
                $order = 'desc';
            } elseif ($sort == 'reviewslow') {
                $order_by_column = 'hotels.average_rating';
                $order = 'asc';
            } else {
                $order_by_column = 'hotels.id';
                $order = 'desc';
            }
        } else {
            $order_by_column = 'hotels.id';
            $order = 'desc';
        }

        // Build the query with map bounds filtering
        $query = HotelContent::join('hotels', 'hotels.id', '=', 'hotel_contents.hotel_id')
            ->Join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
            ->where('hotel_categories.status', 1)
            ->where('hotels.status', '=', '1')
            ->when('hotels.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'hotels.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('hotels.vendor_id', '=', 0);
                    });
            })
            ->when('hotels.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'hotels.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('hotels.vendor_id', '=', 0);
                    });
            })
            ->when($hotelId, function ($query) use ($hotelId) {
                return $query->where('hotels.id', $hotelId);
            })
            ->when($category, function ($query) use ($category_hotelIds) {
                return $query->whereIn('hotels.id', $category_hotelIds);
            })
            ->when($ratings, function ($query) use ($ratingIds) {
                return $query->whereIn('hotels.id', $ratingIds);
            })
            ->when($stars, function ($query) use ($starsIds) {
                return $query->whereIn('hotels.id', $starsIds);
            })
            ->when($country, function ($query) use ($countryIds) {
                return $query->whereIn('hotels.id', $countryIds);
            })
            ->when($state, function ($query) use ($stateIds) {
                return $query->whereIn('hotels.id', $stateIds);
            })
            ->when($city, function ($query) use ($cityIds) {
                return $query->whereIn('hotels.id', $cityIds);
            });

        // Add map bounds filtering
        if ($north && $south && $east && $west) {
            $query->whereBetween('hotels.latitude', [$south, $north])
                  ->whereBetween('hotels.longitude', [$west, $east]);
        }

        $hotels = $query->select(
                'hotels.*',
                'hotel_contents.title',
                'hotel_contents.slug',
                'hotel_contents.city_id',
                'hotel_contents.state_id',
                'hotel_contents.country_id',
                'hotel_contents.amenities',
                'hotel_contents.description',
                'hotel_contents.address',
                'hotel_contents.language_id',
                'hotels.monday_slots',
                'hotel_categories.name as categoryName',
                'hotel_categories.slug as categorySlug',
            )
            ->orderBy($order_by_column, $order)
            ->get();

        // Add amenities data to hotels
        $hotels = $hotels->map(function ($hotel) {
            if ($hotel->amenities) {
                $amenitiesArray = json_decode($hotel->amenities);
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
                $hotel->amenity_names = $amenityNames;
                $hotel->amenity_details = $amenityDetails;
            } else {
                $hotel->amenity_names = [];
                $hotel->amenity_details = [];
            }
            
            // Add total rooms count
            $hotel->total_rooms = \App\Models\Room::where('hotel_id', $hotel->id)->where('status', 1)->count();
            
            // Add hotel galleries
            $hotel->hotel_galleries = \App\Models\HotelImage::where('hotel_id', $hotel->id)->get();
            
            // Add country name
            if ($hotel->country_id) {
                $country = \App\Models\Location\Country::find($hotel->country_id);
                $hotel->country_name = $country ? $country->name : null;
            } else {
                $hotel->country_name = null;
            }
            
            // Add state name
            if ($hotel->state_id) {
                $state = \App\Models\Location\State::find($hotel->state_id);
                $hotel->state_name = $state ? $state->name : null;
            } else {
                $hotel->state_name = null;
            }
            
            // Add city name
            if ($hotel->city_id) {
                $city = \App\Models\Location\City::find($hotel->city_id);
                $hotel->city_name = $city ? $city->name : null;
            } else {
                $hotel->city_name = null;
            }
            
            // Parse slot times for check-in and check-out
            if ($hotel->monday_slots) {
                $slots = json_decode($hotel->monday_slots, true);
                if (is_array($slots) && !empty($slots)) {
                    $hotel->check_in_time = $slots[0]['start'] ?? null;
                    $hotel->check_out_time = $slots[0]['end'] ?? null;
                }
            }
            
            // Remove the raw monday_slots field if not needed in the frontend
            unset($hotel->monday_slots);
            
            return $hotel;
        });

        return response()->json([
            'success' => true,
            'hotels' => $hotels,
            'count' => $hotels->count()
        ]);
    }

    public function details($slug, $id)
    {
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();
        $information['bgImg'] = $misc->getBreadcrumb();
        $information['pageHeading'] = $misc->getPageHeading($language);

        $vendorId = Hotel::where('id', $id)->pluck('vendor_id')->first();

        $hotel = HotelContent::join('hotels', 'hotels.id', '=', 'hotel_contents.hotel_id')
            ->Join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('hotel_categories.status', 1)
            ->where('hotels.status',  '=',    '1')

            ->when($vendorId && $vendorId != 0, function ($query) {
                $query->join('memberships', 'hotels.vendor_id', '=', 'memberships.vendor_id')
                    ->where([
                        ['memberships.status', '=', 1],
                        ['memberships.start_date', '<=', now()->format('Y-m-d')],
                        ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                    ]);
            })
            ->when($vendorId && $vendorId != 0, function ($query) {
                return $query->leftJoin('vendors', 'hotels.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('hotels.vendor_id', '=', 0);
                    });
            })
            ->where([
                ['hotels.status', '=', '1']
            ])

            ->select(
                'hotels.*',
                'hotel_contents.address as address',
                'hotel_contents.title',
                'hotel_contents.slug',
                'hotel_contents.city_id',
                'hotel_contents.state_id',
                'hotel_contents.country_id',
                'hotel_contents.amenities',
                'hotel_categories.name as categoryName',
                'hotel_categories.slug as categorySlug',
                'hotel_contents.meta_keyword',
                'hotel_contents.meta_description',
                'hotel_contents.description',
            )
            ->where('hotels.id', $id)
            ->firstOrFail();

        if ($vendorId == 0) {
            $information['vendor'] = Admin::first();
            $information['userName'] = 'admin';
        } else {
            $information['vendor'] = Vendor::Where('id', $vendorId)->first();
            $information['userName'] = $information['vendor']->username;
        }

        $information['bgImg'] = $misc->getBreadcrumb();
        $information['hotel'] = $hotel;
        $information['hotelImages'] = HotelImage::Where('hotel_id', $id)->get();

        $information['language'] = $language;

        $hotelCounters = HotelCounter::join('hotel_counter_contents', 'hotel_counters.id', '=', 'hotel_counter_contents.hotel_counter_id')
            ->where('hotel_id', $id)
            ->where('hotel_counter_contents.language_id', $language->id)->get();
        $information['hotelCounters'] = $hotelCounters;

        $reviews = RoomReview::query()->where('hotel_id', '=', $id)->orderByDesc('id')->get();

        $reviews->map(function ($review) {
            $review['user'] = $review->userInfo()->first();
        });

        $information['reviews'] = $reviews;
        $numOfReview = count($reviews);
        $information['numOfReview'] = $numOfReview;

        // Load rooms with their gallery images
        $roomIds = RoomContent::join('rooms', 'rooms.id', '=', 'room_contents.room_id')
            ->Join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
            ->Join('room_categories', 'room_contents.room_category', '=', 'room_categories.id')
            ->Join('hotel_contents', 'rooms.hotel_id', '=', 'hotel_contents.hotel_id')
            ->Join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('room_categories.status', 1)
            ->where('rooms.hotel_id', $id)
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
            ->pluck('rooms.id')
            ->take(5);

        // Load actual Room models with gallery images
        $rooms = Room::with(['room_galleries', 'room_content' => function($query) use ($language) {
                $query->where('language_id', $language->id);
            }])
            ->whereIn('id', $roomIds)
            ->orderBy('id', 'desc')
            ->get();
        $totalRooms = RoomContent::join('rooms', 'rooms.id', '=', 'room_contents.room_id')
            ->Join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
            ->Join('room_categories', 'room_contents.room_category', '=', 'room_categories.id')
            ->Join('hotel_contents', 'rooms.hotel_id', '=', 'hotel_contents.hotel_id')
            ->Join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
            ->where('hotel_contents.language_id', $language->id)
            ->where('room_categories.status', 1)
            ->where('rooms.hotel_id', $id)
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
            ->select(
                'rooms.id',
            )
            ->orderBy('rooms.id', 'desc')
            ->get();

        $information['rooms'] = $rooms;
        $information['totalRooms'] = $totalRooms;
        return view('frontend.hotel.hotel-details', $information);
    }

    public function fetchcategory()
    {
        // Return all categories regardless of language
        // Frontend will handle language filtering
        $categories = HotelCategory::where('status', 1)->get();
        return response()->json($categories);
    }
    public function fetchcities()
    {
        // Return all cities regardless of language
        // Frontend will handle language filtering
        $cities = City::all();
        return response()->json($cities);
    }
    
    public function fetchcountries()
    {
        // Return all countries regardless of language
        // Frontend will handle language filtering
        $countries = Country::all();
        return response()->json($countries);
    }
    
    public function fetchSocialMedia()
    {
        $socialMedia = \App\Models\BasicSettings\SocialMedia::orderBy('serial_number', 'asc')->get();
        return response()->json($socialMedia);
    }
    public function fetchtestimonials()
    {
        // Return all testimonials regardless of language
        // Frontend will handle language filtering
        $testimonials = Testimonial::all();
        return response()->json($testimonials);
    }
    public function fetchblogs()
    {
        // Return all blogs with language_id for frontend filtering
        $blogs = Blog::join('blog_informations', 'blogs.id', '=', 'blog_informations.blog_id')
            ->join('blog_categories', 'blog_categories.id', '=', 'blog_informations.blog_category_id')
            ->where('blogs.status', '=', 1)
            ->select(
                'blogs.id',
                'blogs.image',
                'blogs.created_at',
                'blog_informations.title',
                'blog_informations.slug',
                'blog_informations.author',
                'blog_informations.content',
                'blog_informations.language_id',
                'blog_categories.name as categoryName',
                'blog_categories.slug as categorySlug'
            )
            ->orderBy('blogs.serial_number', 'asc')
            ->get();
        
        return response()->json($blogs);
    }
    public function fetchsections(){
        try {
            // Return all sections regardless of language
            // Frontend will handle language filtering
            $sections = SectionContent::all();
            
            \Log::info('All sections found:', ['count' => $sections->count(), 'sections' => $sections->toArray()]);
            
            // If no sections found, return empty array instead of null
            if ($sections->isEmpty()) {
                \Log::warning('No sections found in database');
                return response()->json([]);
            }
            
            return response()->json($sections);
        } catch (\Exception $e) {
            \Log::error('Error in fetchsections: ' . $e->getMessage());
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function fetchBasicImages()
    {
        try {
            $images = Basic::select(
                'logo',
                'favicon',
                'hero_section_image',
                'feature_section_image',
                'feature_section_image2',
                'counter_section_image',
                'call_to_action_section_image',
                'call_to_action_section_inner_image',
                'testimonial_section_image'
            )->first();

            if (!$images) {
                return response()->json([]);
            }

            return response()->json($images);
        } catch (\Exception $e) {
            \Log::error('Error in fetchBasicImages: ' . $e->getMessage());
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    /**
     * API endpoint for searching hotels (used by React frontend)
     */
    public function apiSearchHotels(Request $request)
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
            $query = Hotel::join('hotel_contents', 'hotels.id', '=', 'hotel_contents.hotel_id')
                ->leftJoin('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
                ->where('hotel_contents.language_id', $language->id)
                ->where('hotels.status', 1);
            
            // Filter by activity (hotel title)
            if ($activity) {
                $query->where('hotel_contents.title', 'like', '%' . $activity . '%');
            }
            
            // Filter by category
            if ($request->input('category')) {
                $category = $request->input('category');
                // Get category IDs that match the search term
                $categoryIds = \App\Models\HotelCategory::where('language_id', $language->id)
                    ->where(function($q) use ($category) {
                        $q->where('name', 'like', '%' . $category . '%')
                          ->orWhere('slug', 'like', '%' . $category . '%');
                    })
                    ->pluck('id');
                if ($categoryIds->count() > 0) {
                    $query->whereIn('hotel_contents.category_id', $categoryIds);
                }
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
            
            // Filter by country
            if ($request->input('country')) {
                $country = $request->input('country');
                // Get country IDs that match the search term
                $countryIds = \App\Models\Location\Country::where('name', 'like', '%' . $country . '%')
                    ->pluck('id');
                if ($countryIds->count() > 0) {
                    $query->whereIn('hotel_contents.country_id', $countryIds);
                }
            }
            
            // Filter by price range (using average room price)
            if ($priceRange) {
                switch ($priceRange) {
                    case '0-100':
                        $query->whereHas('room', function($q) {
                            $q->where('min_price', '<=', 100);
                        });
                        break;
                    case '100-200':
                        $query->whereHas('room', function($q) {
                            $q->where('min_price', '<=', 200)->where('min_price', '>=', 100);
                        });
                        break;
                    case '200-500':
                        $query->whereHas('room', function($q) {
                            $q->where('min_price', '<=', 500)->where('min_price', '>=', 200);
                        });
                        break;
                    case '500-1000':
                        $query->whereHas('room', function($q) {
                            $q->where('min_price', '<=', 1000)->where('min_price', '>=', 500);
                        });
                        break;
                    case '1000+':
                        $query->whereHas('room', function($q) {
                            $q->where('min_price', '>=', 1000);
                        });
                        break;
                    default:
                        // Handle any other price ranges
                        if (strpos($priceRange, '-') !== false) {
                            $prices = explode('-', $priceRange);
                            if (count($prices) == 2) {
                                $min = (int)$prices[0];
                                $max = (int)$prices[1];
                                $query->whereHas('room', function($q) use ($min, $max) {
                                    $q->where('min_price', '>=', $min)->where('min_price', '<=', $max);
                                });
                            }
                        }
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
                    $query->where(function($q) use ($amenity) {
                        $q->whereRaw("JSON_CONTAINS(hotel_contents.amenities, ?)", [json_encode($amenity)])
                          ->orWhere('hotel_contents.amenities', 'like', '%' . $amenity . '%')
                          ->orWhere('hotel_contents.amenities', 'like', '%' . strtolower($amenity) . '%');
                    });
                }
            }
            
            // Apply sorting
            switch ($sortBy) {
                case 'price-low':
                    $query->orderBy('hotels.average_price', 'asc');
                    break;
                case 'price-high':
                    $query->orderBy('hotels.average_price', 'desc');
                    break;
                case 'rating':
                    $query->orderBy('hotels.average_rating', 'desc');
                    break;
                case 'relevance':
                default:
                    $query->orderBy('hotels.id', 'desc');
                    break;
            }
            
            // Get results with pagination
            $hotels = $query->select(
                'hotels.*',
                'hotel_contents.title',
                'hotel_contents.slug',
                'hotel_contents.amenities',
                'hotel_contents.description',
                'hotel_contents.address',
                'hotel_contents.city_id',
                'hotel_contents.state_id',
                'hotel_contents.country_id',
                'hotel_categories.name as categoryName',
                'hotel_categories.slug as categorySlug'
            )
            ->paginate(12);
            
            // Transform the data for frontend consumption
            $transformedHotels = $hotels->getCollection()->map(function ($hotel) {
                // Get hotel images
                $hotelImages = HotelImage::where('hotel_id', $hotel->id)->first();
                $imageUrl = null;
                
                if ($hotelImages && $hotelImages->image) {
                    // Construct full URL for React frontend
                    $baseUrl = request()->getSchemeAndHttpHost();
                    $imageUrl = $baseUrl . '/assets/img/hotel/hotel-gallery/' . $hotelImages->image;
                }
                
                // Get amenities names
                $amenityNames = [];
                if ($hotel->amenities) {
                    $amenityIds = json_decode($hotel->amenities);
                    foreach ($amenityIds as $amenityId) {
                        $amenity = \App\Models\Amenitie::find($amenityId);
                        if ($amenity) {
                            $amenityNames[] = $amenity->title;
                        }
                    }
                }
                
                $averagePrice = Room::where('hotel_id', $hotel->id)
                    ->where('status', 1)
                    ->avg('min_price');
                
                $priceDisplay = $averagePrice ? '$' . number_format($averagePrice, 2) . '' : 'Price not available';
                
                return [
                    'id' => $hotel->id,
                    'name' => $hotel->title,
                    'slug' => $hotel->slug,
                    'location' => $hotel->address ?: 'Location not specified',
                    'price' => $priceDisplay,
                    'rating' => $hotel->average_rating ?: 0,
                    'stars' => $hotel->stars ?: 0,
                    'image' => $imageUrl,
                    'amenities' => $amenityNames,
                    'description' => $hotel->description ?: 'No description available',
                    'category' => $hotel->categoryName,
                    'latitude' => $hotel->latitude,
                    'longitude' => $hotel->longitude,
                    'roomCount' => Room::where('hotel_id', $hotel->id)->where('status', 1)->count()
                ];
            });
            
            return response()->json([
                'success' => true,
                'data' => [
                    'hotels' => $transformedHotels,
                    'pagination' => [
                        'current_page' => $hotels->currentPage(),
                        'last_page' => $hotels->lastPage(),
                        'per_page' => $hotels->perPage(),
                        'total' => $hotels->total()
                    ]
                ]
            ]);
            
        } catch (\Exception $e) {
            \Log::error('Hotel search error: ' . $e->getMessage(), [
                'file' => $e->getFile(),
                'line' => $e->getLine(),
                'trace' => $e->getTraceAsString(),
                'request' => $request->all()
            ]);
            
            return response()->json([
                'success' => false,
                'message' => 'Error occurred while searching hotels: ' . $e->getMessage(),
                'error' => $e->getMessage()
            ], 500);
        }
    }
    public function FetchCountersection(Request $request)
    {
        try {
            // Get language from request parameter or use default
            $languageCode = $request->get('lang', 'en');
            $language = Language::where('code', $languageCode)->first();
            
            if (!$language) {
                // Fallback to default language
                $language = Language::where('is_default', 1)->first();
                if (!$language) {
                    return response()->json(['error' => 'Language not found'], 404);
                }
            }

            // Get counters filtered by language_id
            $counters = CounterInformation::where('language_id', $language->id)
                ->orderBy('serial_number', 'asc')
                ->get();

            return response()->json($counters);
        } catch (\Exception $e) {
            \Log::error('Error fetching counter section: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to fetch counter section'], 500);
        }
    }
}
