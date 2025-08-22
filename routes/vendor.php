<?php

use App\Http\Controllers\Vendor\CustomPricingController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| vendor Interface Routes
|--------------------------------------------------------------------------
*/

Route::prefix('vendor')->middleware('change.lang')->group(function () {
  // Vendor login route - redirects to home if not authenticated
  Route::get('/login', function() {
    return redirect('/');
  })->name('vendor.login');

  // Vendor login/signup handled by React frontend via API
  // Route::get('/signup', 'FrontEnd\VendorController@signup')->name('vendor.signup');
  // Route::post('/signup/submit', 'FrontEnd\VendorController@apiSignup')->name('vendor.signup_submit')->middleware('Demo');
  // Route::post('/login/submit', 'FrontEnd\VendorController@apiLogin')->name('vendor.login_submit');

  Route::get('/email/verify', 'Vendor\VendorController@confirm_email');
Route::get('/verify-email/{token}', 'Vendor\VendorController@verifyEmail')->name('vendor.verify.email');

  Route::get('/forget-password', 'Vendor\VendorController@forget_passord')->name('vendor.forget.password');
  Route::post('/send-forget-mail', 'Vendor\VendorController@forget_mail')->name('vendor.forget.mail')->middleware('Demo');
  Route::get('/reset-password', 'Vendor\VendorController@reset_password')->name('vendor.reset.password');
  Route::post('/update-forget-password', 'Vendor\VendorController@update_password')->name('vendor.update-forget-password')->middleware('Demo');
});

Route::get('/set-locale-vendor', 'Vendor\VendorController@setLocaleAdmin')->name('set-locale-vendor');

// Vendor Dashboard Route (JWT compatible)
Route::get('/vendor/dashboard', 'Vendor\VendorController@dashboard')->name('vendor.dashboard')->middleware('jwt.to.vendor.session');

