<?php
use Illuminate\Support\Facades\Route;
/*
|--------------------------------------------------------------------------
| User Interface Routes
|--------------------------------------------------------------------------
*/
Route::post('/push-notification/store-endpoint', 'FrontEnd\PushNotificationController@store');
Route::get('/subcheck', 'CronJobController@expired')->name('cron.expired');
Route::get('/change-language', 'FrontEnd\MiscellaneousController@changeLanguage')->name('change_language');
Route::get('/csrf-token', function () {
    return response()->json(['token' => csrf_token()]);
})->name('csrf.token');
Route::get('/midtrans/bank-notify', 'MidtransBankController@bankNotify')->name('midtrans.bank.notify');
Route::get('midtrans/cancel', 'MidtransBankController@cancelPayment')->name('midtrans.cancel');
Route::get('myfatoorah/callback', 'MyfatoorahController@myfatoorah_callback')->name('myfatoorah_callback');
Route::get('myfatoorah/cancel', 'MyfatoorahController@myfatoorah_cancel')->name('myfatoorah_cancel');
Route::get('/offline', 'FrontEnd\HomeController@offline')->middleware('change.lang');
Route::get('/login', function () {
  return view('app'); 
})->name('frontend.login');

Route::get('/search', function () {
  return view('app'); 
})->name('frontend.search');
Route::get('/checkout', function () {
  return view('app'); 
})->name('frontend.checkout');
Route::get('/user/dashboard', function () {
  return view('app'); 
})->name('frontend.user.dashboard');
Route::get('/bookings', function () {
  return view('app'); 
})->name('frontend.bookings');
Route::get('/favorites', function () {
  return view('app'); 
})->name('frontend.favorites');
Route::get('/about-us', function () {
  return view('app'); 
})->name('frontend.about');
Route::middleware('change.lang')->group(function () {
  Route::post('/store-subscriber', 'FrontEnd\MiscellaneousController@storeSubscriber')->name('store_subscriber');
  Route::get('/pricing', 'FrontEnd\HomeController@pricing')->name('frontend.pricing');
  Route::get('/faq', 'FrontEnd\FaqController@faq')->name('faq');
  Route::get('/', 'FrontEnd\HomeController@index')->name('index');
  Route::prefix('rooms')->group(function () {
    Route::get('/', 'FrontEnd\RoomController@index')->name('frontend.rooms');
    Route::get('/search-room', 'FrontEnd\RoomController@search_room')->name('frontend.search_room');
  });
  Route::prefix('vendors')->group(function () {
    Route::get('/', 'FrontEnd\VendorController@index')->name('frontend.vendors');
    Route::post('contact/message', 'FrontEnd\VendorController@contact')->name('vendor.contact.message');
  });
  Route::get('vendor/{username}', 'FrontEnd\VendorController@details')->name('frontend.vendor.details');
  Route::prefix('room')->group(function () {
    Route::get('/{slug}/{id}', 'FrontEnd\RoomController@details')->name('frontend.room.details');
    Route::get('/{slug}/{id}/details-data', 'FrontEnd\RoomController@detailsData')->name('frontend.room.details.data');
    Route::get('/{slug}/{id}/get-hourly-price', 'FrontEnd\RoomController@getPrice')->name('frontend.room.details.get_hourly_price');
    Route::post('/room-review/{id}/store-review', 'FrontEnd\RoomController@storeReview')->name('frontend.room.room_details.store_review')->middleware('Demo');
    Route::get('/get-address', 'FrontEnd\RoomController@getAddress')->name('frontend.rooms.get-address');
    Route::post('/go-checkout', 'FrontEnd\BookingController@checkCheckout')->name('frontend.room.go.checkout');
    Route::post('/apply-coupon', 'FrontEnd\BookingController@applyCoupon')->name('frontend.room.apply_coupon');
    Route::post('/add-additional-service', 'FrontEnd\BookingController@additonalService')->name('frontend.room.add_additional_service');
    Route::get('room-addto/wishlist/{id}', 'FrontEnd\UserController@add_to_wishlist_room')->name('addto.wishlist.room');
    Route::get('room-remove/wishlist/{id}', 'FrontEnd\UserController@remove_wishlist_room')->name('remove.wishlist.room');
    Route::get('/store-visitor', 'FrontEnd\RoomController@store_visitor')->name('frontend.store_visitor');
    Route::prefix('/room-booking')->group(function () {
      Route::get('', 'FrontEnd\BookingController@handleOnlineBooking')->name('frontend.room.room_booking.get')->middleware('Demo');
      Route::post('', 'FrontEnd\BookingController@index')->name('frontend.room.room_booking')->middleware('Demo');
      Route::get('/paypal/notify', 'FrontEnd\BookingPayment\PayPalController@notify')->name('frontend.room.room_booking.paypal.notify');
      Route::get('/mollie/notify', 'FrontEnd\BookingPayment\MollieController@notify')->name('frontend.room.room_booking.mollie.notify');
      Route::get('/instamojo/notify', 'FrontEnd\BookingPayment\InstamojoController@notify')->name('frontend.room.room_booking.instamojo.notify');
      Route::post('/razorpay/notify', 'FrontEnd\BookingPayment\RazorpayController@notify')->name('frontend.room.room_booking.razorpay.notify');
      Route::post('/paytm/notify', 'FrontEnd\BookingPayment\PaytmController@notify')->name('frontend.room.room_booking.paytm.notify');
      Route::get('/flutterwave/notify', 'FrontEnd\BookingPayment\FlutterwaveController@notify')->name('frontend.room.room_booking.flutterwave.notify');
      Route::get('/paystack/notify', 'FrontEnd\BookingPayment\PaystackController@notify')->name('frontend.room.room_booking.paystack.notify');
      Route::get('/mercadopago/notify', 'FrontEnd\BookingPayment\MercadoPagoController@notify')->name('frontend.room.room_booking.mercadopago.notify');
      Route::get('/midtrans/notify', 'FrontEnd\BookingPayment\MidtransController@creditCardNotify')->name('frontend.room.room_booking.midtrans.notify');
      Route::any('/phonepe/notify', 'FrontEnd\BookingPayment\PhonepeController@notify')->name('frontend.room.room_booking.phonepe.notify');
      Route::get('/yoco/notify', 'FrontEnd\BookingPayment\YocoController@notify')->name('frontend.room.room_booking.yoco.notify');
      Route::get('/toyyibpay/notify', 'FrontEnd\BookingPayment\ToyyibpayController@notify')->name('frontend.room.room_booking.toyyibpay.notify');
      Route::post('/paytabs/notify', 'FrontEnd\BookingPayment\PaytabsController@notify')->name('frontend.room.room_booking.paytabs.notify');
      Route::get('/perfect-money/notify', 'FrontEnd\BookingPayment\PerfectMoneyController@notify')->name('frontend.room.room_booking.perfect_money.notify');
      Route::get('/xendit/notify', 'FrontEnd\BookingPayment\XenditController@notify')->name('frontend.room.room_booking.xendit.notify');
      Route::post('/iyzico/notify', 'FrontEnd\BookingPayment\IyzicoController@notify')->name('frontend.room.room_booking.iyzico.notify');
      Route::get('/complete/{type?}', 'FrontEnd\BookingPayment\BookingController@complete')->name('frontend.room_booking.complete');
      Route::get('/cancel', 'FrontEnd\BookingController@cancel')->name('frontend.room_booking.cancel');
    });
  });
  Route::prefix('venues')->group(function () {
    Route::get('/', 'FrontEnd\HotelController@index')->name('frontend.hotels');
    Route::get('/search-hotel', 'FrontEnd\HotelController@search_hotel')->name('frontend.search_hotel');
    Route::post('/get-states', 'FrontEnd\HotelController@getState')->name('frontend.hotels.get-state');
    Route::post('/get-cities', 'FrontEnd\HotelController@getCity')->name('frontend.hotels.get-city');
    Route::get('hotel-addto/wishlist/{id}', 'FrontEnd\UserController@add_to_wishlist_hotel')->name('addto.wishlist.hotel');
    Route::get('hotel-remove/wishlist/{id}', 'FrontEnd\UserController@remove_wishlist_hotel')->name('remove.wishlist.hotel');
  });
  Route::get('/venue/{slug}/{id}', 'FrontEnd\HotelController@details')->name('frontend.hotel.details');
  Route::prefix('/blog')->group(function () {
    Route::get('', 'FrontEnd\BlogController@index')->name('blog');
    Route::get('/{slug}/{id}',  'FrontEnd\BlogController@details')->name('blog_details');
  });
  Route::prefix('/contact')->group(function () {
    Route::get('', 'FrontEnd\ContactController@contact')->name('contact');
    Route::post('/send-mail', 'FrontEnd\ContactController@sendMail')->name('contact.send_mail');
  });
});
Route::post('/advertisement/{id}/count-view', 'FrontEnd\MiscellaneousController@countAdView');
Route::prefix('login')->group(function () {
  Route::prefix('/user/facebook')->group(function () {
    Route::get('', 'FrontEnd\UserController@redirectToFacebook')->name('user.login.facebook');
    Route::get('/callback', 'FrontEnd\UserController@handleFacebookCallback');
  });
  Route::prefix('/google')->group(function () {
    Route::get('', 'FrontEnd\UserController@redirectToGoogle')->name('user.login.google');
    Route::get('/callback', 'FrontEnd\UserController@handleGoogleCallback');
  });
});
Route::get('/service-unavailable', 'FrontEnd\MiscellaneousController@serviceUnavailable')->name('service_unavailable')->middleware('exists.down');
/*
|--------------------------------------------------------------------------
| admin frontend route
|--------------------------------------------------------------------------
*/
Route::prefix('/admin')->group(function () {
    Route::get('/', 'Admin\AdminController@login')->name('admin.login');
    Route::post('/auth', 'Admin\AdminController@authentication')->name('admin.auth');
    Route::get('/forget-password', 'Admin\AdminController@forgetPassword')->name('admin.forget_password');
    Route::post('/mail-for-forget-password', 'Admin\AdminController@forgetPasswordMail')->name('admin.mail_for_forget_password');
    Route::get('/csrf-token', function () {
        return response()->json(['token' => csrf_token()]);
    })->name('admin.csrf_token');
});
/*
|--------------------------------------------------------------------------
| Custom Page Route For UI
|--------------------------------------------------------------------------
*/
Route::get('/{slug}', 'FrontEnd\PageController@page')->name('dynamic_page')->middleware('change.lang')->where('slug', '^(?!bookings|favorites|user|hotels|search|checkout|login|about-us|rooms).*$');
Route::get('/user/{any?}', function () {
  return view('app'); 
})->where('any', '.*')->name('frontend.user.any');

Route::get('/hotels/{id?}', function () {
  return view('app'); 
})->name('frontend.hotels.react');

Route::fallback(function () {
  return view('app'); 
})->middleware('change.lang');
Route::get('/test-csrf', function () {
    return response()->json([
        'csrf_token' => csrf_token(),
        'session_id' => session()->getId(),
        'session_status' => session()->isStarted() ? 'started' : 'not_started'
    ]);
});
Route::get('/test-react', function () {
    return view('app');
})->name('test.react');
