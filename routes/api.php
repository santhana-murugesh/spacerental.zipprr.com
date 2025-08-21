<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
  return $request->user();
});

Route::get('/rooms/filter-by-bounds', 'FrontEnd\RoomController@filterByBounds')->name('api.rooms.filter-by-bounds');
Route::get('/rooms/available-time-slots', 'FrontEnd\RoomController@getAvailableTimeSlots')->name('api.rooms.available-time-slots');
Route::get('/rooms/get-price', 'FrontEnd\RoomController@getPrice')->name('api.rooms.get-price');
Route::get('/rooms/get-custom-pricing', 'FrontEnd\RoomController@getCustomPricing')->name('api.rooms.get-custom-pricing');
Route::get('/rooms/get-room-images', 'FrontEnd\RoomController@getRoomImages')->name('api.rooms.get-room-images');
Route::get('/rooms/get-room-amenities', 'FrontEnd\RoomController@getRoomAmenities')->name('api.rooms.get-room-amenities');
Route::get('/rooms/{room}/gallery', 'FrontEnd\RoomController@getRoomGallery')->name('api.rooms.gallery');
Route::get('/hotels/filter-by-bounds', 'FrontEnd\HotelController@filterByBounds')->name('api.hotels.filter-by-bounds');
Route::get('/hotels/categories', 'FrontEnd\HotelController@fetchcategory')->name('api.hotels.categories');
Route::get('/cities', 'FrontEnd\HotelController@fetchcities')->name('api.cities');
Route::get('/countries', 'FrontEnd\HotelController@fetchcountries')->name('api.countries');
Route::get('/social-media', 'FrontEnd\HotelController@fetchSocialMedia')->name('api.social-media');
Route::get('/testimonials', 'FrontEnd\HotelController@fetchtestimonials')->name('api.testimonials');
Route::get('/countersection', 'FrontEnd\HotelController@FetchCountersection')->name('api.countersection');
Route::get('/blogs', 'FrontEnd\HotelController@fetchblogs')->name('api.blogs');
Route::get('/sections', 'FrontEnd\HotelController@fetchsections')->name('api.section.contents');
Route::get('/basic-images', 'FrontEnd\HotelController@fetchBasicImages')->name('api.basic.images');

Route::get('/languages', 'FrontEnd\MiscellaneousController@getLanguages')->name('api.languages');

Route::post('/change-language', 'FrontEnd\MiscellaneousController@apiChangeLanguage')
  ->middleware('api-session')
  ->name('api.change-language');

Route::get('/translations/{languageCode}', 'FrontEnd\MiscellaneousController@getFrontendTranslations')->name('api.translations');

Route::get('/features', 'Admin\HomePage\FeaturedController@getFrontendFeatures')->name('api.features');

Route::get('/about-us', 'FrontEnd\HomeController@apiAboutUs')->name('api.about-us');

Route::get('/search/rooms', 'FrontEnd\RoomController@apiSearchRooms')->name('api.search.rooms');
Route::get('/search/hotels', 'FrontEnd\HotelController@apiSearchHotels')->name('api.search.hotels');

Route::get('/test/hotels', function() {
    try {
        $hotels = \App\Models\Hotel::with('hotel_contents')->limit(5)->get();
        return response()->json([
            'success' => true,
            'message' => 'API is working',
            'hotels_count' => $hotels->count(),
            'sample_hotel' => $hotels->first()
        ]);
    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'message' => 'API test failed: ' . $e->getMessage(),
            'error' => $e->getMessage()
        ], 500);
    }
})->name('api.test.hotels');

Route::get('/settings', 'FrontEnd\MiscellaneousController@getBasicSettings')->name('api.settings');