Route::prefix('vendor')->middleware('auth:vendor', 'Demo', 'Deactive', 'email.verify', 'vendorLang')->group(function () {

  //========Hotels Management//
  Route::prefix('venue-management')->group(function () {

    Route::get('/', 'Vendor\HotelController@index')->name('vendor.hotel_management.hotels');

    Route::prefix('/purchase-feature')->group(function () {

      Route::post('', 'Vendor\HotelFeature\HotelFeatureController@index')->name('vendor.hotel_management.hotel.purchase_feature');

      Route::get('/paypal/notify', 'Vendor\HotelFeature\PayPalController@notify')->name('vendor.hotel_management.hotel.purchase_feature.paypal.notify');
      Route::get('/instamojo/notify', 'Vendor\HotelFeature\InstamojoController@notify')->name('vendor.hotel_management.hotel.purchase_feature.instamojo.notify');
      Route::get('/flutterwave/notify', 'Vendor\HotelFeature\FlutterwaveController@notify')->name('vendor.hotel_management.hotel.purchase_feature.flutterwave.notify');
      Route::post('/razorpay/notify', 'Vendor\HotelFeature\RazorpayController@notify')->name('vendor.hotel_management.hotel.purchase_feature.razorpay.notify');
      Route::get('/mollie/notify', 'Vendor\HotelFeature\MollieController@notify')->name('vendor.hotel_management.hotel.purchase_feature.mollie.notify');
      Route::get('/yoco/notify', 'Vendor\HotelFeature\YocoController@notify')->name('vendor.hotel_management.hotel.purchase_feature.yoco.notify');
      Route::post('/paytabs/notify', 'Vendor\HotelFeature\PaytabsController@notify')->name('vendor.hotel_management.hotel.purchase_feature.paytabs.notify');
      Route::get('/toyyibpay/notify', 'Vendor\HotelFeature\ToyyibpayController@notify')->name('vendor.hotel_management.hotel.purchase_feature.toyyibpay.notify');
      Route::get('/midtrans/notify', 'Vendor\HotelFeature\MidtransController@creditCardNotify')->name('vendor.hotel_management.hotel.purchase_feature.midtrans.notify');
      Route::get('/paystack/notify', 'Vendor\HotelFeature\PaystackController@notify')->name('vendor.hotel_management.hotel.purchase_feature.paystack.notify');
      Route::post('/iyzico/notify', 'Vendor\HotelFeature\IyzicoController@notify')->name('vendor.hotel_management.hotel.purchase_feature.iyzico.notify');
      Route::get('/iyzico/cancle', 'Vendor\HotelFeature\IyzicoController@iyzicoCancle')->name('vendor.hotel_management.hotel.purchase_feature.iyzico.cancle');
      Route::get('/mercadopago/notify', 'Vendor\HotelFeature\MercadoPagoController@notify')->name('vendor.hotel_management.hotels.purchase_feature.mercadopago.notify');
      Route::post('/paytm/notify', 'Vendor\HotelFeature\PaytmController@notify')->name('vendor.hotel_management.hotels.purchase_feature.paytm.notify');
      Route::get('/xendit/notify', 'Vendor\HotelFeature\XenditController@notify')->name('vendor.hotel_management.hotels.purchase_feature.xendit.notify');
      Route::get('/perfect-money/notify', 'Vendor\HotelFeature\PerfectMoneyController@notify')->name('vendor.hotel_management.hotels.purchase_feature.perfect_money.notify');
      Route::any('/phonepe/notify', 'Vendor\HotelFeature\PhonepeController@notify')->name('vendor.hotel_management.hotels.phonepe.notify');


      
      Route::get('/online/success', 'Vendor\RoomFeature\RoomFeatureController@onlineSuccess')->name('featured.service.online.success.page');

      Route::get('/offline/success', 'Vendor\RoomFeature\RoomFeatureController@offlineSuccess')->name('vendor.room_management.room.purchase_feature.offline.success');
    });

    Route::post('/get-state', 'Vendor\HotelController@getState')->name('vendor.hotel_management.get-state');
    Route::post('/get-city', 'Vendor\HotelController@getCity')->name('vendor.hotel_management.get-city');

    Route::get('/create', 'Vendor\HotelController@create')->name('vendor.hotel_management.create_hotel');
    Route::post('store', 'Vendor\HotelController@store')->name('vendor.hotel_management.store_hotel')->middleware('packageLimitsCheck:hotel,store');

    Route::get('edit-hotel/{id}', 'Vendor\HotelController@edit')->name('vendor.hotel_management.edit_hotel');
    Route::post('update/{id}', 'Vendor\HotelController@update')->name('vendor.hotel_management.update_hotel')->middleware('packageLimitsCheck:hotel,update');

    Route::post('delete/{id}', 'Vendor\HotelController@delete')->name('vendor.hotel_management.delete_hotel');
    Route::post('bulk_delete', 'Vendor\HotelController@bulkDelete')->name('vendor.hotel_management.bulk_delete.hotel');

    Route::post('update-status', 'Vendor\HotelController@updateStatus')->name('vendor.hotel_management.update_hotel_status');

    Route::get('manage-counter-section/{id}', 'Vendor\HotelController@manageCounterInformation')->name('vendor.hotel_management.manage_counter_section');
    Route::post('upadte-counter-section/{id}', 'Vendor\HotelController@updateCounterInformation')->name('vendor.hotel_management.update_counter_section')->middleware('packageLimitsCheck:hotel,update');
    Route::post('counter/delete', 'Vendor\HotelController@CounterDelete')->name('vendor.hotel_management.delete_counter');

    Route::post('aminitie/cng', 'Vendor\HotelController@amenitiesUpdate')->name('vendor.hotel_management.update_amenities');


    //#==========Hotel slider image
    Route::post('/img-store', 'Vendor\HotelController@imagesstore')->name('vendor.hotel_management.hotel.imagesstore');
    Route::post('/img-remove', 'Vendor\HotelController@imagermv')->name('vendor.hotel_management.hotel.imagermv');
    Route::post('/img-db-remove', 'Vendor\HotelController@imagedbrmv')->name('vendor.hotel_management.hotel.imgdbrmv');
    //#==========Hotel slider image End

    // holiday route
    Route::prefix('block-out-dates')->group(function () {
      Route::get('/', 'Vendor\HolidayController@index')->name('vendor.hotel_management.hotel.holiday');
      Route::post('/store', 'Vendor\HolidayController@store')->name('vendor.hotel_management.hotel.holiday.store')->middleware('packageLimitsCheck:hotel,update');
      Route::post('/delete/{id}', 'Vendor\HolidayController@destroy')->name('vendor.hotel_management.hotel.holiday.delete');
      Route::post('/bulk-destory', 'Vendor\HolidayController@blukDestroy')->name('vendor.global.holiday.bluk-destroy');
    });
  });
  //=====Hotels Management END============

  //========ROOMS MANAGEMENT//
  Route::prefix('rooms-management')->group(function () {

    // coupon route
    Route::prefix('coupons')->group(function () {
      Route::get('/', 'Vendor\CouponController@index')->name('vendor.room_management.coupons');
      Route::post('/store', 'Vendor\CouponController@store')->name('vendor.room_management.coupon.store');
      Route::post('/update', 'Vendor\CouponController@update')->name('vendor.room_management.coupon.update');
      Route::post('/delete/{id}', 'Vendor\CouponController@destroy')->name('vendor.room_management.coupon.delete');
      Route::post('/bulk-delete', 'Vendor\CouponController@bulkDestroy')->name('vendor.room_management.coupon.bulk_delete');
    });

    Route::prefix('custom-pricing')->group(function () {
      Route::get('/', 'Vendor\CustomPricingController@index')->name('vendor.room_management.custom_pricing');
      Route::post('/store', 'Vendor\CustomPricingController@store')->name('vendor.custom.pricing.store');
      Route::get('vendor/custom-pricing/{id}/edit', [CustomPricingController::class, 'edit'])->name('vendor.custom.pricing.edit');
      Route::put('vendor/custom-pricing/{id}/update', [CustomPricingController::class, 'update'])->name('vendor.custom.pricing.update');
      Route::any('/delete-single/{id}', [CustomPricingController::class, 'destroySingle']) ->name('vendor.custom.pricing.destroy.single');
    });
    Route::get('/', 'Vendor\RoomController@index')->name('vendor.room_management.rooms');

    Route::prefix('/purchase-feature')->group(function () {

      Route::post('', 'Vendor\RoomFeature\RoomFeatureController@index')->name('vendor.room_management.room.purchase_feature');

      Route::get('/paypal/notify', 'Vendor\RoomFeature\PayPalController@notify')->name('vendor.room_management.room.purchase_feature.paypal.notify');
      Route::get('/instamojo/notify', 'Vendor\RoomFeature\InstamojoController@notify')->name('vendor.room_management.room.purchase_feature.instamojo.notify');
      Route::get('/flutterwave/notify', 'Vendor\RoomFeature\FlutterwaveController@notify')->name('vendor.room_management.room.purchase_feature.flutterwave.notify');
      Route::post('/razorpay/notify', 'Vendor\RoomFeature\RazorpayController@notify')->name('vendor.room_management.room.purchase_feature.razorpay.notify');
      Route::get('/mollie/notify', 'Vendor\RoomFeature\MollieController@notify')->name('vendor.room_management.room.purchase_feature.mollie.notify');
      Route::get('/yoco/notify', 'Vendor\RoomFeature\YocoController@notify')->name('vendor.room_management.room.purchase_feature.yoco.notify');
      Route::post('/paytabs/notify', 'Vendor\RoomFeature\PaytabsController@notify')->name('vendor.room_management.room.purchase_feature.paytabs.notify');
      Route::get('/toyyibpay/notify', 'Vendor\RoomFeature\ToyyibpayController@notify')->name('vendor.room_management.room.purchase_feature.toyyibpay.notify');
      Route::get('/midtrans/notify', 'Vendor\RoomFeature\MidtransController@creditCardNotify')->name('vendor.room_management.room.purchase_feature.midtrans.notify');
      Route::get('/paystack/notify', 'Vendor\RoomFeature\PaystackController@notify')->name('vendor.room_management.room.purchase_feature.paystack.notify');
      Route::post('/iyzico/notify', 'Vendor\RoomFeature\IyzicoController@notify')->name('vendor.room_management.room.purchase_feature.iyzico.notify');
      Route::get('/iyzico/cancle', 'Vendor\RoomFeature\IyzicoController@iyzicoCancle')->name('vendor.room_management.room.purchase_feature.iyzico.cancle');
      Route::get('/mercadopago/notify', 'Vendor\RoomFeature\MercadoPagoController@notify')->name('vendor.room_management.room.purchase_feature.mercadopago.notify');
      Route::post('/paytm/notify', 'Vendor\RoomFeature\PaytmController@notify')->name('vendor.room_management.room.purchase_feature.paytm.notify');
      Route::get('/xendit/notify', 'Vendor\RoomFeature\XenditController@notify')->name('vendor.room_management.room.purchase_feature.xendit.notify');
      Route::get('/perfect-money/notify', 'Vendor\RoomFeature\PerfectMoneyController@notify')->name('vendor.room_management.room.purchase_feature.perfect_money.notify');
      Route::any('/phonepe/notify', 'Vendor\RoomFeature\PhonepeController@notify')->name('vendor.room_management.room.phonepe.notify');



      
      Route::get('/online/success', 'Vendor\RoomFeature\RoomFeatureController@onlineSuccess')->name('featured.service.online.success.page');

      Route::get('/offline/success', 'Vendor\RoomFeature\RoomFeatureController@offlineSuccess')->name('vendor.room_management.room.purchase_feature.offline.success');
    });
   

    Route::get('/create', 'Vendor\RoomController@create')->name('vendor.room_management.create_room');
    Route::post('store', 'Vendor\RoomController@store')->name('vendor.room_management.store_room')->middleware('packageLimitsCheck:room,store');

    Route::get('edit-room/{id}', 'Vendor\RoomController@edit')->name('vendor.room_management.edit_room');
    Route::post('update/{id}', 'Vendor\RoomController@update')->name('vendor.room_management.update_room')->middleware('packageLimitsCheck:room,update');

    Route::post('delete/{id}', 'Vendor\RoomController@delete')->name('vendor.room_management.delete_room');
    Route::post('bulk_delete', 'Vendor\RoomController@bulkDelete')->name('vendor.room_management.bulk_delete.room');
    Route::post('update-status', 'Vendor\RoomController@updateStatus')->name('vendor.room_management.update_room_status');
    Route::get('manage-additional-service/{id}', 'Vendor\RoomController@manageAdditionalService')->name('vendor.room_management.manage_additional_service');
    Route::post('upadte-additional-service/{id}', 'Vendor\RoomController@updateAdditionalService')->name('vendor.room_management.update_additional_service')->middleware('packageLimitsCheck:hotel,update');
    Route::post('aminitie/cng', 'Vendor\RoomController@amenitiesUpdate')->name('vendor.room_management.update_amenities');



    //#==========ROOM slider image
    Route::post('/img-store', 'Vendor\RoomController@imagesstore')->name('vendor.room_management.room.imagesstore');
    Route::post('/img-remove', 'Vendor\RoomController@imagermv')->name('vendor.room_management.room.imagermv');
    Route::post('/img-db-remove', 'Vendor\RoomController@imagedbrmv')->name('vendor.room_management.room.imgdbrmv');
    //#==========ROOM slider image End
  });
  //=====Rooms MANAGEMENT END============

  // Room Bookings Routes
  Route::prefix('rooms-bookings')->group(function () {

    Route::get('/all-bookings', 'Vendor\RoomBookingController@index')->name('vendor.room_bookings.all_bookings');

    Route::get('/paid-bookings', 'Vendor\RoomBookingController@index')->name('vendor.room_bookings.paid_bookings');

    Route::get('/unpaid-bookings', 'Vendor\RoomBookingController@index')->name('vendor.room_bookings.unpaid_bookings');

    Route::post('/update-payment-status', 'Vendor\RoomBookingController@updatePaymentStatus')->name('vendor.room_bookings.update_payment_status');

    Route::get('/booking-details-and-edit/{id}', 'Vendor\RoomBookingController@editBookingDetails')->name('vendor.room_bookings.booking_details_and_edit');

    Route::get('/booking-details/{id}', 'Vendor\RoomBookingController@details')->name('vendor.room_bookings.booking_details');

    Route::post('/update-booking', 'Vendor\RoomBookingController@updateBooking')->name('vendor.room_bookings.update_booking')->middleware('packageLimitsCheck:hotel,update');

    Route::post('/send-mail', 'Vendor\RoomBookingController@sendMail')->name('vendor.room_bookings.send_mail');

    Route::get('/get-booked-dates', 'Vendor\RoomBookingController@bookedDates')->name('vendor.room_bookings.get_booked_dates');

    Route::get('/{slug}/{id}/get-hourly-price', 'Vendor\RoomBookingController@getPrice')->name('vendor.room_bookings.get_hourly_price');

    Route::get('/{slug}/{id}/get-hourly-price-edit', 'Vendor\RoomBookingController@getPriceForEdit')->name('vendor.room_bookings.get_hourly_price_edit');

    Route::get('/booking-form', 'Vendor\RoomBookingController@bookingForm')->name('vendor.room_bookings.booking_form');

    Route::post('/make-booking', 'Vendor\RoomBookingController@makeBooking')->name('vendor.room_bookings.make_booking')->middleware('packageLimitsCheck:hotel,update');
  });

  // Room Bookings Routes END

  //MAil set for recived Mail
  Route::get('/mail-to-vendor', 'Vendor\MAilSetController@mailToVendor')->name('vendor.email_setting.mail_to_admin');
  Route::post('/update-mail-to-vendor', 'Vendor\MAilSetController@updateMailToVendor')->name('vendor.update_mail_to_vendor')->middleware('packageLimitsCheck:hotel,update');

  //profile
  Route::get('calendar', 'Vendor\VendorController@calendar')->name('vendor.calendar');
  Route::get('/change-password', 'Vendor\VendorController@change_password')->name('vendor.change_password');
  Route::post('/update-password', 'Vendor\VendorController@updated_password')->name('vendor.update_password');
  Route::get('/edit-profile', 'Vendor\VendorController@editProfile')->name('vendor.edit.profile');
  Route::post('/profile/update', 'Vendor\VendorController@updateProfile')->name('vendor.update_profile');
  Route::get('/logout', 'Vendor\VendorController@logout')->name('vendor.logout');

  // change admin-panel theme (dark/light) route
  Route::post('/change-theme', 'Vendor\VendorController@changeTheme')->name('vendor.change_theme')->withoutMiddleware('Demo');
  Route::get('/subscription-log', 'Vendor\VendorController@subscriptionLog')->name('vendor.payment_log');

  //vendor package extend route
  Route::get('/package-list', 'Vendor\BuyPlanController@index')->name('vendor.plan.extend.index');
  Route::get('/package/checkout/{package_id}', 'Vendor\BuyPlanController@checkout')->name('vendor.plan.extend.checkout');
  Route::post('/package/checkout', 'Vendor\VendorCheckoutController@checkout')->name('vendor.plan.checkout');

  Route::post('/payment/instructions', 'Vendor\VendorCheckoutController@paymentInstruction')->name('vendor.payment.instructions');


  //checkout payment gateway routes
  Route::prefix('membership')->group(function () {
    Route::get('paypal/success', "Payment\PaypalController@successPayment")->name('membership.paypal.success');
    Route::get('paypal/cancel', "Payment\PaypalController@cancelPayment")->name('membership.paypal.cancel');
    Route::get('stripe/cancel', "Payment\StripeController@cancelPayment")->name('membership.stripe.cancel');
    Route::post('paytm/payment-status', "Payment\PaytmController@paymentStatus")->name('membership.paytm.status');
    Route::get('paystack/success', 'Payment\PaystackController@successPayment')->name('membership.paystack.success');
    Route::post('mercadopago/cancel', 'Payment\MercadopagoController@cancelPayment')->name('membership.mercadopago.cancel');
    Route::get('mercadopago/success', 'Payment\MercadopagoController@successPayment')->name('membership.mercadopago.success');
    Route::post('razorpay/success', 'Payment\RazorpayController@successPayment')->name('membership.razorpay.success');
    Route::post('razorpay/cancel', 'Payment\RazorpayController@cancelPayment')->name('membership.razorpay.cancel');
    Route::get('instamojo/success', 'Payment\InstamojoController@successPayment')->name('membership.instamojo.success');
    Route::post('instamojo/cancel', 'Payment\InstamojoController@cancelPayment')->name('membership.instamojo.cancel');
    Route::post('flutterwave/success', 'Payment\FlutterWaveController@successPayment')->name('membership.flutterwave.success');
    Route::post('flutterwave/cancel', 'Payment\FlutterWaveController@cancelPayment')->name('membership.flutterwave.cancel');
    Route::get('/mollie/success', 'Payment\MollieController@successPayment')->name('membership.mollie.success');
    Route::post('mollie/cancel', 'Payment\MollieController@cancelPayment')->name('membership.mollie.cancel');
    Route::get('anet/cancel', 'Payment\AuthorizeController@cancelPayment')->name('membership.anet.cancel');
    Route::post('/iyzico/notify', 'Payment\IyzicoController@notify')->name('membership.iyzico.notify');
    Route::get('/iyzico/cancle', 'Payment\IyzicoController@iyzicoCancle')->name('membership.iyzico.cancle');
    Route::get('/midtrans/notify', 'Payment\MidtransController@creditCardNotify')->name('membership.midtrans.notify');
    Route::any('/phonepe/notify', 'Payment\PhonepeController@notify')->name('membership.phonepe.notify');
    Route::get('/yoco/notify', 'Payment\YocoController@notify')->name('membership.yoco.notify');
    Route::get('/toyyibpay/notify', 'Payment\ToyyibpayController@notify')->name('membership.toyyibpay.notify');
    Route::post('/paytabs/notify', 'Payment\PaytabsController@notify')->name('membership.paytabs.notify');
    Route::get('/paytabs/cancel', 'Payment\PaytabsController@cancel')->name('membership.paytabs.cancel');
    Route::get('/perfect-money/notify', 'Payment\PerfectMoneyController@notify')->name('membership.perfect_money.notify');
    Route::get('/xendit/notify', 'Payment\XenditController@notify')->name('membership.xendit.notify');

    Route::get('/cancel', 'Vendor\VendorCheckoutController@cancel')->name('membership.cancel');
    Route::get('/offline/success', 'Front\CheckoutController@offlineSuccess')->name('membership.offline.success');
    Route::get('/trial/success', 'Front\CheckoutController@trialSuccess')->name('membership.trial.success');

    Route::get('/online/success', 'Vendor\VendorCheckoutController@onlineSuccess')->name('success.page');
  });

  // ====================== withdraw =================

  Route::prefix('withdraw')->group(function () {
    Route::get('/', 'Vendor\VendorWithdrawController@index')->name('vendor.withdraw');
    Route::get('/create', 'Vendor\VendorWithdrawController@create')->name('vendor.withdraw.create');
    Route::get('/get-method/input/{id}', 'Vendor\VendorWithdrawController@get_inputs');

    Route::get('/balance-calculation/{method}/{amount}', 'Vendor\VendorWithdrawController@balance_calculation');

    Route::post('/send-request', 'Vendor\VendorWithdrawController@send_request')->name('vendor.withdraw.send-request')->middleware('packageLimitsCheck:hotel,update');
    Route::post('/witdraw/bulk-delete', 'Vendor\VendorWithdrawController@bulkDelete')->name('vendor.witdraw.bulk_delete_withdraw');
    Route::post('/witdraw/delete', 'Vendor\VendorWithdrawController@Delete')->name('vendor.witdraw.delete_withdraw');
  });

  Route::get('/transcation', 'Vendor\VendorController@transcation')->name('vendor.transcation');

  #====support tickets ============
  Route::get('support/ticket/create', 'Vendor\SupportTicketController@create')->name('vendor.support_ticket.create');
  Route::post('support/ticket/store', 'Vendor\SupportTicketController@store')->name('vendor.support_ticket.store');
  Route::get('support/tickets', 'Vendor\SupportTicketController@index')->name('vendor.support_tickets');
  Route::get('support/message/{id}', 'Vendor\SupportTicketController@message')->name('vendor.support_tickets.message');
  Route::post('support-ticket/reply/{id}', 'Vendor\SupportTicketController@ticketreply')->name('vendor.support_ticket.reply');

  Route::post('support-ticket/delete/{id}', 'Vendor\SupportTicketController@delete')->name('vendor.support_tickets.delete');
});

