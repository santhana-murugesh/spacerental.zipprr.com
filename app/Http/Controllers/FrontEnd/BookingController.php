<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Session;
use App\Http\Controllers\FrontEnd\MiscellaneousController;
use App\Models\CustomPricing;
use App\Models\HourlyRoomPrice;
use App\Models\BookingHour;
use App\Models\PaymentGateway\OfflineGateway;
use App\Models\PaymentGateway\OnlineGateway;
use App\Models\Room;
use App\Models\Hotel;
use App\Models\RoomContent;
use App\Models\RoomCoupon;
use App\Models\AdditionalServiceContent;
use App\Models\AdditionalService;
use Carbon\Carbon;
use DateTime;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Support\Facades\Auth;
use App\Models\BasicSettings\Basic;
use App\Models\Booking;

class BookingController extends Controller
{
    public function checkCheckout(Request $request)
    {
        $rule = [
            'price' => 'required',
            'room_id' => 'required|integer',
            'checkInDate' => 'required|date',
            'checkInTime' => 'required',
            'adult' => 'required|integer|min:1',
            'children' => 'nullable|integer|min:0',
        ];

        $messages = [
            'price.required' => __('Please select a booking hour to proceed.'),
            'room_id.required' => __('Room ID is required.'),
            'room_id.integer' => __('Invalid room ID.'),
            'checkInDate.required' => __('Check-in date is required.'),
            'checkInDate.date' => __('Invalid check-in date format.'),
            'checkInTime.required' => __('Check-in time is required.'),
            'adult.required' => __('Number of adults is required.'),
            'adult.integer' => __('Number of adults must be a number.'),
            'adult.min' => __('At least 1 adult is required.'),
            'children.integer' => __('Number of children must be a number.'),
            'children.min' => __('Number of children cannot be negative.'),
        ];
        
        $validator = Validator::make($request->all(), $rule, $messages);
        if ($validator->fails()) {
            return response()->json(
                [
                    'alert_type' => 'error',
                    'message' => 'Validation error occurred.',
                    'errors' => $validator->errors()
                ],
                422
            );
        }
        
        try {
            $selectedPrice = $request->input('price'); 
            
            // Validate price format (should be "hourId-price")
            if (!str_contains($selectedPrice, '-')) {
                return response()->json([
                    'alert_type' => 'error',
                    'message' => 'Invalid price format. Please select a valid duration.',
                ], 422);
            }
            
            list($hourId, $price) = explode('-', $selectedPrice);
            
            // Validate that both parts exist and are valid
            if (empty($hourId) || empty($price)) {
                return response()->json([
                    'alert_type' => 'error',
                    'message' => 'Invalid price format. Please select a valid duration.',
                ], 422);
            }
            
            $request->session()->put([
                'room_id' => $request->input('room_id'),
                'hour_id' => $hourId,
                'prices' => $price,
                'checkInTime' => checkInTimeFormate($request->checkInTime),
                'checkInDate' => $request->checkInDate,
                'price' => $request->price,
                'adult' => $request->input('adult'),
                'children' => $request->input('children', 0)
            ]);
            
            Session::forget('serviceCharge');
            Session::forget('takeService');
            Session::forget('roomDiscount');

            return response()->json([
                'redirect_url' => url('/checkout')
            ], 200);
            
        } catch (\Exception $e) {
            \Log::error('Booking checkout error: ' . $e->getMessage());
            return response()->json([
                'alert_type' => 'error',
                'message' => 'An error occurred while processing your booking. Please try again.',
            ], 500);
        }
    }
    public function checkout(Request $request)
    {
        $requiredSessionData = ['room_id', 'checkInDate', 'checkInTime', 'price', 'adult'];
        foreach ($requiredSessionData as $key) {
            if (!$request->session()->has($key)) {
                return redirect()->route('frontend.rooms')->with('error', __('Booking information missing'));
            }
        }
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();
        $roomId = $request->session()->get('room_id');
        $room = RoomContent::with(['room', 'room.hotel'])
            ->where('room_id', $roomId)
            ->where('language_id', $language->id)
            ->firstOrFail();
        $hourId = $request->session()->get('hour_id');
        $price = $request->session()->get('prices');
        
        // Initialize hour variable
        $hour = null;
        
        $customPrice = CustomPricing::where('booking_hours_id', $hourId)->first();
        if ($customPrice) {
            $hour = $customPrice->bookingHour->hour;
        } else {
            $hourlyPrice = HourlyRoomPrice::find($price);
            if ($hourlyPrice && $hourlyPrice->bookingHour) {
                $hour = $hourlyPrice->bookingHour->hour;
            } else {
                $hour = 'Unknown'; // Fallback value
            }
        }
        
        $information = [
            'language' => $language,
            'pageHeading' => $misc->getPageHeading($language),
            'bgImg' => $misc->getBreadcrumb(),
            'authUser' => Auth::guard('web')->user(),
            'currencyInfo' => $this->getCurrencyInfo(),
            'onlineGateways' => OnlineGateway::where('status', 1)->get(),
            'offline_gateways' => OfflineGateway::where('status', 1)->orderBy('serial_number', 'asc')->get(),
            'room' => $room,
            'checkInTime' => $request->session()->get('checkInTime'),
            'checkInDate' => $request->session()->get('checkInDate'),
            'price' => $price,
            'hourId' => $hourId,
            'hour' => $hour,
            'adult' => $request->session()->get('adult'),
            'children' => $request->session()->get('children'),
            'additionalServices' => json_decode(Room::find($roomId)->additional_service)
        ];
        $stripe = OnlineGateway::where('keyword', 'stripe')->first();
        $stripe_info = json_decode($stripe->information, true);
        $information['stripe_key'] = $stripe_info['key'];
        $authorizenet = OnlineGateway::query()->whereKeyword('authorize.net')->first();
        $anetInfo = json_decode($authorizenet->information);
        $information['anetSource'] = $anetInfo->sandbox_check == 1 
            ? 'https://jstest.authorize.net/v1/Accept.js' 
            : 'https://js.authorize.net/v1/Accept.js';
        $information['anetClientKey'] = $anetInfo->public_key;
        $information['anetLoginId'] = $anetInfo->login_id;
        return view('frontend.room.checkout', $information);
    }

    public function applyCoupon(Request $request)
    {
        try {
            $coupon = RoomCoupon::where('code', $request->coupon)->firstOrFail();

            $startDate = Carbon::parse($coupon->start_date);
            $endDate = Carbon::parse($coupon->end_date);
            $todayDate = Carbon::now();

            if ($todayDate->between($startDate, $endDate) == false) {
                return response()->json(['error' => __('Sorry, coupon has been expired!')]);
            }

            $price_id = $request->session()->get('price');
            $serviceCharge = $request->session()->get('serviceCharge');
            $roomId = HourlyRoomPrice::findorfail($price_id)->room_id;
            $price = HourlyRoomPrice::findorfail($price_id)->price;

            $roomIds = empty($coupon->rooms) ? '' : json_decode($coupon->rooms);

            if (!empty($roomIds) && !in_array($roomId, $roomIds)) {
                return response()->json(['error' => __('You can not apply this coupon for this room!')]);
            }

            session()->put('couponCode', $request->coupon);

            if ($coupon->type == 'fixed') {

                $request->session()->put('roomDiscount', $coupon->value);
                return response()->json([
                    'success' => __('Coupon applied successfully.'),
                ]);
            } else {

                $couponAmount = ($price + $serviceCharge) * ($coupon->value / 100);
                $request->session()->put('roomDiscount', $couponAmount);

                return response()->json([
                    'success' => __('Coupon applied successfully.'),
                ]);
            }
        } catch (ModelNotFoundException $e) {
            return response()->json(['error' => __('Coupon is not valid!')]);
        }
    }
    public function additonalService(Request $request)
    {
        $haven = Session::get('takeService');
        $taken = $request->takeService;

        $havenArray = !empty($haven) ? explode(',', $haven) : [];
        $takenArray = !empty($taken) ? explode(',', $taken) : [];

        $havenCount = count($havenArray);
        $takenCount = count($takenArray);

        Session::put('serviceCharge', $request->serviceCharge);
        Session::put('takeService', $request->takeService);
        Session::forget('roomDiscount');
        $couponCode = Session::forget('couponCode');


        if ($havenCount > $takenCount) {
            return response()->json([
                'error' => __('Additional Service removed successfully.'),
            ]);
        } else {
            return response()->json([
                'success' => __('Additional Service added successfully.'),
            ]);
        }
    }