Route::get('/test/bookings', function() {
    try {
        $bookings = \App\Models\Booking::with([
            'hotel.hotel_contents',
            'hotelRoom.room_content'
        ])->limit(5)->get();
        
        return response()->json([
            'success' => true,
            'message' => 'Test bookings endpoint working',
            'total_bookings' => \App\Models\Booking::count(),
            'sample_bookings' => $bookings
        ]);
    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'message' => 'Test failed: ' . $e->getMessage(),
            'error' => $e->getMessage()
        ], 500);
    }
})->name('api.test.bookings');

Route::post('/room/check-checkout', 'FrontEnd\BookingController@checkCheckout')
    ->middleware('api-session')
    ->name('api.room.check-checkout');

Route::get('/room/get-checkout-data', 'FrontEnd\BookingController@getCheckoutData')
    ->middleware('api-session')
    ->name('api.room.get-checkout-data');

Route::post('/room/get-checkout-data-from-params', 'FrontEnd\BookingController@getCheckoutDataFromParams')
    ->name('api.room.get-checkout-data-from-params');

Route::get('/payment/gateways', 'FrontEnd\BookingController@getPaymentGateways')
    ->name('api.payment.gateways');

Route::post('/room/process-booking', 'FrontEnd\BookingController@processBooking')
    ->middleware('api-session')
    ->name('api.room.process-booking');

Route::get('/payment/gateways', 'FrontEnd\BookingController@getPaymentGateways')
    ->name('api.payment.gateways');

Route::post('/auth/login', 'FrontEnd\UserController@apiLogin')->name('api.auth.login');
Route::post('/auth/register', 'FrontEnd\UserController@apiRegister')->name('api.auth.register');
Route::post('/auth/logout', 'FrontEnd\UserController@apiLogout')->name('api.auth.logout');
Route::get('/auth/user', 'FrontEnd\UserController@apiUser')->name('api.auth.user');
Route::post('/auth/refresh', 'FrontEnd\UserController@refreshToken')->name('api.auth.refresh');

Route::get('/auth/google/url', 'FrontEnd\UserController@getGoogleLoginUrl')->name('api.auth.google.url');
Route::post('/auth/google/callback', 'FrontEnd\UserController@handleGoogleApiCallback')->name('api.auth.google.callback');
Route::get('/auth/facebook/url', 'FrontEnd\UserController@getFacebookLoginUrl')->name('api.auth.facebook.url');
Route::post('/auth/facebook/callback', 'FrontEnd\UserController@handleFacebookApiCallback')->name('api.auth.facebook.callback');

Route::middleware('auth:api')->group(function () {
    Route::get('/auth/me', 'FrontEnd\UserController@apiUser')->name('api.auth.me');
    Route::post('/room/booking', 'FrontEnd\BookingController@apiBooking')->name('api.room.booking');
    
    Route::post('/room/online-booking', 'FrontEnd\BookingController@apiOnlineBooking')->name('api.room.online-booking');
    
    Route::get('/bookings', 'FrontEnd\BookingController@getUserBookings')->name('api.bookings');
    
    Route::post('/user/update-profile', 'FrontEnd\UserController@apiUpdateProfile')->name('api.user.update_profile');
    Route::post('/user/update-password', 'FrontEnd\UserController@apiUpdatePassword')->name('api.user.update_password');
    
    Route::post('/wishlist/hotel/add', 'FrontEnd\UserController@apiAddHotelToWishlist')->name('api.wishlist.hotel.add');
    Route::post('/wishlist/hotel/remove', 'FrontEnd\UserController@apiRemoveHotelFromWishlist')->name('api.wishlist.hotel.remove');
    Route::get('/wishlist/hotel/check/{hotelId}', 'FrontEnd\UserController@apiCheckHotelWishlist')->name('api.wishlist.hotel.check');
    Route::get('/wishlist/hotels', 'FrontEnd\UserController@apiGetHotelWishlists')->name('api.wishlist.hotels');
    
    Route::get('/user/dashboard/stats', 'FrontEnd\UserController@apiGetDashboardStats')->name('api.user.dashboard.stats');
    Route::get('/user/dashboard/bookings', 'FrontEnd\UserController@apiGetDashboardBookings')->name('api.user.dashboard.bookings');
    Route::get('/user/dashboard/wishlists', 'FrontEnd\UserController@apiGetDashboardWishlists')->name('api.user.dashboard.wishlists');
    Route::get('/user/dashboard/recent-activity', 'FrontEnd\UserController@apiGetRecentActivity')->name('api.user.dashboard.recent_activity');
    
    Route::post('/room/booking-test', function (Request $request) {
        return response()->json([
            'success' => true,
            'message' => 'Test endpoint working',
            'received_data' => $request->all(),
            'headers' => $request->headers->all(),
            'user' => auth('api')->user()
        ]);
    })->name('api.room.booking.test');
    
    Route::get('/room/check-table-structure', function () {
        try {
            $columns = \DB::select('DESCRIBE bookings');
            return response()->json([
                'success' => true,
                'message' => 'Table structure retrieved',
                'columns' => $columns
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error checking table structure: ' . $e->getMessage()
            ], 500);
        }
    })->name('api.room.check-table-structure');

    Route::get('/support-tickets', 'FrontEnd\SupportTicketController@apiGetTickets')->name('api.support_tickets.index');
    Route::get('/support-tickets/{id}', 'FrontEnd\SupportTicketController@apiGetTicket')->name('api.support_tickets.show');
    Route::post('/support-tickets/{id}/reply', 'FrontEnd\SupportTicketController@apiReplyTicket')->name('api.support_tickets.reply');
});