// Vendor API Routes - moved from api.php to avoid 419 CSRF errors
Route::prefix('api/vendor')->middleware(['web', 'auth:vendor', 'Demo', 'Deactive', 'email.verify', 'vendorLang'])->group(function () {
    // Vendor authentication and user management
    Route::post('/login', 'FrontEnd\VendorController@apiLogin')->name('api.vendor.login');
    Route::post('/signup', 'FrontEnd\VendorController@apiSignup')->name('api.vendor.signup');
    Route::post('/resend-verification', 'FrontEnd\VendorController@resendVerificationEmail')->name('api.vendor.resend-verification');
    Route::get('/user', 'FrontEnd\VendorController@getUser')->name('api.vendor.user');
    Route::get('/auth-status', 'FrontEnd\VendorController@checkAuthStatus')->name('api.vendor.auth-status');
    
    // Hotel management API endpoints
    Route::post('/hotels/store', 'Vendor\HotelController@store')->name('api.vendor.hotels.store');
    Route::post('/hotels/update/{id}', 'Vendor\HotelController@update')->name('api.vendor.hotels.update');
    Route::post('/hotels/delete/{id}', 'Vendor\HotelController@delete')->name('api.vendor.hotels.delete');
    Route::post('/hotels/bulk-delete', 'Vendor\HotelController@bulkDelete')->name('api.vendor.hotels.bulk-delete');
    Route::post('/hotels/update-status', 'Vendor\HotelController@updateStatus')->name('api.vendor.hotels.update-status');
    Route::post('/hotels/update-counter-section/{id}', 'Vendor\HotelController@updateCounterInformation')->name('api.vendor.hotels.update-counter-section');
    Route::post('/hotels/counter/delete', 'Vendor\HotelController@CounterDelete')->name('api.vendor.hotels.counter-delete');
    Route::post('/hotels/amenities/update', 'Vendor\HotelController@amenitiesUpdate')->name('api.vendor.hotels.amenities-update');
    Route::post('/hotels/images/store', 'Vendor\HotelController@imagesstore')->name('api.vendor.hotels.images-store');
    Route::post('/hotels/images/remove', 'Vendor\HotelController@imagermv')->name('api.vendor.hotels.images-remove');
    Route::post('/hotels/images/db-remove', 'Vendor\HotelController@imagedbrmv')->name('api.vendor.hotels.images-db-remove');
    
    // Holiday/Block-out dates management
    Route::post('/holidays/store', 'Vendor\HolidayController@store')->name('api.vendor.holidays.store');
    Route::post('/holidays/delete/{id}', 'Vendor\HolidayController@destroy')->name('api.vendor.holidays.delete');
    Route::post('/holidays/bulk-destroy', 'Vendor\HolidayController@blukDestroy')->name('api.vendor.holidays.bulk-destroy');
    
    // Room management API endpoints
    Route::post('/rooms/store', 'Vendor\RoomController@store')->name('api.vendor.rooms.store');
    Route::post('/rooms/update/{id}', 'Vendor\RoomController@update')->name('api.vendor.rooms.update');
    Route::post('/rooms/delete/{id}', 'Vendor\RoomController@delete')->name('api.vendor.rooms.delete');
    Route::post('/rooms/bulk-delete', 'Vendor\RoomController@bulkDelete')->name('api.vendor.rooms.bulk-delete');
    Route::post('/rooms/update-status', 'Vendor\RoomController@updateStatus')->name('api.vendor.rooms.update-status');
    Route::post('/rooms/update-additional-service/{id}', 'Vendor\RoomController@updateAdditionalService')->name('api.vendor.rooms.update-additional-service');
    Route::post('/rooms/amenities/update', 'Vendor\RoomController@amenitiesUpdate')->name('api.vendor.rooms.amenities-update');
    Route::post('/rooms/images/store', 'Vendor\RoomController@imagesstore')->name('api.vendor.rooms.images-store');
    Route::post('/rooms/images/remove', 'Vendor\RoomController@imagermv')->name('api.vendor.rooms.images-remove');
    Route::post('/rooms/images/db-remove', 'Vendor\RoomController@imagedbrmv')->name('api.vendor.rooms.images-db-remove');
    
    // Coupon management
    Route::post('/coupons/store', 'Vendor\CouponController@store')->name('api.vendor.coupons.store');
    Route::post('/coupons/update', 'Vendor\CouponController@update')->name('api.vendor.coupons.update');
    Route::post('/coupons/delete/{id}', 'Vendor\CouponController@destroy')->name('api.vendor.coupons.delete');
    Route::post('/coupons/bulk-delete', 'Vendor\CouponController@bulkDestroy')->name('api.vendor.coupons.bulk-delete');
    
    // Custom pricing management
    Route::post('/custom-pricing/store', 'Vendor\CustomPricingController@store')->name('api.vendor.custom-pricing.store');
    Route::put('/custom-pricing/{id}/update', 'Vendor\CustomPricingController@update')->name('api.vendor.custom-pricing.update');
    Route::any('/custom-pricing/delete-single/{id}', 'Vendor\CustomPricingController@destroySingle')->name('api.vendor.custom-pricing.delete-single');
    
    // Room bookings management
    Route::post('/bookings/update-payment-status', 'Vendor\RoomBookingController@updatePaymentStatus')->name('api.vendor.bookings.update-payment-status');
    Route::post('/bookings/update-booking', 'Vendor\RoomBookingController@updateBooking')->name('api.vendor.bookings.update-booking');
    Route::post('/bookings/send-mail', 'Vendor\RoomBookingController@sendMail')->name('api.vendor.bookings.send-mail');
    Route::post('/bookings/make-booking', 'Vendor\RoomBookingController@makeBooking')->name('api.vendor.bookings.make-booking');
    
    // Profile and settings
    Route::post('/profile/update', 'Vendor\VendorController@updateProfile')->name('api.vendor.profile.update');
    Route::post('/password/update', 'Vendor\VendorController@updated_password')->name('api.vendor.password.update');
    Route::post('/theme/change', 'Vendor\VendorController@changeTheme')->name('api.vendor.theme.change');
    Route::post('/logout', 'FrontEnd\VendorController@apiLogout')->name('api.vendor.logout');
    
    // Mail settings
    Route::post('/mail-settings/update', 'Vendor\MAilSetController@updateMailToVendor')->name('api.vendor.mail-settings.update');
    
    // Support tickets
    Route::post('/support-tickets/store', 'Vendor\SupportTicketController@store')->name('api.vendor.support-tickets.store');
    Route::post('/support-tickets/reply/{id}', 'Vendor\SupportTicketController@ticketreply')->name('api.vendor.support-tickets.reply');
    Route::post('/support-tickets/delete/{id}', 'Vendor\SupportTicketController@delete')->name('api.vendor.support-tickets.delete');
    
    // Withdraw management
    Route::post('/withdraw/send-request', 'Vendor\VendorWithdrawController@send_request')->name('api.vendor.withdraw.send-request');
    Route::post('/withdraw/bulk-delete', 'Vendor\VendorWithdrawController@bulkDelete')->name('api.vendor.withdraw.bulk-delete');
    Route::post('/withdraw/delete', 'Vendor\VendorWithdrawController@Delete')->name('api.vendor.withdraw.delete');
    
    // Package and checkout
    Route::post('/package/checkout', 'Vendor\VendorCheckoutController@checkout')->name('api.vendor.package.checkout');
    Route::post('/payment/instructions', 'Vendor\VendorCheckoutController@paymentInstruction')->name('api.vendor.payment.instructions');
});

// Public vendor API routes (no authentication required)
Route::prefix('api/vendor')->middleware(['web'])->group(function () {
    Route::post('/login', 'FrontEnd\VendorController@apiLogin')->name('api.vendor.login.public');
    Route::post('/signup', 'FrontEnd\VendorController@apiSignup')->name('api.vendor.signup.public');
    Route::post('/resend-verification', 'FrontEnd\VendorController@resendVerificationEmail')->name('api.vendor.resend-verification.public');
    Route::get('/user', 'FrontEnd\VendorController@getUser')->name('api.vendor.user.public');
    Route::get('/auth-status', 'FrontEnd\VendorController@checkAuthStatus')->name('api.vendor.auth-status.public');
    Route::post('/logout', 'FrontEnd\VendorController@apiLogout')->name('api.vendor.logout.public');
});