    public function getCurrencyInfo()
    {
        return Basic::select('base_currency_text', 'base_currency_text_position', 'base_currency_symbol', 'base_currency_symbol_position')->first();
    }

    public function index(Request $request)
    {
        try {
            // Check if user is authenticated
            if (!Auth::guard('web')->check()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Please login to complete your booking.'
                ], 401);
            }

            // Validate the request
            $validator = Validator::make($request->all(), [
                'booking_name' => 'required|string|max:255',
                'booking_phone' => 'required|string|max:255',
                'booking_email' => 'required|email|max:255',
                'booking_address' => 'required|string|max:500',
                'gateway' => 'required|string',
                'additional_services' => 'nullable|array',
                'room_id' => 'required|integer',
                'hour_id' => 'required',
                'price' => 'required',
                'checkInDate' => 'required|date',
                'checkInTime' => 'required',
                'adult' => 'required|integer|min:1',
                'children' => 'nullable|integer|min:0'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }

            // Check if gateway is an offline gateway (numeric ID)
            if (!is_numeric($request->gateway)) {
                return response()->json([
                    'success' => false,
                    'message' => 'This endpoint is for offline payments only. Please use the appropriate payment gateway.'
                ], 400);
            }

            // Verify the offline gateway exists
            $offlineGateway = OfflineGateway::find($request->gateway);
            if (!$offlineGateway || $offlineGateway->status != 1) {
                return response()->json([
                    'success' => false,
                    'message' => 'Invalid or inactive payment gateway.'
                ], 400);
            }

            // Get session data
            $roomId = $request->session()->get('room_id');
            $hourId = $request->session()->get('hour_id');
            $price = $request->session()->get('prices');
            $checkInTime = $request->session()->get('checkInTime');
            $checkInDate = $request->session()->get('checkInDate');
            $adult = $request->session()->get('adult');
            $children = $request->session()->get('children');

            if (!$roomId || !$hourId || !$price || !$checkInTime || !$checkInDate || !$adult) {
                return response()->json([
                    'success' => false,
                    'message' => 'Session data missing. Please start a new booking.'
                ], 400);
            }

            // Get room and hotel information
            $room = Room::find($roomId);
            if (!$room) {
                return response()->json([
                    'success' => false,
                    'message' => 'Room not found.'
                ], 404);
            }

            $hotel = Hotel::find($room->hotel_id);
            if (!$hotel) {
                return response()->json([
                    'success' => false,
                    'message' => 'Hotel not found.'
                ], 404);
            }

            // Calculate booking details
            $hourlyPrice = HourlyRoomPrice::find($price);
            if (!$hourlyPrice) {
                return response()->json([
                    'success' => false,
                    'message' => 'Invalid price information.'
                ], 400);
            }

            $hour = $hourlyPrice->bookingHour->hour ?? 1;
            $roomPrice = $hourlyPrice->price;
            $vendorId = $hourlyPrice->vendor_id;

            // Calculate times
            $checkInDateTime = $checkInDate . ' ' . $checkInTime;
            $checkOutTime = date('H:i:s', strtotime($checkInTime . " +{$hour} hour"));
            $checkOutDate = $checkInDate;
            
            // If checkout time goes past midnight, adjust the date
            if (strtotime($checkOutTime) < strtotime($checkInTime)) {
                $checkOutDate = date('Y-m-d', strtotime($checkInDate . ' +1 day'));
            }
            
            $checkOutDateTime = $checkOutDate . ' ' . $checkOutTime;

            // Calculate additional service charges
            $additionalServiceCharge = 0;
            $additionalServices = [];
            if ($request->additional_services && is_array($request->additional_services)) {
                foreach ($request->additional_services as $serviceId) {
                    $service = AdditionalService::find($serviceId);
                    if ($service) {
                        $additionalServiceCharge += $service->charge;
                        $additionalServices[] = $serviceId;
                    }
                }
            }

            // Get tax information
            $taxData = Basic::select('hotel_tax_amount')->first();
            $taxRate = $taxData->hotel_tax_amount ?? 0;

            // Calculate totals
            $subtotal = $roomPrice + $additionalServiceCharge;
            $taxAmount = ($subtotal * $taxRate) / 100;
            $grandTotal = $subtotal + $taxAmount;

            // Generate order number
            $orderNumber = 'BK-' . date('Ymd') . '-' . strtoupper(uniqid());

            // Create the booking
            $booking = new \App\Models\Booking();
            $booking->order_number = $orderNumber;
            $booking->user_id = Auth::guard('web')->id(); // User should be authenticated by now
            $booking->hotel_id = $hotel->id;
            $booking->room_id = $roomId;
            $booking->vendor_id = $vendorId;
            $booking->check_in_date = $checkInDate;
            $booking->check_in_time = $checkInTime;
            $booking->check_out_date = $checkOutDate;
            $booking->check_out_time = $checkOutTime;
            $booking->check_in_date_time = $checkInDateTime;
            $booking->check_out_date_time = $checkOutDateTime;
            $booking->preparation_time = $room->preparation_time ?? 0;
            $booking->next_booking_time = $checkOutDateTime;
            $booking->booking_name = $request->booking_name;
            $booking->booking_email = $request->booking_email;
            $booking->booking_phone = $request->booking_phone;
            $booking->booking_address = $request->booking_address;
            $booking->total = $subtotal;
            $booking->discount = 0; // Will be updated if coupon is applied
            $booking->tax = $taxAmount;
            $booking->grand_total = $grandTotal;
            $booking->currency_text = 'USD'; // Default, should get from settings
            $booking->currency_text_position = 'left';
            $booking->currency_symbol = '$';
            $booking->currency_symbol_position = 'left';
            $booking->payment_method = $request->gateway;
            $booking->payment_status = 'pending';
            $booking->order_status = 'pending';
            $booking->hour = $hour;
            $booking->serviceCharge = $additionalServiceCharge;
            $booking->roomPrice = $roomPrice;
            $booking->adult = $adult;
            $booking->children = $children ?? 0;
            $booking->additional_service = json_encode($additionalServices);
            $booking->service_details = json_encode([
                'additional_services' => $additionalServices,
                'gateway' => $request->gateway
            ]);

            $booking->save();

            // Clear session data
            $request->session()->forget([
                'room_id', 'hour_id', 'prices', 'checkInTime', 'checkInDate', 
                'price', 'adult', 'children', 'serviceCharge', 'takeService', 'roomDiscount'
            ]);

            // Return success response
            return response()->json([
                'success' => true,
                'message' => 'Booking created successfully!',
                'booking_id' => $booking->id,
                'order_number' => $booking->order_number,
                'redirect_url' => route('frontend.room_booking.complete', ['type' => 'success'])
            ]);

        } catch (\Exception $e) {
            \Log::error('Room booking error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while creating your booking. Please try again.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function getCheckoutData(Request $request)
    {
        try {
            $requiredSessionData = ['room_id', 'checkInDate', 'checkInTime', 'price', 'adult'];
            foreach ($requiredSessionData as $key) {
                if (!$request->session()->has($key)) {
                    return response()->json(['error' => 'Booking information missing'], 400);
                }
            }

            $misc = new MiscellaneousController();
            $language = $misc->getLanguage();
            $roomId = $request->session()->get('room_id');
            $room = RoomContent::with(['room', 'room.hotel'])
                ->where('room_id', $roomId)
                ->where('language_id', $language->id)
                ->firstOrFail();
            
            $hourId = $request->session()->get('hour_id');
            $price = $request->session()->get('prices');
            
            // Initialize hour variable
            $hour = null;
            
            $customPrice = CustomPricing::where('booking_hours_id', $hourId)->first();
            if ($customPrice) {
                $hour = $customPrice->bookingHour->hour;
            } else {
                $hourlyPrice = HourlyRoomPrice::find($price);
                if ($hourlyPrice && $hourlyPrice->bookingHour) {
                    $hour = $hourlyPrice->bookingHour->hour;
                } else {
                    $hour = 'Unknown'; // Fallback value
                }
            }

            $taxData = Basic::select('hotel_tax_amount')->first();
            $additionalServicesRaw = json_decode(Room::find($roomId)->additional_service, true);
            
            // Process additional services to include titles and prices
            $additionalServices = [];
            if ($additionalServicesRaw) {
                foreach ($additionalServicesRaw as $serviceId => $price) {
                    $serviceContent = AdditionalServiceContent::where([
                        ['additional_service_id', $serviceId],
                        ['language_id', $language->id]
                    ])->first();
                    
                    if ($serviceContent) {
                        $additionalServices[] = [
                            'id' => $serviceId,
                            'title' => $serviceContent->title,
                            'charge' => $price
                        ];
                    }
                }
            }

            $bookingData = [
                'room' => [
                    'id' => $room->room->id,
                    'title' => $room->title,
                    'slug' => $room->slug
                ],
                'hotel' => [
                    'id' => $room->room->hotel->id,
                    'name' => $room->room->hotel->name
                ],
                'checkInDate' => $request->session()->get('checkInDate'),
                'checkInTime' => $request->session()->get('checkInTime'),
                'hour' => $hour,
                'price' => $price,
                'adult' => $request->session()->get('adult'),
                'children' => $request->session()->get('children'),
                'serviceCharge' => $request->session()->get('serviceCharge', 0),
                'tax' => $taxData->hotel_tax_amount ?? 0
            ];

            return response()->json([
                'booking' => $bookingData,
                'additionalServices' => $additionalServices,
                'currencyInfo' => $this->getCurrencyInfo(),
                'authUser' => Auth::guard('web')->user()
            ]);

        } catch (\Exception $e) {
            \Log::error('Get checkout data error: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to get checkout data'], 500);
        }
    }

    public function getCheckoutDataFromParams(Request $request)
    {
        try {
            \Log::info('getCheckoutDataFromParams called with data: ' . json_encode($request->all()));
            $validator = Validator::make($request->all(), [
                'room_id' => 'required|integer',
                'hour_id' => 'nullable', // Made optional since we extract from price
                'price' => 'required', // This contains both hour_id and price
                'checkInDate' => 'required|date',
                'checkInTime' => 'required',
                'adult' => 'required|integer|min:1',
                'children' => 'nullable|integer|min:0',
            ]);

            if ($validator->fails()) {
                return response()->json(['error' => 'Invalid booking data'], 400);
            }

            $misc = new MiscellaneousController();
            $language = $misc->getLanguage();
            \Log::info('Language: ' . json_encode($language));
            $roomId = $request->input('room_id');
            $room = RoomContent::with(['room', 'room.hotel'])
                ->where('room_id', $roomId)
                ->where('language_id', $language->id)
                ->first();
                
            \Log::info('Room query result: ' . json_encode($room));
                
            if (!$room) {
                return response()->json(['error' => 'Room not found'], 404);
            }
            
            if (!$room->room || !$room->room->hotel) {
                return response()->json(['error' => 'Room or hotel information is incomplete'], 404);
            }
            
            $hourId = $request->input('hour_id');
            $price = $request->input('price');
            
            // Initialize hour variable
            $hour = null;
            
            try {
                $customPrice = CustomPricing::where('booking_hours_id', $hourId)->first();
                if ($customPrice && $customPrice->bookingHour) {
                    $hour = $customPrice->bookingHour->hour;
                } else {
                    // Get the hour from the booking_hours table using a join
                    $hourlyPrice = HourlyRoomPrice::join('booking_hours', 'hourly_room_prices.hour_id', '=', 'booking_hours.id')
                        ->where('hourly_room_prices.id', $price)
                        ->select('hourly_room_prices.*', 'booking_hours.hour')
                        ->first();
                    
                    if ($hourlyPrice) {
                        $hour = $hourlyPrice->hour;
                    } else {
                        $hour = 'Unknown'; 
                    }
                }
            } catch (\Exception $e) {
                \Log::warning('Could not determine hour, using fallback: ' . $e->getMessage());
                $hour = 'Unknown';
            }

            $taxData = Basic::select('hotel_tax_amount')->first();
            if (!$taxData) {
                return response()->json(['error' => 'Tax configuration not found'], 404);
            }
            $additionalServicesRaw = json_decode(Room::find($roomId)->additional_service, true);
            
            $additionalServices = [];
            if ($additionalServicesRaw) {
                foreach ($additionalServicesRaw as $serviceId => $servicePrice) {
                    $serviceContent = AdditionalServiceContent::where([
                        ['additional_service_id', $serviceId],
                        ['language_id', $language->id]
                    ])->first();
                    
                    if ($serviceContent) {
                        $additionalServices[] = [
                            'id' => $serviceId,
                            'title' => $serviceContent->title,
                            'charge' => $servicePrice
                        ];
                    }
                }
            }

            $bookingData = [
                'room' => [
                    'id' => $room->room->id,
                    'title' => $room->title,
                    'slug' => $room->slug
                ],
                'hotel' => [
                    'id' => $room->room->hotel->id,
                    'name' => $room->room->hotel->name
                ],
                'checkInDate' => $request->input('checkInDate'),
                'checkInTime' => $request->input('checkInTime'),
                'hour' => $hour,
                'price' => $price,
                'adult' => $request->input('adult'),
                'children' => $request->input('children'),
                'serviceCharge' => 0, // Will be calculated when services are selected
                'tax' => $taxData->hotel_tax_amount ?? 0
            ];

            return response()->json([
                'booking' => $bookingData,
                'additionalServices' => $additionalServices,
                'currencyInfo' => $this->getCurrencyInfo(),
                'authUser' => Auth::guard('web')->user()
            ]);

        } catch (\Exception $e) {
            \Log::error('Get checkout data from params error: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to get checkout data'], 500);
        }
    }

