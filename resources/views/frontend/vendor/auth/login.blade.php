@extends('frontend.layout')

@section('pageHeading')
  {{ !empty($pageHeading) ? $pageHeading->vendor_login_page_title : __('Login') }}
@endsection
@section('metaKeywords')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_keyword_login }}
  @endif
@endsection

@section('metaDescription')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_description_login }}
  @endif
@endsection

@section('content')
  @includeIf('frontend.partials.breadcrumb', [
      'breadcrumb' => $bgImg->breadcrumb,
      'title' => !empty($pageHeading) ? $pageHeading->login_page_title : __('Login'),
  ])

  <!-- Authentication Start -->
  <div class="authentication-area bg-light ptb-100">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <div class="main-form">
            <div class="main-form-wrapper">
              <h3 class="title mb-30 text-center">{{ __('Welcome back') . '!' }}</h3>

              @if (Session::has('success'))
                <div class="alert alert-success">{{ __(Session::get('success')) }}</div>
              @endif
              @if (Session::has('error'))
                <div class="alert alert-danger">{{ __(Session::get('error')) }}</div>
              @endif
              <form action="{{ route('vendor.login_submit') }}" method="POST">
                @csrf
                <div class="form-group mb-20">
                  <label for="userName" class="form-label font-sm">{{ __('Username or Email') }}<span
                      class="color-red">*</span></label>
                  <input type="text" class="form-control" value="{{ old('username') }}" name="username"
                    placeholder="{{ __('Username or Email') }}" required>
                  @error('username')
                    <p class="text-danger mt-2">{{ $message }}</p>
                  @enderror
                </div>
                <div class="form-group mb-20">
                  <label for="password" class="form-label font-sm">{{ __('Password') }}<span
                      class="color-red">*</span></label>
                  <div class="position-relative">
                    <input type="password" class="form-control" value="{{ old('password') }}" name="password"
                      placeholder="{{ __('Password') }}" required>
                    <span class="show-password-field">
                      <i class="show-icon"></i>
                    </span>
                    @error('password')
                      <p class="text-danger mt-2">{{ $message }}</p>
                    @enderror
                  </div>
                </div>
                @if ($bs->google_recaptcha_status == 1)
                  <div class="form-group mb-30">
                    {!! NoCaptcha::renderJs() !!}
                    {!! NoCaptcha::display() !!}

                    @error('g-recaptcha-response')
                      <p class="mt-1 text-danger">{{ $message }}</p>
                    @enderror
                  </div>
                @endif
                <div class="text-center pt-10">
                  <button class="btn btn-lg btn-primary w-100 radius-sm" type="submit"
                    aria-label="Login">{{ __('Login') }}</button>
                </div>
              </form>
            </div>
            <div class="d-flex justify-content-between flex-wrap gap-2 mt-20">
              <div class="link font-sm">
                <a href="{{ route('vendor.forget.password') }}"
                  title="Forgot Password">{{ __('Forgot password') . '?' }}</a>
              </div>
              <div class="link font-sm">
                {{ __('don\'t have an account') . '?' }} <a href="{{ route('vendor.signup') }}" title="Go Signup"
                  target="_self">{{ __('Click Here') }}</a> {{ __('to Signup') }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Authentication End -->
@endsection