Route::get('/routes', function () {
    return response()->json([
        'hotelsFilterByBounds' => route('api.hotels.filter-by-bounds'),
        'hotelsCategories' => route('api.hotels.categories'),
        'cities' => route('api.cities'),
        'countries' => route('api.countries'),
        'socialMedia' => route('api.social-media'),
        'testimonials' => route('api.testimonials'),
        'countersection' => route('api.countersection'),
        'blogs'=>route('api.blogs'),
        'SectionContents' => route('api.section.contents'),
        'basicImages' => route('api.basic.images'),
        'languages' => route('api.languages'),
        'changeLanguage' => route('api.change-language'),
        'aboutUs' => route('api.about-us'),
        'searchRooms' => route('api.search.rooms'),
        'searchHotels' => route('api.search.hotels'),
        'settings' => route('api.settings'),
        'roomCheckCheckout' => route('api.room.check-checkout'),
        'roomGetCheckoutData' => route('api.room.get-checkout-data'),
        'roomGetCheckoutDataFromParams' => route('api.room.get-checkout-data-from-params'),
        'roomProcessBooking' => route('api.room.process-booking'),
        'roomOnlineBooking' => route('api.room.online-booking'),
        'bookings' => route('api.bookings'),
        'paymentGateways' => route('api.payment.gateways'),
        'authLogin' => route('api.auth.login'),
        'authRegister' => route('api.auth.register'),
        'authLogout' => route('api.auth.logout'),
        'authUser' => route('api.auth.user'),
        'authRefresh' => route('api.auth.refresh'),
        'authMe' => route('api.auth.me'),
        'roomBooking' => route('api.room.booking'),
        'roomBookingTest' => route('api.room.booking.test'),
        'roomCheckTableStructure' => route('api.room.check-table-structure'),
        'wishlistHotelAdd' => route('api.wishlist.hotel.add'),
        'wishlistHotelRemove' => route('api.wishlist.hotel.remove'),
        'wishlistHotelCheck' => url('/api/wishlist/hotel/check/{hotelId}'),
        'wishlistHotels' => route('api.wishlist.hotels'),
        'userDashboardStats' => route('api.user.dashboard.stats'),
        'userDashboardBookings' => route('api.user.dashboard.bookings'),
        'userDashboardWishlists' => route('api.user.dashboard.wishlists'),
        'userDashboardRecentActivity' => route('api.user.dashboard.recent_activity'),
        'userDashboardSimple' => route('api.user.dashboard.simple'),
        'userTestAuth' => route('api.user.test_auth'),
        'userDashboardStatsSession' => route('api.user.dashboard.stats.session'),
        'userDashboardBookingsSession' => route('api.user.dashboard.bookings.session'),
        'userDashboardWishlistsSession' => route('api.user.dashboard.wishlists.session'),
        'wishlistHotelAddSession' => route('api.wishlist.hotel.add.session'),
        'wishlistHotelRemoveSession' => route('api.wishlist.hotel.remove.session'),
        'wishlistHotelsSession' => route('api.wishlist.hotels.session'),
    ]);
});