    public function processBooking(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'booking_name' => 'required|string|max:255',
                'booking_phone' => 'required|string|max:255',
                'booking_email' => 'required|email|max:255',
                'booking_address' => 'required|string|max:500',
                'gateway' => 'required|string',
                'additional_services' => 'array',
                'room_id' => 'required|integer',
                'hour_id' => 'required',
                'price' => 'required',
                'checkInDate' => 'required|date',
                'checkInTime' => 'required',
                'adult' => 'required|integer|min:1',
                'children' => 'nullable|integer|min:0'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'errors' => $validator->errors()
                ], 422);
            }

            // Store all booking data in session for payment processing
            $request->session()->put([
                'room_id' => $request->room_id,
                'hour_id' => $request->hour_id,
                'prices' => $request->price,
                'checkInTime' => $request->checkInTime,
                'checkInDate' => $request->checkInDate,
                'price' => $request->price,
                'adult' => $request->adult,
                'children' => $request->children,
                'booking_name' => $request->booking_name,
                'booking_phone' => $request->booking_phone,
                'booking_email' => $request->booking_email,
                'booking_address' => $request->booking_address,
                'additional_services' => $request->additional_services
            ]);

            // Redirect to the appropriate payment gateway
            if (in_array($request->gateway, ['PayPal', 'Stripe', 'Instamojo', 'Paystack', 'Flutterwave', 'Razorpay', 'MercadoPago', 'Mollie', 'Paytm'])) {
                // Online payment - redirect to payment gateway
                return response()->json([
                    'redirect_url' => route('frontend.room.room_booking')
                ]);
            } else {
                // Offline payment - redirect to offline payment page
                return response()->json([
                    'redirect_url' => route('frontend.room.room_booking')
                ]);
            }

        } catch (\Exception $e) {
            \Log::error('Process booking error: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to process booking'], 500);
        }
    }

    public function getPaymentGateways()
    {
        try {
            $onlineGateways = OnlineGateway::where('status', 1)->get();
            $offlineGateways = OfflineGateway::where('status', 1)->orderBy('serial_number', 'asc')->get();

            return response()->json([
                'online' => $onlineGateways,
                'offline' => $offlineGateways
            ]);
        } catch (\Exception $e) {
            \Log::error('Get payment gateways error: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to get payment gateways'], 500);
        }
    }

    public function apiBooking(Request $request)
    {
      try {
        // Check if user is authenticated via JWT
        if (!Auth::guard('api')->check()) {
          return response()->json([
            'success' => false,
            'message' => 'User not authenticated'
          ], 401);
        }

        $user = Auth::guard('api')->user();
        
        \Log::info('API Booking request received:', $request->all());
        \Log::info('API Booking request headers:', $request->headers->all());
        \Log::info('API Booking user:', ['user_id' => $user->id, 'user_name' => $user->name]);
        \Log::info('Additional services data:', [
          'received_services' => $request->input('additional_services'),
          'is_array' => is_array($request->input('additional_services')),
          'count' => is_array($request->input('additional_services')) ? count($request->input('additional_services')) : 'not array'
        ]);
        
        // Validate request data based on what frontend actually sends
        $validator = Validator::make($request->all(), [
          'booking_name' => 'required|string|max:255',
          'booking_phone' => 'required|string|max:255',
          'booking_email' => 'required|email|max:255',
          'booking_address' => 'required|string|max:500',
          'gateway' => 'required|string',
          'additional_services' => 'nullable|array',
          'room_id' => 'required|integer|exists:rooms,id',
          'hour_id' => 'nullable', // Made optional since we extract from price
          'price' => 'required', // This contains both hour_id and price
          'checkInDate' => 'required|date',
          'checkInTime' => 'required',
          'adult' => 'required|integer|min:1',
          'children' => 'nullable|integer|min:0'
        ], [
          'booking_name.required' => 'Booking name is required',
          'booking_phone.required' => 'Booking phone is required',
          'booking_email.required' => 'Booking email is required',
          'booking_email.email' => 'Please enter a valid email address',
          'booking_address.required' => 'Booking address is required',
          'gateway.required' => 'Payment gateway is required',
          'room_id.required' => 'Room ID is required',
          'room_id.exists' => 'Selected room does not exist',
          'price.required' => 'Price is required',
          'checkInDate.required' => 'Check-in date is required',
          'checkInDate.date' => 'Check-in date must be a valid date',
          'checkInTime.required' => 'Check-in time is required',
          'adult.required' => 'Number of adults is required',
          'adult.integer' => 'Number of adults must be a whole number',
          'adult.min' => 'At least 1 adult is required',
          'children.integer' => 'Number of children must be a whole number',
          'children.min' => 'Number of children cannot be negative'
        ]);

        if ($validator->fails()) {
          \Log::error('API Booking validation failed:', $validator->errors()->toArray());
          \Log::error('API Booking request data:', $request->all());
          \Log::error('API Booking missing fields:', $request->only(['booking_name', 'booking_phone', 'booking_email', 'booking_address', 'gateway', 'room_id', 'hour_id', 'price', 'checkInDate', 'checkInTime', 'adult', 'children']));
          
          // Check if hour_id is missing but price contains hour_id
          $priceField = $request->input('price');
          if (str_contains($priceField, '-')) {
            list($extractedHourId, $extractedPrice) = explode('-', $priceField);
            \Log::info('Extracted hour_id from price field:', ['hour_id' => $extractedHourId, 'price' => $extractedPrice]);
          }
          
          return response()->json([
            'success' => false,
            'message' => 'Validation failed',
            'errors' => $validator->errors(),
            'received_data' => $request->all(),
            'missing_fields' => $request->only(['booking_name', 'booking_phone', 'booking_email', 'booking_address', 'gateway', 'room_id', 'hour_id', 'price', 'checkInDate', 'checkInTime', 'adult', 'children'])
          ], 422);
        }

        // Check if gateway is an offline gateway (numeric ID)
        if (!is_numeric($request->gateway)) {
          return response()->json([
            'success' => false,
            'message' => 'This endpoint is for offline payments only. Please use the appropriate payment gateway.'
          ], 400);
        }

        // Extract hour_id from price field if not provided separately
        $hourId = $request->input('hour_id');
        $priceValue = $request->input('price');
        
        if (!$hourId && str_contains($priceValue, '-')) {
          list($extractedHourId, $extractedPrice) = explode('-', $priceValue);
          $hourId = $extractedHourId;
          $priceValue = $extractedPrice;
          \Log::info('Extracted hour_id and price from price field:', ['hour_id' => $hourId, 'price' => $extractedPrice]);
        }

        // Convert time format from 12-hour to 24-hour format
        $checkInTime = $request->input('checkInTime');
        $convertedTime = date('H:i:s', strtotime($checkInTime));
        \Log::info('Time conversion:', ['original' => $checkInTime, 'converted' => $convertedTime]);

        // Ensure date is in correct format (Y-m-d)
        $checkInDate = $request->input('checkInDate');
        $convertedDate = date('Y-m-d', strtotime($checkInDate));
        \Log::info('Date conversion:', ['original' => $checkInDate, 'converted' => $convertedDate]);

        // Get the room details
        $room = \App\Models\Room::findOrFail($request->room_id);
        
        // Ensure vendor_id is valid
        $vendorId = $room->vendor_id;
        if (!$vendorId || $vendorId == 0) {
            \Log::warning('Room has invalid vendor_id:', ['room_id' => $request->room_id, 'vendor_id' => $vendorId]);
            $vendorId = 1; // Set a default vendor ID if none exists
        }
        
        // Get the payment gateway name for display
        $paymentMethodName = 'Unknown';
        if (is_numeric($request->gateway)) {
            $offlineGateway = \App\Models\PaymentGateway\OfflineGateway::find($request->gateway);
            if ($offlineGateway) {
                $paymentMethodName = $offlineGateway->name;
            }
        }
        
        // Get default language for service names
        $defaultLanguage = \App\Models\Language::where('is_default', 1)->first();
        $languageId = $defaultLanguage ? $defaultLanguage->id : 1;
        
        // Calculate total amount including additional services
        $totalAmount = $priceValue;
        $additionalServicesData = [];
        
        \Log::info('Starting additional services calculation:', [
          'base_price' => $priceValue,
          'received_services' => $request->input('additional_services'),
          'room_additional_services' => $room->additional_service
        ]);
        
        if ($request->additional_services && is_array($request->additional_services)) {
          // Get the room's additional service configuration
          $roomAdditionalServices = json_decode($room->additional_service, true);
          
          \Log::info('Room additional services config:', [
            'raw' => $room->additional_service,
            'decoded' => $roomAdditionalServices
          ]);
          
          foreach ($request->additional_services as $serviceId) {
            \Log::info('Processing service:', [
              'service_id' => $serviceId,
              'exists_in_room' => isset($roomAdditionalServices[$serviceId]),
              'room_service_price' => isset($roomAdditionalServices[$serviceId]) ? $roomAdditionalServices[$serviceId] : 'not_found'
            ]);
            
            if (isset($roomAdditionalServices[$serviceId])) {
              $servicePrice = $roomAdditionalServices[$serviceId];
              
              // Get the service content for the name
              $serviceContent = \App\Models\AdditionalServiceContent::where([
                ['additional_service_id', $serviceId],
                ['language_id', $languageId] // Use the dynamic language
              ])->first();
              
              $serviceName = $serviceContent ? $serviceContent->title : 'Additional Service';
              
              if ($servicePrice > 0) {
                $totalAmount += $servicePrice;
                $additionalServicesData[] = [
                  'service_id' => $serviceId,
                  'name' => $serviceName,
                  'price' => $servicePrice
                ];
                
                \Log::info('Added service to total:', [
                  'service_id' => $serviceId,
                  'name' => $serviceName,
                  'price' => $servicePrice,
                  'running_total' => $totalAmount
                ]);
              }
            } else {
              \Log::warning('Service not found in room configuration:', [
                'service_id' => $serviceId,
                'room_id' => $request->room_id
              ]);
            }
          }
        }
        
        // Calculate tax amount
        $taxPercentage = 0;
        $taxAmount = 0;
        
        // Get tax percentage from basic settings
        $taxData = \App\Models\BasicSettings\Basic::select('hotel_tax_amount')->first();
        if ($taxData && isset($taxData->hotel_tax_amount)) {
            $taxPercentage = $taxData->hotel_tax_amount;
        }
        
        if ($taxPercentage > 0) {
            $taxAmount = ($totalAmount * $taxPercentage) / 100;
            $totalAmountWithTax = $totalAmount + $taxAmount;
        } else {
            $totalAmountWithTax = $totalAmount;
        }
        
        \Log::info('Tax calculation:', [
          'base_price' => $priceValue,
          'additional_services_count' => count($additionalServicesData),
          'additional_services_total' => $totalAmount - $priceValue,
          'subtotal' => $totalAmount,
          'tax_percentage' => $taxPercentage,
          'tax_amount' => $taxAmount,
          'final_total_with_tax' => $totalAmountWithTax
        ]);

        // Create the booking record
        $booking = new \App\Models\Booking();
        $booking->user_id = $user->id;
        $booking->room_id = $request->room_id;
        $booking->vendor_id = $vendorId;
        $booking->booking_name = $request->booking_name;
        $booking->booking_phone = $request->booking_phone;
        $booking->booking_email = $request->booking_email;
        $booking->booking_address = $request->booking_address;
        $booking->check_in_date = $convertedDate;
        $booking->check_in_time = $convertedTime;
        $booking->adult = $request->adult;
        $booking->children = $request->children ?? 0;
        $booking->hour = $hourId;
        $booking->roomPrice = $priceValue;
        $booking->total = $totalAmount;
        $booking->grand_total = $totalAmountWithTax;
        $booking->tax = $taxAmount;
        $booking->payment_status = 0; // 0 = pending, 1 = paid, 2 = rejected
        $booking->payment_method = $paymentMethodName;
        
        // Generate order number
        $orderNumber = 'ORD-' . str_pad(time(), 8, '0', STR_PAD_LEFT) . '-' . $user->id;
        $booking->order_number = $orderNumber;
        
        // Set default values for other required fields
        $booking->currency_text = 'USD';
        $booking->currency_text_position = 'left';
        $booking->currency_symbol = '$';
        $booking->currency_symbol_position = 'left';
        
        // Only set additional_service if there are services
        if (!empty($additionalServicesData)) {
            $booking->additional_service = json_encode($additionalServicesData);
            // Also store in service_details for admin view compatibility
            $booking->service_details = json_encode([
                'additional_services' => $additionalServicesData,
                'gateway' => $request->gateway
            ]);
        }
        
        // Log the data being inserted
        \Log::info('Creating booking with data:', [
            'user_id' => $booking->user_id,
            'room_id' => $booking->room_id,
            'vendor_id' => $booking->vendor_id,
            'booking_name' => $booking->booking_name,
            'booking_phone' => $booking->booking_phone,
            'booking_email' => $booking->booking_email,
            'booking_address' => $booking->booking_address,
            'check_in_date' => $booking->check_in_date,
            'check_in_time' => $booking->check_in_time,
            'adult' => $booking->adult,
            'children' => $booking->children,
            'hour' => $booking->hour,
            'roomPrice' => $booking->roomPrice,
            'total' => $booking->total,
            'grand_total' => $booking->grand_total,
            'tax' => $booking->tax,
            'payment_status' => $booking->payment_status,
            'payment_method' => $booking->payment_method,
            'order_number' => $booking->order_number,
            'currency_text' => $booking->currency_text,
            'currency_symbol' => $booking->currency_symbol,
            'additional_service' => $booking->additional_service ?? 'none'
        ]);
        
        $booking->save();

        \Log::info('Booking created successfully:', ['booking_id' => $booking->id, 'user_id' => $user->id]);

        return response()->json([
          'success' => true,
          'message' => 'Booking created successfully',
          'booking_id' => $booking->id,
          'order_number' => $booking->order_number,
          'total_amount' => $totalAmountWithTax,
          'subtotal' => $totalAmount,
          'tax_amount' => $taxAmount
        ]);

      } catch (\Exception $e) {
        \Log::error('API Booking error: ' . $e->getMessage());
        \Log::error('API Booking error trace: ' . $e->getTraceAsString());
        
        return response()->json([
          'success' => false,
          'message' => 'An error occurred while creating the booking: ' . $e->getMessage()
        ], 500);
      }
    }

    public function apiOnlineBooking(Request $request)
    {
      try {
        // Check if user is authenticated via JWT
        if (!Auth::guard('api')->check()) {
          return response()->json([
            'success' => false,
            'message' => 'User not authenticated'
          ], 401);
        }

        $user = Auth::guard('api')->user();
        
        \Log::info('API Online Booking request received:', $request->all());
        
        // Validate request data
        $validator = Validator::make($request->all(), [
          'booking_name' => 'required|string|max:255',
          'booking_phone' => 'required|string|max:255',
          'booking_email' => 'required|email|max:255',
          'booking_address' => 'required|string|max:500',
          'gateway' => 'required|string',
          'additional_services' => 'nullable|array',
          'room_id' => 'required|integer|exists:rooms,id',
          'price' => 'required',
          'checkInDate' => 'required|date',
          'checkInTime' => 'required',
          'adult' => 'required|integer|min:1',
          'children' => 'nullable|integer|min:0'
        ]);

        if ($validator->fails()) {
          return response()->json([
            'success' => false,
            'message' => 'Validation failed',
            'errors' => $validator->errors()
          ], 422);
        }

        // Extract hour_id from price field if not provided separately
        $hourId = $request->input('hour_id');
        $priceValue = $request->input('price');
        
        if (!$hourId && str_contains($priceValue, '-')) {
          list($extractedHourId, $extractedPrice) = explode('-', $priceValue);
          $hourId = $extractedHourId;
          $priceValue = $extractedPrice;
        }

        // Convert time format from 12-hour to 24-hour format
        $checkInTime = $request->input('checkInTime');
        $convertedTime = date('H:i:s', strtotime($checkInTime));

        // Ensure date is in correct format (Y-m-d)
        $checkInDate = $request->input('checkInDate');
        $convertedDate = date('Y-m-d', strtotime($checkInDate));

        // Get the room details
        $room = \App\Models\Room::findOrFail($request->room_id);
        
        // Ensure vendor_id is valid
        $vendorId = $room->vendor_id;
        if (!$vendorId || $vendorId == 0) {
          $vendorId = 1; // Set a default vendor ID if none exists
        }

        // Get default language for service names
        $defaultLanguage = \App\Models\Language::where('is_default', 1)->first();
        $languageId = $defaultLanguage ? $defaultLanguage->id : 1;
        
        // Calculate total amount including additional services
        $totalAmount = $priceValue;
        $additionalServicesData = [];
        
        if ($request->additional_services && is_array($request->additional_services)) {
          $roomAdditionalServices = json_decode($room->additional_service, true);
          
          foreach ($request->additional_services as $serviceId) {
            if (isset($roomAdditionalServices[$serviceId])) {
              $servicePrice = $roomAdditionalServices[$serviceId];
              
              $serviceContent = \App\Models\AdditionalServiceContent::where([
                ['additional_service_id', $serviceId],
                ['language_id', $languageId]
              ])->first();
              
              $serviceName = $serviceContent ? $serviceContent->title : 'Additional Service';
              
              if ($servicePrice > 0) {
                $totalAmount += $servicePrice;
                $additionalServicesData[] = [
                  'service_id' => $serviceId,
                  'name' => $serviceName,
                  'price' => $servicePrice
                ];
              }
            }
          }
        }
        
        // Calculate tax amount
        $taxPercentage = 0;
        $taxAmount = 0;
        
        $taxData = \App\Models\BasicSettings\Basic::select('hotel_tax_amount')->first();
        if ($taxData && isset($taxData->hotel_tax_amount)) {
          $taxPercentage = $taxData->hotel_tax_amount;
        }
        
        if ($taxPercentage > 0) {
          $taxAmount = ($totalAmount * $taxPercentage) / 100;
          $totalAmountWithTax = $totalAmount + $taxAmount;
        } else {
          $totalAmountWithTax = $totalAmount;
        }

        // Create the booking record
        $booking = new \App\Models\Booking();
        $booking->user_id = $user->id;
        $booking->room_id = $request->room_id;
        $booking->vendor_id = $vendorId;
        $booking->booking_name = $request->booking_name;
        $booking->booking_phone = $request->booking_phone;
        $booking->booking_email = $request->booking_email;
        $booking->booking_address = $request->booking_address;
        $booking->check_in_date = $convertedDate;
        $booking->check_in_time = $convertedTime;
        $booking->adult = $request->adult;
        $booking->children = $request->children ?? 0;
        $booking->hour = $hourId;
        $booking->roomPrice = $priceValue;
        $booking->total = $totalAmount;
        $booking->grand_total = $totalAmountWithTax;
        $booking->tax = $taxAmount;
        $booking->payment_status = 0; // 0 = pending, 1 = paid, 2 = rejected
        $booking->payment_method = $request->gateway;
        $booking->gateway_type = $request->gateway;
        
        // Generate order number
        $orderNumber = 'ORD-' . str_pad(time(), 8, '0', STR_PAD_LEFT) . '-' . $user->id;
        $booking->order_number = $orderNumber;
        
        // Set default values for other required fields
        $booking->currency_text = 'USD';
        $booking->currency_text_position = 'left';
        $booking->currency_symbol = '$';
        $booking->currency_symbol_position = 'left';
        
        // Only set additional_service if there are services
        if (!empty($additionalServicesData)) {
          $booking->additional_service = json_encode($additionalServicesData);
          $booking->service_details = json_encode([
            'additional_services' => $additionalServicesData,
            'gateway' => $request->gateway
          ]);
        }
        
        $booking->save();

        \Log::info('Online booking created successfully:', ['booking_id' => $booking->id, 'user_id' => $user->id]);

        // Prepare the data to pass to the payment gateway
        $paymentData = [
          'gateway' => $request->gateway,
          'booking_id' => $booking->id,
          'order_number' => $booking->order_number,
          'amount' => $totalAmountWithTax,
          'currency' => 'USD',
          'customer_name' => $request->booking_name,
          'customer_email' => $request->booking_email,
          'customer_phone' => $request->booking_phone,
          'room_id' => $request->room_id,
          'hour_id' => $hourId,
          'check_in_date' => $convertedDate,
          'check_in_time' => $convertedTime,
          'adult' => $request->adult,
          'children' => $request->children ?? 0,
          'additional_services' => $additionalServicesData,
          'tax_amount' => $taxAmount,
          'total_amount' => $totalAmountWithTax
        ];

        // Handle Stripe token processing directly for API requests
        if ($request->gateway === 'stripe' && $request->has('stripeToken')) {
          return $this->processStripePayment($request, $booking, $totalAmountWithTax);
        }

        // Handle PayPal and other online gateways directly
        if ($request->gateway === 'paypal') {
          return $this->processPayPalPayment($request, $booking, $totalAmountWithTax);
        }

        if ($request->gateway === 'razorpay') {
          return $this->processRazorpayPayment($request, $booking, $totalAmountWithTax);
        }

        if ($request->gateway === 'mollie') {
          return $this->processMolliePayment($request, $booking, $totalAmountWithTax);
        }

        if ($request->gateway === 'authorize_net' && $request->has('authorizeNetToken')) {
          return $this->processAuthorizeNetPayment($request, $booking, $totalAmountWithTax);
        }

        // For other gateways, return the payment data for frontend processing
        return response()->json([
          'success' => true,
          'message' => 'Online booking created successfully',
          'booking_id' => $booking->id,
          'order_number' => $booking->order_number,
          'payment_data' => $paymentData,
          'gateway' => $request->gateway,
          'amount' => $totalAmountWithTax,
          'currency' => 'USD'
        ]);

      } catch (\Exception $e) {
        \Log::error('API Online Booking error: ' . $e->getMessage());
        \Log::error('API Online Booking error trace: ' . $e->getTraceAsString());
        
        return response()->json([
          'success' => false,
          'message' => 'An error occurred while creating the online booking: ' . $e->getMessage()
        ], 500);
      }
    }

    private function processStripePayment($request, $booking, $totalAmount)
    {
      try {
        // Get Stripe configuration
        $stripe = OnlineGateway::where('keyword', 'stripe')->first();
        $stripeConfig = json_decode($stripe->information, true);

        // Initialize Stripe
        \Config::set('services.stripe.key', $stripeConfig["key"]);
        \Config::set('services.stripe.secret', $stripeConfig["secret"]);

        $stripe = \Cartalyst\Stripe\Laravel\Facades\Stripe::make(\Config::get('services.stripe.secret'));

        // Process the payment
        $charge = $stripe->charges()->create([
          'source' => $request->stripeToken,
          'currency' => 'USD',
          'amount' => $totalAmount,
          'description' => 'Room Booking - ' . $booking->order_number,
          'receipt_email' => $request->booking_email,
          'metadata' => [
            'booking_id' => $booking->id,
            'customer_name' => $request->booking_name,
            'order_number' => $booking->order_number
          ]
        ]);

        if ($charge['status'] == 'succeeded') {
          // Update booking status
          $booking->payment_status = 1; // paid
          $booking->payment_id = $charge['id'];
          $booking->save();

          \Log::info('Stripe payment successful:', ['booking_id' => $booking->id, 'charge_id' => $charge['id']]);

          // Here you would typically:
          // 1. Generate and send invoice
          // 2. Send confirmation emails
          // 3. Update vendor earnings
          // For now, we'll return success

          return response()->json([
            'success' => true,
            'message' => 'Payment processed successfully',
            'booking_id' => $booking->id,
            'order_number' => $booking->order_number,
            'payment_id' => $charge['id'],
            'redirect_url' => '/booking-success?booking=' . $booking->id
          ]);
        } else {
          \Log::error('Stripe payment failed:', ['booking_id' => $booking->id, 'charge_status' => $charge['status']]);
          
          return response()->json([
            'success' => false,
            'message' => 'Payment failed. Please try again.'
          ], 400);
        }

      } catch (\Cartalyst\Stripe\Exception\CardErrorException $e) {
        \Log::error('Stripe card error:', ['booking_id' => $booking->id, 'error' => $e->getMessage()]);
        
        return response()->json([
          'success' => false,
          'message' => 'Card error: ' . $e->getMessage()
        ], 400);
        
      } catch (\Exception $e) {
        \Log::error('Stripe processing error:', ['booking_id' => $booking->id, 'error' => $e->getMessage()]);
        
        return response()->json([
          'success' => false,
          'message' => 'Payment processing failed: ' . $e->getMessage()
        ], 500);
      }
    }

    private function processPayPalPayment($request, $booking, $totalAmount)
    {
      try {
        // Get PayPal configuration
        $paypal = OnlineGateway::where('keyword', 'paypal')->first();
        if (!$paypal) {
          throw new \Exception('PayPal gateway not found');
        }

        $paypalConfig = json_decode($paypal->information, true);
        \Log::info('PayPal config received:', $paypalConfig);

        // Check if required configuration keys exist
        if (!isset($paypalConfig['client_id'])) {
          throw new \Exception('PayPal client_id not configured');
        }
        if (!isset($paypalConfig['client_secret'])) {
          throw new \Exception('PayPal client_secret not configured');
        }
        if (!isset($paypalConfig['sandbox_status'])) {
          $paypalConfig['sandbox_status'] = '1'; // Default to sandbox
        }

        // Log the credentials being used (remove in production)
        \Log::info('Using PayPal credentials:', [
          'client_id' => $paypalConfig['client_id'],
          'client_secret' => substr($paypalConfig['client_secret'], 0, 4) . '***', // Only show first 4 chars
          'mode' => $paypalConfig['sandbox_status'] == '1' ? 'sandbox' : 'live'
        ]);

        // Use the installed PayPal REST API SDK
        $apiContext = new \PayPal\Rest\ApiContext(
          new \PayPal\Auth\OAuthTokenCredential(
            $paypalConfig['client_id'],
            $paypalConfig['client_secret']
          )
        );

        // Set mode (sandbox or live)
        if ($paypalConfig['sandbox_status'] == '1') {
          $apiContext->setConfig([
            'mode' => 'sandbox'
          ]);
        } else {
          $apiContext->setConfig([
            'mode' => 'live'
          ]);
        }

        // Create a payment
        $payment = new \PayPal\Api\Payment();
        $payment->setIntent('sale');

        // Set payer
        $payer = new \PayPal\Api\Payer();
        $payer->setPaymentMethod('paypal');
        $payment->setPayer($payer);

        // Set amount
        $amount = new \PayPal\Api\Amount();
        $amount->setCurrency('USD');
        $amount->setTotal($totalAmount);
        
        // Set transaction
        $transaction = new \PayPal\Api\Transaction();
        $transaction->setAmount($amount);
        $transaction->setDescription('Room Booking - ' . $booking->order_number);
        $payment->addTransaction($transaction);

        // Set redirect URLs
        $redirectUrls = new \PayPal\Api\RedirectUrls();
        $redirectUrls->setReturnUrl(url('/booking-success?booking=' . $booking->id));
        $redirectUrls->setCancelUrl(url('/checkout'));
        $payment->setRedirectUrls($redirectUrls);

        // Create payment
        $payment->create($apiContext);

        // Get approval URL
        $approvalUrl = $payment->getApprovalLink();
        
        \Log::info('PayPal payment initiated successfully. Approval URL: ' . $approvalUrl);
        return response()->json([
            'success' => true,
            'message' => 'Payment initiated successfully. Redirecting to PayPal...',
            'redirect_url' => $approvalUrl
        ]);

      } catch (\Exception $e) {
        \Log::error('PayPal processing error: ' . $e->getMessage());
        \Log::error('PayPal error details: ' . $e->getTraceAsString());
        
        // Return more detailed error for debugging
        return response()->json([
            'success' => false,
            'message' => 'Payment initiation failed. Please try again. Error: ' . $e->getMessage(),
            'debug_info' => [
              'error_type' => get_class($e),
              'error_message' => $e->getMessage(),
              'config_used' => [
                'client_id' => $paypalConfig['client_id'] ?? 'not_set',
                'mode' => ($paypalConfig['sandbox_status'] ?? '1') == '1' ? 'sandbox' : 'live'
              ]
            ]
        ], 500);
      }
    }

    private function processRazorpayPayment($request, $booking, $totalAmount)
    {
      try {
        // Get Razorpay configuration
        $razorpay = OnlineGateway::where('keyword', 'razorpay')->first();
        $razorpayConfig = json_decode($razorpay->information, true);

        // Initialize Razorpay
        \Config::set('services.razorpay.key', $razorpayConfig['key']);
        \Config::set('services.razorpay.secret', $razorpayConfig['secret']);

        $razorpay = new \Razorpay\Api\Api($razorpayConfig['key'], $razorpayConfig['secret']);

        // Process the payment
        $order = $razorpay->order->create([
            'receipt' => $booking->order_number,
            'amount' => $totalAmount * 100, // Amount in paise
            'currency' => 'INR', // Assuming INR for Razorpay
            'payment_capture' => 1 // Auto-capture
        ]);

        if ($order['status'] == 'created') {
            $razorpayOrderId = $order['id'];
            \Log::info('Razorpay payment initiated successfully. Order ID: ' . $razorpayOrderId);
            return response()->json([
                'success' => true,
                'message' => 'Payment initiated successfully. Redirecting to Razorpay...',
                'razorpay_order_id' => $razorpayOrderId
            ]);
        } else {
            \Log::error('Razorpay payment initiation failed: ' . $order['error']['description']);
            return response()->json([
                'success' => false,
                'message' => 'Payment initiation failed. Please try again. Error: ' . $order['error']['description']
            ], 400);
        }

      } catch (\Exception $e) {
        \Log::error('Razorpay processing error: ' . $e->getMessage());
        return response()->json([
            'success' => false,
            'message' => 'Payment initiation failed. Please try again. Error: ' . $e->getMessage()
        ], 500);
      }
    }

    private function processMolliePayment($request, $booking, $totalAmount)
    {
      try {
        // Get Mollie configuration
        $mollie = OnlineGateway::where('keyword', 'mollie')->first();
        $mollieConfig = json_decode($mollie->information, true);

        // Initialize Mollie
        \Config::set('services.mollie.api_key', $mollieConfig['api_key']);

        $mollie = new \Mollie\Api\MollieApiClient();
        $mollie->setApiKey($mollieConfig['api_key']);

        // Process the payment
        $payment = $mollie->payments()->create([
            'amount' => [
                'currency' => 'EUR', // Assuming EUR for Mollie
                'value' => number_format($totalAmount, 2, '.', '')
            ],
            'description' => 'Room Booking - ' . $booking->order_number,
            'redirectUrl' => url('/booking-success?booking=' . $booking->id), // Redirect to success page
            'webhookUrl' => url('/api/booking/mollie-webhook'), // Webhook URL for Mollie
            'metadata' => [
                'booking_id' => $booking->id,
                'customer_name' => $booking->booking_name,
                'order_number' => $booking->order_number
            ]
        ]);

        if ($payment->isPaid()) {
            $paymentId = $payment->id;
            \Log::info('Mollie payment successful. Payment ID: ' . $paymentId);
            $booking->payment_status = 1; // paid
            $booking->payment_id = $paymentId;
            $booking->save();

            return response()->json([
                'success' => true,
                'message' => 'Payment processed successfully',
                'booking_id' => $booking->id,
                'order_number' => $booking->order_number,
                'payment_id' => $paymentId,
                'redirect_url' => url('/booking-success?booking=' . $booking->id)
            ]);
        } else {
            \Log::error('Mollie payment failed. Status: ' . $payment->status);
            return response()->json([
                'success' => false,
                'message' => 'Payment failed. Please try again. Status: ' . $payment->status
            ], 400);
        }

      } catch (\Exception $e) {
        \Log::error('Mollie processing error: ' . $e->getMessage());
        return response()->json([
            'success' => false,
            'message' => 'Payment processing failed. Please try again. Error: ' . $e->getMessage()
        ], 500);
      }
    }

    private function processAuthorizeNetPayment($request, $booking, $totalAmount)
    {
      try {
        // Get Authorize.Net configuration
        $authorizeNet = OnlineGateway::where('keyword', 'authorize.net')->first();
        $authorizeNetConfig = json_decode($authorizeNet->information);

        // Initialize Authorize.Net
        \Config::set('services.authorize_net.api_login_id', $authorizeNetConfig->login_id);
        \Config::set('services.authorize_net.transaction_key', $authorizeNetConfig->transaction_key);
        \Config::set('services.authorize_net.sandbox', $authorizeNetConfig->sandbox_check == 1);

        $authorizeNet = new \AuthorizeNetAPI\AuthorizeNetAPI();

        // Process the payment
        $transaction = new \AuthorizeNetAPI\Transaction();
        $transaction->setTransactionType('authCaptureTransaction');
        $transaction->setAmount($totalAmount);
        $transaction->setPayment(new \AuthorizeNetAPI\Payment(new \AuthorizeNetAPI\CreditCard(
            $request->stripeToken, // Assuming stripeToken is used for Authorize.Net
            $request->booking_name,
            $request->booking_email,
            $request->booking_phone
        )));

        $response = $authorizeNet->createTransaction($transaction);

        if ($response->isApproved()) {
            $transactionId = $response->transaction->transactionId;
            \Log::info('Authorize.Net payment successful. Transaction ID: ' . $transactionId);
            $booking->payment_status = 1; // paid
            $booking->payment_id = $transactionId;
            $booking->save();

            return response()->json([
                'success' => true,
                'message' => 'Payment processed successfully',
                'booking_id' => $booking->id,
                'order_number' => $booking->order_number,
                'payment_id' => $transactionId,
                'redirect_url' => url('/booking-success?booking=' . $booking->id)
            ]);
        } else {
            \Log::error('Authorize.Net payment failed. Response: ' . $response->responseReasonText);
            return response()->json([
                'success' => false,
                'message' => 'Payment failed. Please try again. Error: ' . $response->responseReasonText
            ], 400);
        }

      } catch (\Exception $e) {
        \Log::error('Authorize.Net processing error: ' . $e->getMessage());
        return response()->json([
            'success' => false,
            'message' => 'Payment processing failed. Please try again. Error: ' . $e->getMessage()
        ], 500);
      }
    }

    public function handleOnlineBooking(Request $request)
    {
      try {
        // Get the online booking data from query parameters
        $gateway = $request->query('gateway');
        $bookingId = $request->query('booking_id');
        $orderNumber = $request->query('order_number');
        $amount = $request->query('amount');
        $currency = $request->query('currency');
        $customerName = $request->query('customer_name');
        $customerEmail = $request->query('customer_email');
        $customerPhone = $request->query('customer_phone');
        $roomId = $request->query('room_id');
        $checkInDate = $request->query('check_in_date');
        $checkInTime = $request->query('check_in_time');
        $adult = $request->query('adult');
        $children = $request->query('children');
        $additionalServices = $request->query('additional_services');
        $taxAmount = $request->query('tax_amount');

        // Validate required parameters
        if (!$gateway) {
          return redirect()->route('frontend.checkout')->with('error', 'Missing required booking information');
        }

        // Store the data in session for the payment gateway to use (only when present)
        if ($bookingId && $orderNumber && $amount) {
          $request->session()->put([
            'gateway' => $gateway,
            'booking_id' => $bookingId,
            'order_number' => $orderNumber,
            'amount' => $amount,
            'currency' => $currency,
            'customer_name' => $customerName,
            'customer_email' => $customerEmail,
            'customer_phone' => $customerPhone,
            'room_id' => $roomId,
            'check_in_date' => $checkInDate,
            'check_in_time' => $checkInTime,
            'adult' => $adult,
            'children' => $children,
            'additional_services' => $additionalServices,
            'tax_amount' => $taxAmount,
            'online_booking' => true
          ]);
        }

        // Get the payment gateway details
        $onlineGateway = \App\Models\PaymentGateway\OnlineGateway::where('keyword', $gateway)->first();
        
        if (!$onlineGateway) {
          return redirect()->route('frontend.checkout')->with('error', 'Payment gateway not found');
        }

        // Ensure legacy payment flow prerequisites exist in session
        if (!$request->session()->has('price') && $request->input('hour_id')) {
          $request->session()->put('price', $request->input('hour_id'));
        }
        if (!$request->session()->has('checkInDate') && $request->input('check_in_date')) {
          $request->session()->put('checkInDate', $request->input('check_in_date'));
        }
        if (!$request->session()->has('checkInTime') && $request->input('check_in_time')) {
          $request->session()->put('checkInTime', $request->input('check_in_time'));
        }
        if (!$request->session()->has('adult') && $request->input('adult')) {
          $request->session()->put('adult', $request->input('adult'));
        }
        if (!$request->session()->has('children')) {
          $request->session()->put('children', $request->input('children', 0));
        }
        if (!$request->session()->has('serviceCharge')) {
          $request->session()->put('serviceCharge', 0);
        }

        // Route to the appropriate payment gateway controller
        switch ($gateway) {
          case 'stripe':
            $stripeController = new \App\Http\Controllers\FrontEnd\BookingPayment\StripeController();
            return $stripeController->index($request);
            
          case 'paypal':
            $paypalController = new \App\Http\Controllers\FrontEnd\BookingPayment\PayPalController();
            return $paypalController->index($request, 'Room Booking');
            
          case 'iyzico':
            $iyzicoController = new \App\Http\Controllers\FrontEnd\BookingPayment\IyzicoController();
            return $iyzicoController->index($request, 'Room Booking');
            
          case 'authorize.net':
            $authorizeNetController = new \App\Http\Controllers\FrontEnd\BookingPayment\AuthorizeNetController();
            return $authorizeNetController->index($request, 'Room Booking');
            
          case 'razorpay':
            $razorpayController = new \App\Http\Controllers\FrontEnd\BookingPayment\RazorpayController();
            return $razorpayController->index($request, 'Room Booking');
            
          case 'paytm':
            $paytmController = new \App\Http\Controllers\FrontEnd\BookingPayment\PaytmController();
            return $paytmController->index($request, 'Room Booking');
            
          case 'paystack':
            $paystackController = new \App\Http\Controllers\FrontEnd\BookingPayment\PaystackController();
            return $paystackController->index($request, 'Room Booking');
            
          case 'flutterwave':
            $flutterwaveController = new \App\Http\Controllers\FrontEnd\BookingPayment\FlutterwaveController();
            return $flutterwaveController->index($request, 'Room Booking');
            
          case 'mollie':
            $mollieController = new \App\Http\Controllers\FrontEnd\BookingPayment\MollieController();
            return $mollieController->index($request, 'Room Booking');
            
          case 'midtrans':
            $midtransController = new \App\Http\Controllers\FrontEnd\BookingPayment\MidtransController();
            return $midtransController->index($request, 'Room Booking', 'booking');
            
          case 'mercadopago':
            $mercadopagoController = new \App\Http\Controllers\FrontEnd\BookingPayment\MercadoPagoController();
            return $mercadopagoController->index($request, 'Room Booking');
            
          case 'myfatoorah':
            $myfatoorahController = new \App\Http\Controllers\FrontEnd\BookingPayment\MyfatoorahController();
            return $myfatoorahController->index($request, 'Room Booking');
            
          case 'yoco':
            $yocoController = new \App\Http\Controllers\FrontEnd\BookingPayment\YocoController();
            return $yocoController->index($request, 'Room Booking');
            
          case 'toyyibpay':
            $toyyibpayController = new \App\Http\Controllers\FrontEnd\BookingPayment\ToyyibpayController();
            return $toyyibpayController->index($request, 'Room Booking');
            
          case 'phonepe':
            $phonepeController = new \App\Http\Controllers\FrontEnd\BookingPayment\PhonepeController();
            return $phonepeController->index($request, 'Room Booking');
            
          case 'paytabs':
            $paytabsController = new \App\Http\Controllers\FrontEnd\BookingPayment\PaytabsController();
            return $paytabsController->index($request, 'Room Booking');
            
          case 'xendit':
            $xenditController = new \App\Http\Controllers\FrontEnd\BookingPayment\XenditController();
            return $xenditController->index($request, 'Room Booking');
            
          case 'perfectmoney':
            $perfectMoneyController = new \App\Http\Controllers\FrontEnd\BookingPayment\PerfectMoneyController();
            return $perfectMoneyController->index($request, 'Room Booking');
            
          default:
            return redirect()->route('frontend.checkout')->with('error', 'Unsupported payment gateway');
        }

      } catch (\Exception $e) {
        \Log::error('Online booking handling error: ' . $e->getMessage());
        return redirect()->route('frontend.checkout')->with('error', 'An error occurred while processing the online booking');
      }
    }

    private function generatePaymentForm($gateway, $data)
    {
      // This is a placeholder method that should generate the appropriate payment form
      // based on the selected gateway. For now, we'll return a simple message.
      
      switch ($gateway) {
        case 'stripe':
          return '<div class="alert alert-info">Stripe payment integration coming soon. Please contact support.</div>';
          
        case 'paypal':
          return '<div class="alert alert-info">PayPal payment integration coming soon. Please contact support.</div>';
          
        case 'iyzico':
          return '<div class="alert alert-info">Iyzico payment integration coming soon. Please contact support.</div>';
          
        default:
          return '<div class="alert alert-info">Payment integration for ' . $gateway . ' coming soon. Please contact support.</div>';
      }
    }

    /**
     * Get user bookings for the authenticated user
     */
    public function getUserBookings(Request $request)
    {
        try {
            // Get the authenticated user
            $user = auth('api')->user();
            
            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'User not authenticated'
                ], 401);
            }

            // Fetch bookings for the current user with relationships
            $bookings = Booking::with([
                'hotel.hotel_contents',
                'hotelRoom.room_content',
                'hotelRoom.hotel.hotel_contents'
            ])
            ->where('user_id', $user->id)
            ->orderBy('created_at', 'desc')
            ->get();

            \Log::info('User bookings fetched', [
                'user_id' => $user->id,
                'bookings_count' => $bookings->count(),
                'bookings' => $bookings->toArray()
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Bookings retrieved successfully',
                'bookings' => $bookings,
                'total_count' => $bookings->count()
            ]);

        } catch (\Exception $e) {
            \Log::error('Error fetching user bookings: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Error fetching bookings',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}