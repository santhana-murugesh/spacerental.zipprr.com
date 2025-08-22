<?php

namespace App\Http\Middleware;

use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken as Middleware;

class VerifyCsrfToken extends Middleware
{
  /**
   * The URIs that should be excluded from CSRF verification.
   *
   * @var array
   */
  protected $except = [

    '/get-model',
    '/admin/menu-builder/update-menus',
    '/push-notification/store-endpoint',

    '/*paytm/payment-status*',
    '/vendor/membership/mercadopago/cancel',
    '/vendor/membership/mercadopago/success',
    '*/vendor/membership/razorpay/success',
    '*/vendor/membership/razorpay/cancel',
    '/vendor/membership/instamojo/cancel',
    '/*flutterwave/success',
    '/vendor/membership/flutterwave/cancel',
    '/vendor/membership/mollie/cancel',

    '/membership/paytm/payment-status*',
    '/membership/mercadopago/cancel',
    '/membership/razorpay/success',
    '/membership/razorpay/cancel',
    '/membership/instamojo/cancel',
    '/membership/flutterwave/success',
    '/membership/flutterwave/cancel',
    '/membership/mollie/cancel',

    '*/iyzico/notify',
    '*/paytabs/notify/',
    '*/phonepe/notify',
    '/xendit/callback'
  ];

  /**
   * Determine if the session and input CSRF tokens match.
   *
   * @param  \Illuminate\Http\Request  $request
   * @return bool
   */
  protected function tokensMatch($request)
  {
    $sessionToken = $request->session()->token();
    $token = $request->input('_token') ?: $request->header('X-CSRF-TOKEN');

    if (!$token && $request->header('X-XSRF-TOKEN')) {
      $token = $this->encrypter->decrypt($request->header('X-XSRF-TOKEN'), static::serialized());
    }

    if (!$token) {
      return false;
    }

    // Extend CSRF token lifetime by refreshing the session
    // if ($request->session()->isStarted()) {
    //   $request->session()->regenerateToken();
    // }

    return is_string($sessionToken) && is_string($token) && hash_equals($sessionToken, $token);
  }
}