// Vendor Authentication Routes
Route::post('/vendor/login', 'FrontEnd\VendorController@apiLogin');
Route::post('/vendor/signup', 'FrontEnd\VendorController@apiSignup');
Route::post('/vendor/resend-verification', 'FrontEnd\VendorController@resendVerificationEmail');
Route::get('/vendor/user', 'FrontEnd\VendorController@getUser');
Route::get('/vendor/auth-status', 'FrontEnd\VendorController@checkAuthStatus');

Route::get('/user/auth-status', 'FrontEnd\UserController@checkUserAuthStatus');

Route::get('/user/dashboard/simple', 'FrontEnd\UserController@getSimpleDashboardData')->name('api.user.dashboard.simple');

Route::middleware(['web', 'auth:web'])->get('/user/test-auth', 'FrontEnd\UserController@testAuth')->name('api.user.test_auth');

Route::get('/user/simple-test', function() {
    return response()->json([
        'success' => true,
        'message' => 'Simple endpoint working',
        'timestamp' => now()->toISOString(),
        'session_id' => session()->getId(),
        'session_started' => session()->isStarted()
    ]);
})->name('api.user.simple_test');

Route::middleware(['auth:api'])->get('/user/jwt-test', function() {
    $user = auth('api')->user();
    return response()->json([
        'success' => true,
        'message' => 'JWT authentication working',
        'user' => $user ? $user->only(['id', 'name', 'email']) : null,
        'timestamp' => now()->toISOString()
    ]);
})->name('api.user.jwt_test');

Route::get('/user/jwt-decode-test', function() {
    $token = request()->bearerToken();
    if (!$token) {
        return response()->json(['error' => 'No token provided']);
    }
    
    try {
        $payload = \Tymon\JWTAuth\Facades\JWTAuth::setToken($token)->getPayload();
        return response()->json([
            'success' => true,
            'payload' => $payload->toArray(),
            'user_id' => $payload->get('sub')
        ]);
    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'error' => $e->getMessage()
        ]);
    }
})->name('api.user.jwt_decode_test');

Route::middleware('auth:web')->group(function () {
    Route::get('/user/dashboard/stats/session', 'FrontEnd\UserController@apiGetDashboardStatsSession')->name('api.user.dashboard.stats.session');
    Route::get('/user/dashboard/bookings/session', 'FrontEnd\UserController@apiGetDashboardBookingsSession')->name('api.user.dashboard.bookings.session');
    Route::get('/user/dashboard/wishlists/session', 'FrontEnd\UserController@apiGetDashboardWishlistsSession')->name('api.user.dashboard.wishlists.session');
    
    // Session-based wishlist endpoints
    Route::post('/wishlist/hotel/add/session', 'FrontEnd\UserController@apiAddHotelToWishlistSession')->name('api.wishlist.hotel.add.session');
    Route::post('/wishlist/hotel/remove/session', 'FrontEnd\UserController@apiRemoveHotelFromWishlistSession')->name('api.wishlist.hotel.remove.session');
    Route::get('/wishlist/hotels/session', 'FrontEnd\UserController@apiGetHotelWishlistsSession')->name('api.wishlist.hotels.session');
});
