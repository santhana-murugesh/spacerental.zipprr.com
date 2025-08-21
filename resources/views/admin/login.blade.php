<!DOCTYPE html>
<html>

<head>
  {{-- required meta tags --}}
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  {{-- title --}}
  <title>{{ __('Admin Login') . ' | ' . $websiteInfo->website_title }}</title>

  {{-- fav icon --}}
  <link rel="shortcut icon" type="image/png" href="{{ asset('assets/img/' . $websiteInfo->favicon) }}">

  {{-- bootstrap css --}}
  <link rel="stylesheet" href="{{ asset('assets/admin/css/bootstrap.min.css') }}">

  {{-- login css --}}
  <link rel="stylesheet" href="{{ asset('assets/admin/css/admin-login.css') }}">
</head>

<body>
  {{-- login form start --}}
  <div class="login-page">
    @if (!empty($websiteInfo->logo))
      <div class="text-center mb-4">
        <img class="login-logo" src="{{ asset('assets/img/' . $websiteInfo->logo) }}" alt="logo">
      </div>
    @endif

    <div class="form">
      @if (session()->has('alert'))
        <div class="alert alert-danger fade show" role="alert">
          <strong>{{ session('alert') }}</strong>
        </div>
      @endif

      <form class="login-form" action="{{ route('admin.auth') }}" method="POST">
        @csrf
        <input type="text" name="username" placeholder="{{ __('Enter Username') }}" />
        @if ($errors->has('username'))
          <p class="text-danger text-left">{{ $errors->first('username') }}</p>
        @endif

        <input type="password" name="password" placeholder="{{ __('Enter Password') }}" />
        @if ($errors->has('password'))
          <p class="text-danger text-left">{{ $errors->first('password') }}</p>
        @endif

        <button type="submit" class="w-100">{{ __('login') }}</button>
      </form>

      <a class="forget-link" href="{{ route('admin.forget_password') }}">
        {{ __('Forget Password or Username?') }}
      </a>
    </div>
  </div>
  {{-- login form end --}}


  {{-- jQuery --}}
  <script src="{{ asset('assets/admin/js/jquery-3.4.1.min.js') }}"></script>

  {{-- popper js --}}
  <script src="{{ asset('assets/admin/js/popper.min.js') }}"></script>

  {{-- bootstrap js --}}
  <script src="{{ asset('assets/admin/js/bootstrap.min.js') }}"></script>

  {{-- CSRF Token Refresh Script --}}
  <script>
    $(document).ready(function() {
      // Refresh CSRF token before form submission
      $('.login-form').on('submit', function(e) {
        // Get fresh CSRF token
        $.get('{{ route("admin.csrf_token") }}')
          .done(function(data) {
            // Update the hidden input with fresh token
            $('input[name="_token"]').val(data.token);
          })
          .fail(function() {
            // If token refresh fails, show error
            alert('Session expired. Please refresh the page and try again.');
            e.preventDefault();
          });
      });

      // Also refresh token every 5 minutes to keep it alive
      setInterval(function() {
        $.get('{{ route("admin.csrf_token") }}')
          .done(function(data) {
            $('input[name="_token"]').val(data.token);
          });
      }, 300000); // 5 minutes
    });
  </script>
</body>

</html>
