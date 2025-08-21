@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Online Gateways') }}</h4>
    <ul class="breadcrumbs">
      <li class="nav-home">
        <a href="{{ route('admin.dashboard') }}">
          <i class="flaticon-home"></i>
        </a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Settings') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Payment Gateways') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Online Gateways') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_paypal_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Paypal') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Paypal Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="paypal_status" value="1" class="selectgroup-input"
                        {{ $paypal->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="paypal_status" value="0" class="selectgroup-input"
                        {{ $paypal->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('paypal_status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('paypal_status') }}</p>
                  @endif
                </div>

                @php $paypalInfo = json_decode($paypal->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Paypal Test Mode') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="paypal_sandbox_status" value="1" class="selectgroup-input"
                        {{ $paypalInfo['sandbox_status'] == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="paypal_sandbox_status" value="0" class="selectgroup-input"
                        {{ $paypalInfo['sandbox_status'] == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('paypal_sandbox_status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('paypal_sandbox_status') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Paypal Client ID') }}</label>
                  <input type="text" class="form-control" name="paypal_client_id"
                    value="{{ $paypalInfo['client_id'] }}">
                  @if ($errors->has('paypal_client_id'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('paypal_client_id') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Paypal Client Secret') }}</label>
                  <input type="text" class="form-control" name="paypal_client_secret"
                    value="{{ $paypalInfo['client_secret'] }}">
                  @if ($errors->has('paypal_client_secret'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('paypal_client_secret') }}</p>
                  @endif
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>

    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_instamojo_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Instamojo') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Instamojo Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="instamojo_status" value="1" class="selectgroup-input"
                        {{ $instamojo->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="instamojo_status" value="0" class="selectgroup-input"
                        {{ $instamojo->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('instamojo_status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('instamojo_status') }}</p>
                  @endif
                </div>

                @php $instamojoInfo = json_decode($instamojo->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Instamojo Test Mode') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="instamojo_sandbox_status" value="1" class="selectgroup-input"
                        {{ $instamojoInfo['sandbox_status'] == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="instamojo_sandbox_status" value="0" class="selectgroup-input"
                        {{ $instamojoInfo['sandbox_status'] == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('instamojo_sandbox_status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('instamojo_sandbox_status') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Instamojo API Key') }}</label>
                  <input type="text" class="form-control" name="instamojo_key"
                    value="{{ $instamojoInfo['key'] }}">
                  @if ($errors->has('instamojo_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('instamojo_key') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Instamojo Auth Token') }}</label>
                  <input type="text" class="form-control" name="instamojo_token"
                    value="{{ $instamojoInfo['token'] }}">
                  @if ($errors->has('instamojo_token'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('instamojo_token') }}</p>
                  @endif
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>

    {{-- paytm --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_paytm_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Paytm') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Paytm Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="paytm_status" value="1" class="selectgroup-input"
                        {{ $paytm->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="paytm_status" value="0" class="selectgroup-input"
                        {{ $paytm->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('paytm_status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('paytm_status') }}</p>
                  @endif
                </div>

                @php $paytmInfo = json_decode($paytm->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Paytm Environment') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="paytm_environment" value="local" class="selectgroup-input"
                        {{ $paytmInfo['environment'] == 'local' ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Local') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="paytm_environment" value="production" class="selectgroup-input"
                        {{ $paytmInfo['environment'] == 'production' ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Production') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('paytm_environment'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('paytm_environment') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Paytm Merchant Key') }}</label>
                  <input type="text" class="form-control" name="paytm_merchant_key"
                    value="{{ $paytmInfo['merchant_key'] }}">
                  @if ($errors->has('paytm_merchant_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('paytm_merchant_key') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Paytm Merchant MID') }}</label>
                  <input type="text" class="form-control" name="paytm_merchant_mid"
                    value="{{ $paytmInfo['merchant_mid'] }}">
                  @if ($errors->has('paytm_merchant_mid'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('paytm_merchant_mid') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Paytm Merchant Website') }}</label>
                  <input type="text" class="form-control" name="paytm_merchant_website"
                    value="{{ $paytmInfo['merchant_website'] }}">
                  @if ($errors->has('paytm_merchant_website'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('paytm_merchant_website') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Industry Type') }}</label>
                  <input type="text" class="form-control" name="paytm_industry_type"
                    value="{{ $paytmInfo['industry_type'] }}">
                  @if ($errors->has('paytm_industry_type'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('paytm_industry_type') }}</p>
                  @endif
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>



    {{-- stripe --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_stripe_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Stripe') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Stripe Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="stripe_status" value="1" class="selectgroup-input"
                        {{ $stripe->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="stripe_status" value="0" class="selectgroup-input"
                        {{ $stripe->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('stripe_status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('stripe_status') }}</p>
                  @endif
                </div>

                @php $stripeInfo = json_decode($stripe->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Stripe Key') }}</label>
                  <input type="text" class="form-control" name="stripe_key" value="{{ $stripeInfo['key'] }}">
                  @if ($errors->has('stripe_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('stripe_key') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Stripe Secret') }}</label>
                  <input type="text" class="form-control" name="stripe_secret"
                    value="{{ $stripeInfo['secret'] }}">
                  @if ($errors->has('stripe_secret'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('stripe_secret') }}</p>
                  @endif
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    {{-- flutterwave --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_flutterwave_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Flutterwave') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Flutterwave Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="flutterwave_status" value="1" class="selectgroup-input"
                        {{ $flutterwave->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="flutterwave_status" value="0" class="selectgroup-input"
                        {{ $flutterwave->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('flutterwave_status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('flutterwave_status') }}</p>
                  @endif
                </div>

                @php $flutterwaveInfo = json_decode($flutterwave->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Flutterwave Public Key') }}</label>
                  <input type="text" class="form-control" name="flutterwave_public_key"
                    value="{{ $flutterwaveInfo['public_key'] }}">
                  @if ($errors->has('flutterwave_public_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('flutterwave_public_key') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Flutterwave Secret Key') }}</label>
                  <input type="text" class="form-control" name="flutterwave_secret_key"
                    value="{{ $flutterwaveInfo['secret_key'] }}">
                  @if ($errors->has('flutterwave_secret_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('flutterwave_secret_key') }}</p>
                  @endif
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>

    {{-- Razorpay --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_razorpay_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Razorpay') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Razorpay Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="razorpay_status" value="1" class="selectgroup-input"
                        {{ $razorpay->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="razorpay_status" value="0" class="selectgroup-input"
                        {{ $razorpay->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('razorpay_status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('razorpay_status') }}</p>
                  @endif
                </div>

                @php $razorpayInfo = json_decode($razorpay->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Razorpay Key') }}</label>
                  <input type="text" class="form-control" name="razorpay_key" value="{{ $razorpayInfo['key'] }}">
                  @if ($errors->has('razorpay_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('razorpay_key') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Razorpay Secret') }}</label>
                  <input type="text" class="form-control" name="razorpay_secret"
                    value="{{ $razorpayInfo['secret'] }}">
                  @if ($errors->has('razorpay_secret'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('razorpay_secret') }}</p>
                  @endif
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    {{-- mollie --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_mollie_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Mollie') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Mollie Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="mollie_status" value="1" class="selectgroup-input"
                        {{ $mollie->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="mollie_status" value="0" class="selectgroup-input"
                        {{ $mollie->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('mollie_status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('mollie_status') }}</p>
                  @endif
                </div>

                @php $mollieInfo = json_decode($mollie->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Mollie API Key') }}</label>
                  <input type="text" class="form-control" name="mollie_key" value="{{ $mollieInfo['key'] }}">
                  @if ($errors->has('mollie_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('mollie_key') }}</p>
                  @endif
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>

    {{-- paystack --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_paystack_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Paystack') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Paystack Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="paystack_status" value="1" class="selectgroup-input"
                        {{ $paystack->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="paystack_status" value="0" class="selectgroup-input"
                        {{ $paystack->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('paystack_status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('paystack_status') }}</p>
                  @endif
                </div>

                @php $paystackInfo = json_decode($paystack->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Paystack Secret Key') }}</label>
                  <input type="text" class="form-control" name="paystack_key" value="{{ $paystackInfo['key'] }}">
                  @if ($errors->has('paystack_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('paystack_key') }}</p>
                  @endif
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>

    {{-- mercadopago --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_mercadopago_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('MercadoPago') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="form-group">
              <label>{{ __('MercadoPago Status') }}</label>
              <div class="selectgroup w-100">
                <label class="selectgroup-item">
                  <input type="radio" name="mercadopago_status" value="1" class="selectgroup-input"
                    {{ $mercadopago->status == 1 ? 'checked' : '' }}>
                  <span class="selectgroup-button">{{ __('Active') }}</span>
                </label>
                <label class="selectgroup-item">
                  <input type="radio" name="mercadopago_status" value="0" class="selectgroup-input"
                    {{ $mercadopago->status == 0 ? 'checked' : '' }}>
                  <span class="selectgroup-button">{{ __('Deactive') }}</span>
                </label>
              </div>
              @if ($errors->has('mercadopago_status'))
                <p class="mt-1 mb-0 text-danger">{{ $errors->first('mercadopago_status') }}</p>
              @endif
            </div>

            @php $mercadopagoInfo = json_decode($mercadopago->information, true); @endphp

            <div class="form-group">
              <label>{{ __('MercadoPago Test Mode') }}</label>
              <div class="selectgroup w-100">
                <label class="selectgroup-item">
                  <input type="radio" name="mercadopago_sandbox_status" value="1" class="selectgroup-input"
                    {{ $mercadopagoInfo['sandbox_status'] == 1 ? 'checked' : '' }}>
                  <span class="selectgroup-button">{{ __('Active') }}</span>
                </label>
                <label class="selectgroup-item">
                  <input type="radio" name="mercadopago_sandbox_status" value="0" class="selectgroup-input"
                    {{ $mercadopagoInfo['sandbox_status'] == 0 ? 'checked' : '' }}>
                  <span class="selectgroup-button">{{ __('Deactive') }}</span>
                </label>
              </div>
              @if ($errors->has('mercadopago_sandbox_status'))
                <p class="mt-1 mb-0 text-danger">{{ $errors->first('mercadopago_sandbox_status') }}</p>
              @endif
            </div>

            <div class="form-group">
              <label>{{ __('MercadoPago Token') }}</label>
              <input type="text" class="form-control" name="mercadopago_token"
                value="{{ $mercadopagoInfo['token'] }}">
              @if ($errors->has('mercadopago_token'))
                <p class="mt-1 mb-0 text-danger">{{ $errors->first('mercadopago_token') }}</p>
              @endif
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>



    {{-- authorize.net --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form class="" action="{{ route('admin.settings.payment_gateways.update_anet_info') }}"
          method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Authorize.Net') }}</div>
              </div>
            </div>
          </div>


          <div class="card-body pt-5 pb-5">
            <div class="row">
              <div class="col-lg-12">
                @csrf
                @php
                  $anetInfo = json_decode($anet->information, true);
                @endphp
                <div class="form-group">
                  <label>{{ __('Authorize.Net') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="1" class="selectgroup-input"
                        {{ $anet->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="0" class="selectgroup-input"
                        {{ $anet->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label>{{ __('Authorize.Net Test Mode') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="sandbox_check" value="1" class="selectgroup-input"
                        {{ $anetInfo['sandbox_check'] == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="sandbox_check" value="0" class="selectgroup-input"
                        {{ $anetInfo['sandbox_check'] == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label>{{ __('API Login ID') }}</label>
                  <input class="form-control" name="login_id" value="{{ $anetInfo['login_id'] }}">
                  @if ($errors->has('login_id'))
                    <p class="mb-0 text-danger">{{ $errors->first('login_id') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Transaction Key') }}</label>
                  <input class="form-control" name="transaction_key" value="{{ $anetInfo['transaction_key'] }}">
                  @if ($errors->has('transaction_key'))
                    <p class="mb-0 text-danger">{{ $errors->first('transaction_key') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Public Client Key') }}</label>
                  <input class="form-control" name="public_key" value="{{ $anetInfo['public_key'] }}">
                  @if ($errors->has('public_key'))
                    <p class="mb-0 text-danger">{{ $errors->first('public_key') }}</p>
                  @endif
                </div>

              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="form">
              <div class="form-group from-show-notify row">
                <div class="col-12 text-center">
                  <button type="submit" class="btn btn-success">{{ __('Update') }}</button>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>

    {{-- Iyzico --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_iyzico_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Iyzico') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Iyzico Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="1" class="selectgroup-input"
                        {{ $iyzico->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="0" class="selectgroup-input"
                        {{ $iyzico->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('status') }}</p>
                  @endif
                </div>

                @php $iyzicoInfo = json_decode($iyzico?->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Iyzico Test Mode') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="iyzico_mode" value="1" class="selectgroup-input"
                        {{ !empty($iyzicoInfo) && $iyzicoInfo['iyzico_mode'] == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="iyzico_mode" value="0" class="selectgroup-input"
                        {{ !empty($iyzicoInfo) && $iyzicoInfo['iyzico_mode'] == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('iyzico_mode'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('iyzico_mode') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Iyzico Api Key') }}</label>
                  <input type="text" class="form-control" name="api_key"
                    value="{{ !empty($iyzicoInfo['api_key']) ? $iyzicoInfo['api_key'] : null }}">
                  @if ($errors->has('api_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('api_key') }}</p>
                  @endif
                </div>
                <div class="form-group">
                  <label>{{ __('Iyzico Secret Key') }}</label>
                  <input type="text" class="form-control" name="secrect_key"
                    value="{{ !empty($iyzicoInfo['secrect_key']) ? $iyzicoInfo['secrect_key'] : null }}">
                  @if ($errors->has('secrect_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('secrect_key') }}</p>
                  @endif
                </div>
                <p class="text-warning"><strong>{{ __('Cron Job Command') }} :</strong> {{ __('curl -sS') }}
                  {{ route('cron.expired') }}
                </p>
                <p class="text-danger">
                  {{ __('If you don\'t set up a cron job, the Iyzico payment method will not work.') }}</p>

              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    {{-- Midtrans --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_midtrans_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Midtrans') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Midtrans Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="1" class="selectgroup-input"
                        {{ $midtrans->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="0" class="selectgroup-input"
                        {{ $midtrans->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('status') }}</p>
                  @endif
                </div>

                @php $midtransInfo = json_decode($midtrans?->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Midtrans Test Mode') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="midtrans_mode" value="1" class="selectgroup-input"
                        {{ !empty($midtransInfo) && $midtransInfo['midtrans_mode'] == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="midtrans_mode" value="0" class="selectgroup-input"
                        {{ !empty($midtransInfo) && $midtransInfo['midtrans_mode'] == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('midtrans_mode'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('midtrans_mode') }}</p>
                  @endif
                </div>
                <div class="form-group">
                  <label>{{ __('Midtrans Server Key') }}</label>
                  <input type="text" class="form-control" name="server_key"
                    value="{{ !empty($midtransInfo['server_key']) ? $midtransInfo['server_key'] : null }}">
                  @if ($errors->has('server_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('server_key') }}</p>
                  @endif
                </div>
                <p class="text-warning">{{ __('Success URL') }} : {{ route('midtrans.bank.notify') }} </p>
                <p class="text-warning">{{ __('Cancel URL') }} : {{ route('midtrans.cancel') }}</p>
                <p class="text-warning">
                  <strong></strong>{{ __('Set url form here') }} : <a href="https://prnt.sc/OiucUCeYJIXo"
                    target="_blank">https://prnt.sc/OiucUCeYJIXo</a>
                </p>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>

    {{-- myfatoorah Information --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_myfatoorah_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('MyFatoorah') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('MyFatoorah Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="1" class="selectgroup-input"
                        {{ $myfatoorah->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="0" class="selectgroup-input"
                        {{ $myfatoorah->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('status') }}</p>
                  @endif
                </div>

                @php $myfatoorahInfo = json_decode($myfatoorah->information, true); @endphp
                <div class="form-group">
                  <label>{{ __('Sandbox Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="sandbox_status" value="1" class="selectgroup-input"
                        {{ @$myfatoorahInfo['sandbox_status'] == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="sandbox_status" value="0" class="selectgroup-input"
                        {{ @$myfatoorahInfo['sandbox_status'] == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('sandbox_status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('sandbox_status') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Token') }}</label>
                  <input type="text" class="form-control" name="token" value="{{ @$myfatoorahInfo['token'] }}">
                  @if ($errors->has('token'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('token') }}</p>
                  @endif
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    {{-- phonepe Information --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_phonepe_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Phonepe') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Phonepe Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="1" class="selectgroup-input"
                        {{ $phonepe->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="0" class="selectgroup-input"
                        {{ $phonepe->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('status') }}</p>
                  @endif
                </div>

                @php $phonepeInfo = json_decode($phonepe->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Sandbox Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="sandbox_status" value="1" class="selectgroup-input"
                        {{ $phonepeInfo['sandbox_status'] == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="sandbox_status" value="0" class="selectgroup-input"
                        {{ $phonepeInfo['sandbox_status'] == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('sandbox_status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('sandbox_status') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Merchant Id') }}</label>
                  <input type="text" class="form-control" name="merchant_id"
                    value="{{ @$phonepeInfo['merchant_id'] }}">
                  @if ($errors->has('merchant_id'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('merchant_id') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Salt Key') }}</label>
                  <input type="text" class="form-control" name="salt_key"
                    value="{{ @$phonepeInfo['salt_key'] }}">
                  @if ($errors->has('salt_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('salt_key') }}</p>
                  @endif
                </div>
                <div class="form-group">
                  <label>{{ __('Salt Index') }}</label>
                  <input type="number" class="form-control" name="salt_index"
                    value="{{ @$phonepeInfo['salt_index'] }}">
                  @if ($errors->has('salt_index'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('salt_index') }}</p>
                  @endif
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    {{-- yoco Information --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_yoco_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Yoco') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Yoco Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="1" class="selectgroup-input"
                        {{ $yoco->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="0" class="selectgroup-input"
                        {{ $yoco->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('status') }}</p>
                  @endif
                </div>

                @php $yocoInfo = json_decode($yoco->information, true); @endphp


                <div class="form-group">
                  <label>{{ __('Secret Key') }}</label>
                  <input type="text" class="form-control" name="secret_key"
                    value="{{ @$yocoInfo['secret_key'] }}">
                  @if ($errors->has('secret_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('secret_key') }}</p>
                  @endif
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    {{-- toyyibpay Information --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_toyyibpay_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Toyyibpay') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Toyyibpay Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="1" class="selectgroup-input"
                        {{ $toyyibpay->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="0" class="selectgroup-input"
                        {{ $toyyibpay->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('status') }}</p>
                  @endif
                </div>

                @php $toyyibpayInfo = json_decode($toyyibpay->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Toyyibpay Test Mode') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="sandbox_status" value="1" class="selectgroup-input"
                        {{ $toyyibpayInfo['sandbox_status'] == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="sandbox_status" value="0" class="selectgroup-input"
                        {{ $toyyibpayInfo['sandbox_status'] == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('sandbox_status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('sandbox_status') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Secret Key') }}</label>
                  <input type="text" class="form-control" name="secret_key"
                    value="{{ @$toyyibpayInfo['secret_key'] }}">
                  @if ($errors->has('secret_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('secret_key') }}</p>
                  @endif
                </div>
                <div class="form-group">
                  <label>{{ __('Category Code') }}</label>
                  <input type="text" class="form-control" name="category_code"
                    value="{{ @$toyyibpayInfo['category_code'] }}">
                  @if ($errors->has('category_code'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('category_code') }}</p>
                  @endif
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>

    {{-- paytabs Information --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_paytabs_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Paytabs') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Paytabs Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="1" class="selectgroup-input"
                        {{ $paytabs->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="0" class="selectgroup-input"
                        {{ $paytabs->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('status') }}</p>
                  @endif
                </div>

                @php $paytabsInfo = json_decode($paytabs->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Country') }}</label>
                  <select name="country" id="" class="form-control">
                    <option value="global" @selected($paytabsInfo['country'] == 'global')>{{ __('Global') }}</option>
                    <option value="sa" @selected($paytabsInfo['country'] == 'sa')>{{ __('Saudi Arabia') }}</option>
                    <option value="uae" @selected($paytabsInfo['country'] == 'uae')>{{ __('United Arab Emirates') }}</option>
                    <option value="egypt" @selected($paytabsInfo['country'] == 'egypt')>{{ __('Egypt') }}</option>
                    <option value="oman" @selected($paytabsInfo['country'] == 'oman')>{{ __('Oman') }}</option>
                    <option value="jordan" @selected($paytabsInfo['country'] == 'jordan')>{{ __('Jordan') }}</option>
                    <option value="iraq" @selected($paytabsInfo['country'] == 'iraq')>{{ __('Iraq') }}</option>
                  </select>
                  @if ($errors->has('country'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('server_key') }}</p>
                  @endif
                </div>

                <div class="form-group">
                  <label>{{ __('Server Key') }}</label>
                  <input type="text" class="form-control" name="server_key"
                    value="{{ @$paytabsInfo['server_key'] }}">
                  @if ($errors->has('server_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('server_key') }}</p>
                  @endif
                </div>
                <div class="form-group">
                  <label>{{ __('Profile Id') }}</label>
                  <input type="text" class="form-control" name="profile_id"
                    value="{{ @$paytabsInfo['profile_id'] }}">
                  @if ($errors->has('profile_id'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('profile_id') }}</p>
                  @endif
                </div>
                <div class="form-group">
                  <label>{{ __('API Endpoint') }}</label>
                  <input type="text" class="form-control" name="api_endpoint"
                    value="{{ @$paytabsInfo['api_endpoint'] }}">
                  @if ($errors->has('api_endpoint'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('api_endpoint') }}</p>
                  @endif
                  <p class="mt-1 mb-0 text-warning">{{ __("You will get 'API Endpoit' from here.") }} <a
                      href="https://prnt.sc/McaCbxt75fyi" target="_blank">https://prnt.sc/McaCbxt75fyi</a>, <a
                      href="https://prnt.sc/DgztAyHVR2o8" target="_blank">https://prnt.sc/DgztAyHVR2o8</a></p>
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>

    {{-- Perfect Money Information --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_perfect_money_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Perfect Money') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Perfect Money Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="1" class="selectgroup-input"
                        {{ $perfect_money->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="0" class="selectgroup-input"
                        {{ $perfect_money->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('status') }}</p>
                  @endif
                </div>

                @php $perfect_moneyInfo = json_decode($perfect_money->information, true); @endphp

                <div class="form-group">
                  <label>{{ __('Perfect Money Wallet Id') }}</label>
                  <input type="text" class="form-control" name="perfect_money_wallet_id"
                    value="{{ @$perfect_moneyInfo['perfect_money_wallet_id'] }}">
                  @if ($errors->has('perfect_money_wallet_id'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('perfect_money_wallet_id') }}</p>
                  @endif

                  <p class="text-warning mt-1">{{ __('You will get wallet id form here') }} <a
                      href="https://prnt.sc/bM3LqLXBduaq" target="_blank">https://prnt.sc/bM3LqLXBduaq</a></p>
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    {{-- xendit Information --}}
    <div class="col-xl-4 col-lg-6 col-md-6">
      <div class="card">
        <form action="{{ route('admin.settings.payment_gateways.update_xendit_info') }}" method="post">
          @csrf
          <div class="card-header">
            <div class="row">
              <div class="col-lg-12">
                <div class="card-title">{{ __('Xendit') }}</div>
              </div>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="form-group">
                  <label>{{ __('Xendit Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="1" class="selectgroup-input"
                        {{ $xendit->status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Active') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="status" value="0" class="selectgroup-input"
                        {{ $xendit->status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Deactive') }}</span>
                    </label>
                  </div>
                  @if ($errors->has('status'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('status') }}</p>
                  @endif
                </div>

                @php $xenditInfo = json_decode($xendit->information, true); @endphp


                <div class="form-group">
                  <label>{{ __('Secret Key') }}</label>
                  <input type="text" class="form-control" name="secret_key"
                    value="{{ @$xenditInfo['secret_key'] }}">
                  @if ($errors->has('secret_key'))
                    <p class="mt-1 mb-0 text-danger">{{ $errors->first('secret_key') }}</p>
                  @endif
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
@endsection
