@extends('frontend.layout')
@section('pageHeading')
  {{ __('Home') }}
@endsection
@section('metaKeywords')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_keyword_home }}
  @endif
@endsection

@section('metaDescription')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_description_home }}
  @endif
@endsection
@section('content')


  <!-- Sticky Navigation (Hidden Initially) -->
  <div class="sticky-header-nav" id="stickyNavbar">
    <div class="container">
      <nav class="navbar navbar-expand-lg">
        <a class="navbar-brand" href="{{ route('index') }}">
          @if (!empty($websiteInfo->logo))
            <img src="{{ asset('assets/img/' . $websiteInfo->logo) }}" alt="logo" onerror="this.style.display='none'; this.nextElementSibling.style.display='inline';">
          @endif
          <span class="brand-text" style="{{ !empty($websiteInfo->logo) ? 'display: none;' : 'display: inline;' }}">{{ $websiteInfo->website_title ?? 'Space Rental' }}</span>
        </a>

        <!-- Mobile Toggle Button -->
        <button class="navbar-toggler mobile-toggle" type="button" data-bs-toggle="collapse" data-bs-target="#stickyNavbarCollapse" aria-controls="stickyNavbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Collapsible Content -->
        <div class="collapse navbar-collapse" id="stickyNavbarCollapse">
          <!-- Right side actions -->
          <div class="header-actions ms-auto">
            <div class="language-selector">
              <form action="{{ route('change_language') }}" method="GET">
                <select class="form-select" name="lang_code" onchange="this.form.submit()">
                  @foreach ($allLanguageInfos as $languageInfo)
                    <option value="{{ $languageInfo->code }}"
                      {{ $languageInfo->code == $currentLanguageInfo->code ? 'selected' : '' }}>
                      {{ $languageInfo->name }}
                    </option>
                  @endforeach
                </select>
              </form>
            </div>

            <!-- User actions -->
            <div class="user-actions">
              @if (!Auth::guard('web')->check())
                <a href="{{ route('user.login') }}" class="btn btn-outline-light btn-sm">{{ __('Login') }}</a>
                <a href="{{ route('user.signup') }}" class="btn btn-light btn-sm">{{ __('Sign Up') }}</a>
              @else
                <div class="dropdown">
                  <button class="btn btn-outline-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-user-circle me-1"></i>
                    {{ Auth::guard('web')->user()->username }}
                  </button>
                  <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="{{ route('user.dashboard') }}">{{ __('Dashboard') }}</a></li>
                    <li><a class="dropdown-item" href="{{ route('user.logout') }}">{{ __('Logout') }}</a></li>
                  </ul>
                </div>
              @endif
            </div>

            <!-- Vendor actions -->
            <div class="vendor-actions">
              @if (!Auth::guard('vendor')->check())
                <a href="{{ route('vendor.login') }}" class="btn btn-outline-light btn-sm">{{ __('Vendor Login') }}</a>
              @else
                <div class="dropdown">
                  <button class="btn btn-outline-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-hotel me-1"></i>
                    {{ __('Vendor') }}
                  </button>
                  <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="{{ route('vendor.dashboard') }}">{{ __('Dashboard') }}</a></li>
                    <li><a class="dropdown-item" href="{{ route('vendor.logout') }}">{{ __('Logout') }}</a></li>
                  </ul>
                </div>
              @endif
            </div>
          </div>
        </div>
      </nav>
    </div>
  </div>

  <!-- Hero section start-->
  <section class="hero-banner hero-banner_v1 header-next hero-section">
    <!-- Hero Navigation (Inside Hero Section) -->
    <div class="hero-navbar" id="heroNavbar">
      <div class="container">
        <nav class="navbar navbar-expand-lg">
          <a class="navbar-brand" href="{{ route('index') }}">
            @if (!empty($websiteInfo->logo))
              <img src="{{ asset('assets/img/' . $websiteInfo->logo) }}" alt="logo" onerror="this.style.display='none'; this.nextElementSibling.style.display='inline';">
            @endif
            <span class="brand-text" style="{{ !empty($websiteInfo->logo) ? 'display: none;' : 'display: inline;' }}">{{ $websiteInfo->website_title ?? 'Space Rental' }}</span>
          </a>

          <!-- Mobile Toggle Button -->
          <button class="navbar-toggler mobile-toggle" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <!-- Collapsible Content -->
          <div class="collapse navbar-collapse" id="navbarCollapse">
            <!-- Right side actions -->
            <div class="header-actions ms-auto">
              <div class="language-selector">
                <form action="{{ route('change_language') }}" method="GET">
                  <select class="form-select" name="lang_code" onchange="this.form.submit()">
                    @foreach ($allLanguageInfos as $languageInfo)
                      <option value="{{ $languageInfo->code }}"
                        {{ $languageInfo->code == $currentLanguageInfo->code ? 'selected' : '' }}>
                        {{ $languageInfo->name }}
                      </option>
                    @endforeach
                  </select>
                </form>
              </div>

              <!-- User actions -->
              <div class="user-actions">
                @if (!Auth::guard('web')->check())
                  <a href="{{ route('user.login') }}" class="btn btn-outline-light btn-sm">{{ __('Login') }}</a>
                  <a href="{{ route('user.signup') }}" class="btn btn-light btn-sm">{{ __('Sign Up') }}</a>
                @else
                  <div class="dropdown">
                    <button class="btn btn-outline-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                      <i class="fas fa-user-circle me-1"></i>
                      {{ Auth::guard('web')->user()->username }}
                    </button>
                    <ul class="dropdown-menu">
                      <li><a class="dropdown-item" href="{{ route('user.dashboard') }}">{{ __('Dashboard') }}</a></li>
                      <li><a class="dropdown-item" href="{{ route('user.logout') }}">{{ __('Logout') }}</a></li>
                    </ul>
                  </div>
                @endif
              </div>

              <!-- Vendor actions -->
              <div class="vendor-actions">
                @if (!Auth::guard('vendor')->check())
                  <a href="{{ route('vendor.login') }}" class="btn btn-outline-light btn-sm">{{ __('Vendor Login') }}</a>
                @else
                  <div class="dropdown">
                    <button class="btn btn-outline-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                      <i class="fas fa-hotel me-1"></i>
                      {{ __('Vendor') }}
                    </button>
                    <ul class="dropdown-menu">
                      <li><a class="dropdown-item" href="{{ route('vendor.dashboard') }}">{{ __('Dashboard') }}</a></li>
                      <li><a class="dropdown-item" href="{{ route('vendor.logout') }}">{{ __('Logout') }}</a></li>
                    </ul>
                  </div>
                @endif
              </div>
            </div>
          </div>
        </nav>
      </div>
    </div>

    <div class="hero-background">
      <img class="lazyload hero-bg-image" data-src="{{ asset('assets/img/homepage/' . $images->hero_section_image) }}" alt="Hero Background">
      <div class="hero-overlay"></div>
    </div>
    
    <div class="container-fluid px-lg-0">
      <div class="row align-items-center justify-content-center">
        <div class="col-lg-10">
          <div class="hero-content text-center">
            <!-- Search Bar -->
            <div class="hero-search-container mb-40">
              <div class="search-form-wrapper">
                <form action="{{ route('frontend.search_room') }}" id="searchForm2" method="GET" class="hero-search-form">
                  <div class="search-grid">
                    <div class="search-item">
                      <div class="form-group">
                        <label for="title">{{ __('What are you planning?') }}</label>
                        <div class="form-block">
                          <div class="icon">
                            <i class="fas fa-lightbulb"></i>
                          </div>
                          <input type="text" name="title" class="form-control" 
                            placeholder="{{ __('Enter your activity') }}" id="search-activity">
                        </div>
                      </div>
                    </div>
                    <div class="search-item">
                      <div class="form-group">
                        <label for="location_val">{{ __('Where?') }}</label>
                        <div class="form-block">
                          <div class="icon">
                            <i class="fas fa-map-marker-alt"></i>
                          </div>
                          <input type="text" name="location_val" class="form-control"
                            placeholder="{{ __('Enter a city or address') }}" id="search-address">
                          @if ($basicInfo->google_map_api_key_status == 1)
                            <button type="button" class="btn btn-primary current-location-btn mt-2 btn-sm float-right"
                              onclick="getCurrentLocationHome()">
                              <i class="fas fa-location"></i>
                            </button>
                          @endif
                        </div>
                      </div>
                    </div>
                    <div class="search-item">
                      <div class="form-group">
                        <label for="checkInDates">{{ __('When?') }}</label>
                        <div class="form-block">
                          <div class="icon">
                            <i class="far fa-calendar-alt"></i>
                          </div>
                          <input type="text" class="form-control" id="checkInDate" name="checkInDates"
                            placeholder="{{ __('Anytime') }}" readonly />
                        </div>
                      </div>
                    </div>
                    <div class="search-item">
                      <button class="btn btn-primary search-btn" id="searchBtn2" type="button" aria-label="button">
                        <i class="far fa-search"></i>
                        <span>{{ __('Search') }}</span>
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </div>
            
            <!-- Hero Text -->
            <div class="hero-text">
              <h1 class="hero-title">
                {{ !empty($sectionContent->hero_section_title) ? $sectionContent->hero_section_title : __('Find a space.') }}
              </h1>
              <h2 class="hero-subtitle">
                {{ !empty($sectionContent->hero_section_subtitle) ? $sectionContent->hero_section_subtitle : __('Fulfill your vision.') }}
              </h2>
            </div>
            

          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- Hero section end -->

  @if (count($after_hero) > 0)
    @foreach ($after_hero as $cusHero)
      @if (isset($homecusSec[$cusHero->id]))
        @if ($homecusSec[$cusHero->id] == 1)
          @php
            $cusHeroContent = App\Models\HomePage\CustomSectionContent::where('custom_section_id', $cusHero->id)
                ->where('language_id', $currentLanguageInfo->id)
                ->first();
          @endphp
          @include('frontend.home.custom-section', ['data' => $cusHeroContent])
        @endif
      @endif
    @endforeach
  @endif

  <!-- About-area start -->
  @if ($secInfo->featured_section_status == 1)
    <section class="about-area about-area_v1 pb-60">
      <div class="container-fluid  px-lg-0">
        <div class="row align-items-center gx-xl-5" data-aos="fade-up">
          <div class="col-lg-6">
            <div class="image mb-40">
              <img class="lazyload blur-up"
                data-src="{{ asset('assets/img/homepage/' . $images->feature_section_image) }}" alt="Image">
            </div>
          </div>
          <div class="col-lg-6">
            <div class="content-title fluid-right pb-20
            ">
              <h2 class="title fw-normal mb-20">
                {{ $sectionContent ? $sectionContent->featured_section_title : __('Your Ultimate Hourly Hotel Booking Solution') }}
              </h2>
              <p class="title-p">
                {{ $sectionContent ? $sectionContent->featured_section_text : '' }}
              </p>
              <div class="info-list mt-30">
                @foreach ($features as $feature)
                  <div class="card mb-20">
                    <div class="card_icon">
                      <img class="lazyload" data-src="{{ asset('assets/img/feature/' . $feature->image) }}"
                        alt="Image">
                    </div>
                    <div class="card_content">
                      <span class="h3 lh-1 mb-1 fw-normal card_content_title">{{ $feature->title }}</span>
                      <p class="card_text">{{ $feature->subtitle }}</p>
                    </div>
                  </div>
                @endforeach
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  @endif
  <!-- About-area end -->

  @if (count($after_featured) > 0)
    @foreach ($after_featured as $cusFeature)
      @if (isset($homecusSec[$cusFeature->id]))
        @if ($homecusSec[$cusFeature->id] == 1)
          @php
            $cusFeatureContent = App\Models\HomePage\CustomSectionContent::where('custom_section_id', $cusFeature->id)
                ->where('language_id', $currentLanguageInfo->id)
                ->first();
          @endphp
          @include('frontend.home.custom-section', ['data' => $cusFeatureContent])
        @endif
      @endif
    @endforeach
  @endif

  <section class="IntroSection_intro_section py-5 start-0">
    <div class="container">
      <div class="row align-items-center" style="padding: 30px">
        <div class="col-lg-6">
          <div class="content-left">
            <h1 class="main-headline">
              A space for every moment
            </h1>
            <p class="sub-headline">
              Book a unique space for your activity
            </p>
            
            <div class="activity-categories">
              <div class="category-grid">
                @foreach ($intros as $intro)
                <span data-intro-id="{{$intro->id}}" class="category-link">{{$intro->title}}</span>
                @endforeach
              </div>
            </div>
            
            <div class="cta-section">
              <a href="{{route('frontend.search_room')}}" class="browse-button">
                Browse all activities
              </a>
            </div>
          </div>
        </div>
        
        <div class="col-lg-6">
          <div class="content-right">
            <div class="hero-image">
               @foreach ($intros as $intro)
              <img src="{{ asset('assets/img/intro-section/' . $intro->image) }}" data-intro-id="{{$intro->id}}" alt="Event Space" class="intro-image img-fluid">
                @endforeach
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- hotel-area start -->
  @if ($secInfo->featured_room_section_status == 1)
    <section class="product-area featured-product pb-75">
      <div class="container">
        <div class="row">
          <div class="col-12" data-aos="fade-up">
            <div class="section-title title-center mb-50">
              <h2 class="title fw-normal mt-0">
                {{ !empty($sectionContent->featured_room_section_title) ? $sectionContent->featured_room_section_title : __('All Hotels') }}
              </h2>
            </div>
          </div>
          <div class="col-12" data-aos="fade-up">
            <!-- Desktop Grid Layout -->
            <div class="row hotel-grid">
              @if (count($hotel_contents) < 1)
                <div class="p-3 text-center bg-light radius-md">
                  <h6 class="mb-0">{{ __('NO HOTELS FOUND') }}</h6>
                </div>
              @else
                @foreach ($hotel_contents as $hotel)
                  <div class="col-xl-4 col-md-6">
                    <div class="space-card">
                      <div class="card-image-container">
                        <a href="{{ route('frontend.hotel.details', ['slug' => $hotel->slug, 'id' => $hotel->id]) }}"
                          target="_self" title="{{ __('Link') }}">
                          <img class="card-image lazyload"
                            data-src="{{ asset('assets/img/hotel/logo/' . $hotel->logo) }}" alt="Hotel">
                        </a>
                        @if (Auth::guard('web')->check())
                          @php
                            $user_id = Auth::guard('web')->user()->id;
                            $checkWishList = checkHotelWishList($hotel->id, $user_id);
                          @endphp
                        @else
                          @php
                            $checkWishList = false;
                          @endphp
                        @endif

                        <button class="heart-button {{ $checkWishList == false ? '' : 'active' }}" 
                          onclick="window.location.href='{{ $checkWishList == false ? route('addto.wishlist.hotel', $hotel->id) : route('remove.wishlist.hotel', $hotel->id) }}'">
                          <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                            <path d="M16.5 3C19.5376 3 22 5.5 22 8.5C22 16 12 21 12 21C12 21 2 16 2 8.5C2 5.5 4.5 3 7.5 3C9.35997 3 11 3.8 12 5.1C13 3.8 14.64 3 16.5 3Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                          </svg>
                        </button>
                      </div>
                      
                      <div class="card-content">
                        <div class="card-header">
                          <div class="rating-badge">
                            <div class="stars">
                              @for ($i = 1; $i <= 5; $i++)
                                @if ($i <= $hotel->average_rating)
                                  <i class="fas fa-star filled"></i>
                                @elseif ($i - $hotel->average_rating < 1)
                                  <i class="fas fa-star-half-alt filled"></i>
                                @else
                                  <i class="far fa-star"></i>
                                @endif
                              @endfor
                            </div>
                            <span class="rating-number">({{ totalHotelReview($hotel->id) }})</span>
                          </div>
                          <div class="guest-capacity">
                            <span class="badge bg-light text-dark">{{ totalHotelRoom($hotel->id) }} {{ __('Rooms') }}</span>
                          </div>
                        </div>
                        
                        <h3 class="card-title">
                          <a href="{{ route('frontend.hotel.details', ['slug' => $hotel->slug, 'id' => $hotel->id]) }}"
                            target="_self" title="{{ __('Link') }}">
                            {{ $hotel->title }}
                          </a>
                        </h3>
                        
                        <div class="card-location">
                          @php
                            $city = null;
                            $State = null;
                            $country = null;

                            if ($hotel->city_id) {
                                $city = App\Models\Location\City::Where('id', $hotel->city_id)->first()->name;
                            }
                            if ($hotel->state_id) {
                                $State = App\Models\Location\State::Where('id', $hotel->state_id)->first()->name;
                            }
                            if ($hotel->country_id) {
                                $country = App\Models\Location\Country::Where('id', $hotel->country_id)->first()->name;
                            }
                          @endphp
                          <span>{{ @$city }}@if (@$State), {{ $State }}@endif @if (@$country), {{ $country }}@endif</span>
                        </div>
                        
                        <div class="card-features">
                          @php
                            $amenities = json_decode($hotel->amenities);
                            $totalAmenities = count($amenities);
                            $displayCount = 3;
                          @endphp
                          @foreach ($amenities as $index => $amenitie)
                            @php
                              if ($index >= $displayCount) {
                                  break;
                              }
                              $amin = App\Models\Amenitie::find($amenitie);
                            @endphp
                            <span class="badge bg-light text-dark">
                              <i class="{{ $amin->icon }}"></i> {{ $amin->title }}
                            </span>
                          @endforeach
                          @if ($totalAmenities > $displayCount)
                            <span class="feature-more">+{{ $totalAmenities - $displayCount }} more</span>
                          @endif
                        </div>
                      </div>
                    </div>
                  </div>
                @endforeach
              @endif
            </div>

            <!-- Mobile Slider Layout -->
            <div class="mobile-hotel-slider" style="display: none;">
              @if (count($hotel_contents) < 1)
                <div class="p-3 text-center bg-light radius-md">
                  <h6 class="mb-0">{{ __('NO HOTELS FOUND') }}</h6>
                </div>
              @else
                <div class="swiper hotel-swiper" id="hotel-swiper">
                  <div class="swiper-wrapper">
                    @foreach ($hotel_contents as $hotel)
                      <div class="swiper-slide">
                        <div class="space-card">
                          <div class="card-image-container">
                            <a href="{{ route('frontend.hotel.details', ['slug' => $hotel->slug, 'id' => $hotel->id]) }}"
                              target="_self" title="{{ __('Link') }}">
                              <img class="card-image lazyload"
                                data-src="{{ asset('assets/img/hotel/logo/' . $hotel->logo) }}" alt="Hotel">
                            </a>
                            @if (Auth::guard('web')->check())
                              @php
                                $user_id = Auth::guard('web')->user()->id;
                                $checkWishList = checkHotelWishList($hotel->id, $user_id);
                              @endphp
                            @else
                              @php
                                $checkWishList = false;
                              @endphp
                            @endif

                            <button class="heart-button {{ $checkWishList == false ? '' : 'active' }}" 
                              onclick="window.location.href='{{ $checkWishList == false ? route('addto.wishlist.hotel', $hotel->id) : route('remove.wishlist.hotel', $hotel->id) }}'">
                              <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <path d="M16.5 3C19.5376 3 22 5.5 22 8.5C22 16 12 21 12 21C12 21 2 16 2 8.5C2 5.5 4.5 3 7.5 3C9.35997 3 11 3.8 12 5.1C13 3.8 14.64 3 16.5 3Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                              </svg>
                            </button>
                          </div>
                          
                          <div class="card-content">
                            <div class="card-header">
                              <div class="rating-badge">
                                <div class="stars">
                                  @for ($i = 1; $i <= 5; $i++)
                                    @if ($i <= $hotel->average_rating)
                                      <i class="fas fa-star filled"></i>
                                    @elseif ($i - $hotel->average_rating < 1)
                                      <i class="fas fa-star-half-alt filled"></i>
                                    @else
                                      <i class="far fa-star"></i>
                                    @endif
                                  @endfor
                                </div>
                                <span class="rating-number">({{ totalHotelReview($hotel->id) }})</span>
                              </div>
                              <div class="guest-capacity">
                                <span class="badge bg-light text-dark">{{ totalHotelRoom($hotel->id) }} {{ __('Rooms') }}</span>
                              </div>
                            </div>
                            
                            <h3 class="card-title">
                              <a href="{{ route('frontend.hotel.details', ['slug' => $hotel->slug, 'id' => $hotel->id]) }}"
                                target="_self" title="{{ __('Link') }}">
                                {{ $hotel->title }}
                              </a>
                            </h3>
                            
                            <div class="card-location">
                              @php
                                $city = null;
                                $State = null;
                                $country = null;

                                if ($hotel->city_id) {
                                    $city = App\Models\Location\City::Where('id', $hotel->city_id)->first()->name;
                                }
                                if ($hotel->state_id) {
                                    $State = App\Models\Location\State::Where('id', $hotel->state_id)->first()->name;
                                }
                                if ($hotel->country_id) {
                                    $country = App\Models\Location\Country::Where('id', $hotel->country_id)->first()->name;
                                }
                              @endphp
                              <span>{{ @$city }}@if (@$State), {{ $State }}@endif @if (@$country), {{ $country }}@endif</span>
                            </div>
                            
                            <div class="card-features">
                              @php
                                $amenities = json_decode($hotel->amenities);
                                $totalAmenities = count($amenities);
                                $displayCount = 3;
                              @endphp
                              @foreach ($amenities as $index => $amenitie)
                                @php
                                  if ($index >= $displayCount) {
                                      break;
                                  }
                                  $amin = App\Models\Amenitie::find($amenitie);
                                @endphp
                                <span class="badge bg-light text-dark">
                                  <i class="{{ $amin->icon }}"></i> {{ $amin->title }}
                                </span>
                              @endforeach
                              @if ($totalAmenities > $displayCount)
                                <span class="feature-more">+{{ $totalAmenities - $displayCount }} more</span>
                              @endif
                            </div>
                          </div>
                        </div>
                      </div>
                    @endforeach
                  </div>
                  <!-- Swiper Pagination -->
                  <div class="swiper-pagination hotel-pagination"></div>
                </div>
              @endif
            </div>
          </div>
        </div>
      </div>
    </section>
  @endif
  <!-- hotel-area end -->
  @if (count($after_featured_room) > 0)
    @foreach ($after_featured_room as $cusFeatureRoom)
      @if (isset($homecusSec[$cusFeatureRoom->id]))
        @if ($homecusSec[$cusFeatureRoom->id] == 1)
          @php
            $cusFeatureRoomContent = App\Models\HomePage\CustomSectionContent::where(
                'custom_section_id',
                $cusFeatureRoom->id,
            )
                ->where('language_id', $currentLanguageInfo->id)
                ->first();
          @endphp
          @include('frontend.home.custom-section', ['data' => $cusFeatureRoomContent])
        @endif
      @endif
    @endforeach
  @endif

  <!-- Counter-area start -->
  @if ($secInfo->counter_section_status == 1)
    <div class="counter-area counter-area_v1 py-4 bg-img bg-cover z-1" style="margin-top: auto ; margin-bottom: 39px;"
      data-bg-img="{{ asset('assets/img/homepage/' . $images->counter_section_image) }}">
      <div class="overlay opacity-60"></div>
      <div class="container">
        <div class="row">
          <div class="col-lg-6">
            <div class="row" data-aos="fade-up">
              @foreach ($counters as $counter)
                <div class="col-sm-6 item">
                  <div class="card radius-md border text-center p-30">
                    <div class="card_icon mb-20">
                      <img class="lazyload" data-src="{{ asset('assets/img/counter/' . $counter->image) }}"
                        alt="Image">
                    </div>
                    <div class="card_content">
                      <h2 class="card_title mb-15">
                        <span class="counter">{{ $counter->amount }}</span>+
                      </h2>
                      <p class="card_text font-lg lh-1">
                        {{ $counter->title }}
                      </p>
                    </div>
                  </div>
                </div>
              @endforeach
            </div>
          </div>
          <div class="col-lg-6">
            <div class="video-btn-parent z-2 h-100">
              @if (@$sectionContent->counter_section_video_link)
                <a href="{{ $sectionContent->counter_section_video_link }}"
                  class="video-btn video-btn-white youtube-popup" title="{{ __('Play Video') }}">
                  <i class="fas fa-play"></i>
                </a>
              @endif

            </div>
          </div>
        </div>
      </div>
    </div>
  @endif
  <!-- Counter-area end -->

  @if (count($after_counter) > 0)
    @foreach ($after_counter as $cusCounter)
      @if (isset($homecusSec[$cusCounter->id]))
        @if ($homecusSec[$cusCounter->id] == 1)
          @php
            $cusCounterContent = App\Models\HomePage\CustomSectionContent::where('custom_section_id', $cusCounter->id)
                ->where('language_id', $currentLanguageInfo->id)
                ->first();
          @endphp
          @include('frontend.home.custom-section', ['data' => $cusCounterContent])
        @endif
      @endif
    @endforeach
  @endif

  <!-- Testimonial-area start -->
  @if ($secInfo->testimonial_section_status == 1)
    <section class="testimonial-area testimonial-area_v1 ptb-100" data-aos="fade-up">
      <div class="container">
        <div class="wrapper">
          <div class="row">
            <div class="col-lg-12">
              <div class="section-title title-center mb-50">
                <h2 class="title fw-normal">
                  {{ !empty($sectionContent->testimonial_section_title) ? $sectionContent->testimonial_section_title : '' }}
                </h2>
              </div>
            </div>
            <div class="col-lg-12">
              <div class="row justify-content-center">
                <div class="col-lg-6">
                  <div class="swiper" id="testimonial-slider-1">
                    <div class="swiper-wrapper">
                      @foreach ($testimonials as $testimonial)
                        <div class="swiper-slide">
                          <div class="slider-item text-center">
                            <div class="client-img mb-25 mx-auto">
                              <div class="lazy-container ratio ratio-1-1">
                                <img class="lazyload"
                                  data-src="{{ asset('assets/img/clients/' . $testimonial->image) }}"
                                  alt="Person Image">
                              </div>
                            </div>
                            <div class="quote mb-20">
                              <p class="text">
                                {{ $testimonial->comment }}
                              </p>
                            </div>
                            <div class="client-info">
                              <h6 class="name">{{ $testimonial->name }}</h6>
                              <span class="designation">{{ $testimonial->occupation }}</span>
                            </div>
                          </div>
                        </div>
                      @endforeach
                    </div>
                    <div class="swiper-pagination position-static mt-30" id="testimonial-slider-1-pagination"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="avatar">
            @foreach ($testimonials as $testimonial)
              <img class="lazyload avatar-1" data-src="{{ asset('assets/img/clients/' . $testimonial->image) }}"
                alt="Person Image">
            @endforeach
          </div>
        </div>
      </div>
      <!-- Bg shape -->
      <div class="bg-shape">
        <span></span>
        <span></span>
        <span></span>
        <span></span>
      </div>
    </section>
  @endif
  <!-- Testimonial-area end -->

  @if (count($after_testimonial) > 0)
    @foreach ($after_testimonial as $cusTestimonial)
      @if (isset($homecusSec[$cusTestimonial->id]))
        @if ($homecusSec[$cusTestimonial->id] == 1)
          @php
            $cusTestimonialContent = App\Models\HomePage\CustomSectionContent::where(
                'custom_section_id',
                $cusTestimonial->id,
            )
                ->where('language_id', $currentLanguageInfo->id)
                ->first();
          @endphp
          @include('frontend.home.custom-section', ['data' => $cusTestimonialContent])
        @endif
      @endif
    @endforeach
  @endif

  <!-- Blog-area start -->
  @if ($secInfo->blog_section_status == 1)
    <section class="blog-area blog-area_v1 pb-100" data-aos="fade-up">
      <div class="container">
        <div class="section-title title-inline mb-20" data-aos="fade-up">
          <h2 class="title fw-normal">
            {{ !empty($sectionContent->blog_section_title) ? $sectionContent->blog_section_title : __('Read Our Latest Blog') }}
          </h2>

          @if (count($blog_count) > count($blogs))
            <a href="{{ route('blog') }}" class="btn btn-lg btn-primary radius-sm"
              title="{{ $sectionContent ? $sectionContent->blog_section_button_text : __('Read All Post') }}"
              target="_self">
              {{ $sectionContent ? $sectionContent->blog_section_button_text : __('Read All Post') }}
            </a>
          @endif

        </div>
        <!-- Desktop Grid Layout -->
        <div class="row blog-grid">
          @if (count($blogs) < 1)
            <div class="p-3 text-center bg-light radius-md">
              <h6 class="mb-0">{{ __('NO POST FOUND') }}</h6>
            </div>
          @else
            @foreach ($blogs as $blog)
              <div class="col-md-6 col-xl-4" data-aos="fade-up">
                <article class="card border radius-md mt-30">
                  <div class="card_top mb-30">
                    <div class="card_img">
                      <a href="{{ route('blog_details', ['slug' => $blog->slug, 'id' => $blog->id]) }}" target="_self"
                        title="{{ __('Link') }}" class="lazy-container radius-sm ratio ratio-2-3">
                        <img class="lazyload" data-src="{{ asset('assets/img/blogs/' . $blog->image) }}"
                          alt="Blog Image">
                      </a>
                    </div>
                  </div>
                  <div class="card_content px-20">
                    <h4 class="card_title fw-normal lc-2 mb-15">
                      <a href="{{ route('blog_details', ['slug' => $blog->slug, 'id' => $blog->id]) }}" target="_self"
                        title="{{ __('Link') }}">
                        {{ $blog->title }}
                      </a>
                    </h4>
                    <p class="card_text lc-2">
                      {{ strlen(strip_tags(convertUtf8($blog->content))) > 100 ? substr(strip_tags(convertUtf8($blog->content)), 0, 100) . '...' : strip_tags(convertUtf8($blog->content)) }}
                    </p>
                    <div class="cta-btn mt-20">
                      <a href="{{ route('blog_details', ['slug' => $blog->slug, 'id' => $blog->id]) }}"
                        class="btn btn-lg btn-secondary radius-sm shadow-md icon-end" title="{{ $blog->title }}"
                        target="_self">
                        <span>{{ __('Read More') }}</span>
                        <i
                          class="fal {{ $currentLanguageInfo->direction == 1 ? 'fa-long-arrow-left' : 'fa-long-arrow-right' }}"></i>
                      </a>
                    </div>
                  </div>
                </article>
              </div>
            @endforeach
          @endif
        </div>

        <!-- Mobile Slider Layout -->
        <div class="mobile-blog-slider" style="display: none;">
          @if (count($blogs) < 1)
            <div class="p-3 text-center bg-light radius-md">
              <h6 class="mb-0">{{ __('NO POST FOUND') }}</h6>
            </div>
          @else
            <div class="swiper blog-swiper" id="blog-swiper">
              <div class="swiper-wrapper">
                @foreach ($blogs as $blog)
                  <div class="swiper-slide">
                    <article class="card border radius-md mt-30">
                      <div class="card_top mb-30">
                        <div class="card_img">
                          <a href="{{ route('blog_details', ['slug' => $blog->slug, 'id' => $blog->id]) }}" target="_self"
                            title="{{ __('Link') }}" class="lazy-container radius-sm ratio ratio-2-3">
                            <img class="lazyload" data-src="{{ asset('assets/img/blogs/' . $blog->image) }}"
                              alt="Blog Image">
                          </a>
                        </div>
                      </div>
                      <div class="card_content px-20">
                        <h4 class="card_title fw-normal lc-2 mb-15">
                          <a href="{{ route('blog_details', ['slug' => $blog->slug, 'id' => $blog->id]) }}" target="_self"
                            title="{{ __('Link') }}">
                            {{ $blog->title }}
                          </a>
                        </h4>
                        <p class="card_text lc-2">
                          {{ strlen(strip_tags(convertUtf8($blog->content))) > 100 ? substr(strip_tags(convertUtf8($blog->content)), 0, 100) . '...' : strip_tags(convertUtf8($blog->content)) }}
                        </p>
                        <div class="cta-btn mt-20">
                          <a href="{{ route('blog_details', ['slug' => $blog->slug, 'id' => $blog->id]) }}"
                            class="btn btn-lg btn-secondary radius-sm shadow-md icon-end" title="{{ $blog->title }}"
                            target="_self">
                            <span>{{ __('Read More') }}</span>
                            <i
                              class="fal {{ $currentLanguageInfo->direction == 1 ? 'fa-long-arrow-left' : 'fa-long-arrow-right' }}"></i>
                          </a>
                        </div>
                      </div>
                    </article>
                  </div>
                @endforeach
              </div>
              <!-- Swiper Pagination -->
              <div class="swiper-pagination blog-pagination"></div>
            </div>
          @endif
        </div>
      </div>
    </section>
  @endif
  <!-- Blog-area end -->

  @if (count($after_blog) > 0)
    @foreach ($after_blog as $cusBlog)
      @if (isset($homecusSec[$cusBlog->id]))
        @if ($homecusSec[$cusBlog->id] == 1)
          @php
            $cusBlogContent = App\Models\HomePage\CustomSectionContent::where('custom_section_id', $cusBlog->id)
                ->where('language_id', $currentLanguageInfo->id)
                ->first();
          @endphp
          @include('frontend.home.custom-section', ['data' => $cusBlogContent])
        @endif
      @endif
    @endforeach
  @endif

  <!-- CITY-area start -->
  @if ($secInfo->city_section_status == 1)
    <section class="category-area category-area_v1 pt-80 pb-90" id="scrollDiv" style="margin-top: 60px;">
      <div class="container">
        <div class="row">
          <div class="col-12">
            <div class="section-title title-inline mb-50" data-aos="fade-up">
              <h2 class="title fw-normal">
                {{ !empty($sectionContent->city_section_title) ? $sectionContent->city_section_title : '' }}</h2>
            </div>
          </div>
          <div class="col-12">
            <div class="swiper category-slider" id="category-slider-1" data-slides-per-view="4" data-swiper-loop="true"
              data-swiper-space="30">
              <div class="swiper-wrapper">
                @foreach ($cities as $city)
                  <div class="swiper-slide">
                    <div class="card mb-30">
                      <div class="card_img">
                        <a href="{{ route('frontend.hotels', ['city' => $city->id]) }}" title="{{ $city->name }}"
                          target="_self" class="lazy-container ratio ratio-1-2 radius-md">
                          <img class="lazyload"
                            data-src="{{ asset('assets/img/location/city/' . $city->feature_image) }}" alt="Image">
                        </a>
                      </div>
                      <div class="card_content">
                        <a href="{{ route('frontend.hotels', ['city' => $city->id]) }}"
                          class="btn btn-lg btn-secondary radius-sm shadow-md icon-end" title="{{ $city->name }}"
                          target="_self">
                          <span>{{ $city->name }}</span>
                          <i
                            class="fal {{ $currentLanguageInfo->direction == 1 ? 'fa-long-arrow-left' : 'fa-long-arrow-right' }}"></i>
                        </a>
                      </div>
                    </div>
                  </div>
                @endforeach
              </div>
              <!-- If we need pagination -->
              <div class="swiper-pagination position-static mb-30" id="category-slider-1-pagination"></div>
            </div>
          </div>
        </div>
      </div>
    </section>
  @endif
  <!-- CITY-area end -->

  @if (count($after_city) > 0)
    @foreach ($after_city as $cusCity)
      @if (isset($homecusSec[$cusCity->id]))
        @if ($homecusSec[$cusCity->id] == 1)
          @php
            $cusCityContent = App\Models\HomePage\CustomSectionContent::where('custom_section_id', $cusCity->id)
                ->where('language_id', $currentLanguageInfo->id)
                ->first();
          @endphp
          @include('frontend.home.custom-section', ['data' => $cusCityContent])
        @endif
      @endif
    @endforeach
  @endif

  <!-- Call to action section start -->
  @if ($secInfo->call_to_action_section_status == 1)
    <section class="newsletter-area newsletter-area_v1 pb-100" data-aos="fade-up">
      <div class="container">
        <div class="newsletter-inner position-relative overflow-hidden z-1 px-3 ptb-70 radius-md bg-img"
          data-bg-img="{{ asset('assets/img/homepage/' . $images->call_to_action_section_image) }}">
          <div class="overlay opacity-60"></div>
          <div class="row justify-content-center">
            <div class="col-lg-6">
              <div class="content-title text-center">
                <h2 class="title mb-30 fw-normal color-white">
                  {{ $sectionContent ? $sectionContent->call_to_action_section_title : '' }}
                </h2>
                @if ($sectionContent && $sectionContent->call_to_action_button_url && $sectionContent->call_to_action_section_btn)
                  <a href="{{ $sectionContent->call_to_action_button_url }}" class="btn btn-lg btn-primary radius-sm"
                    title="{{ $sectionContent->call_to_action_section_btn }}"
                    target="_self">{{ $sectionContent->call_to_action_section_btn }}</a>
                @endif
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  @endif
  <!-- Call to action section-area end -->
  @if (count($after_call_to_action) > 0)
    @foreach ($after_call_to_action as $cusAction)
      @if (isset($homecusSec[$cusAction->id]))
        @if ($homecusSec[$cusAction->id] == 1)
          @php
            $cusActionContent = App\Models\HomePage\CustomSectionContent::where('custom_section_id', $cusAction->id)
                ->where('language_id', $currentLanguageInfo->id)
                ->first();
          @endphp
          @include('frontend.home.custom-section', ['data' => $cusActionContent])
        @endif
      @endif
    @endforeach
  @endif 

  <!-- Modal -->
  @include('frontend.partials.map-modal')

  <style>
    /* Hero Navbar Styling (Inside Hero Section) */
    .hero-navbar {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      z-index: 1050;
      background: transparent;
      transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .hero-navbar .navbar {
      padding: 20px 0;
    }

    .hero-navbar .navbar-brand img {
      max-height: 40px;
      width: auto;
    }

    /* Ensure logo shows even if image fails to load */
    .hero-navbar .brand-text {
      color: #fff;
      font-weight: 600;
      font-size: 1.5rem;
      text-transform: uppercase;
    }

    .hero-navbar .brand-text {
      color: #fff;
      font-weight: 600;
      font-size: 1.5rem;
    }

    .hero-navbar .header-actions {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .hero-navbar .language-selector select {
      background: transparent;
      border: 1px solid rgba(255, 255, 255, 0.3);
      border-radius: 6px;
      padding: 6px 12px;
      font-size: 14px;
      color: #fff;
    }

    .hero-navbar .language-selector select option {
      background: #333;
      color: #fff;
    }

    .hero-navbar .btn {
      border-radius: 6px;
      font-size: 14px;
      padding: 8px 16px;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .hero-navbar .btn-outline-light {
      border-color: rgba(255, 255, 255, 0.5);
      color: #fff;
      background: transparent;
    }

    .hero-navbar .btn-outline-light:hover {
      background: rgba(255, 255, 255, 0.1);
      color: #fff;
      border-color: rgba(255, 255, 255, 0.8);
    }

    .hero-navbar .btn-light {
      background: rgba(255, 255, 255, 0.9);
      color: #000;
      border-color: rgba(255, 255, 255, 0.9);
    }

    .hero-navbar .btn-light:hover {
      background: #fff;
      color: #000;
    }

    .hero-navbar.hidden {
      opacity: 0;
      visibility: hidden;
      transform: translateY(-20px);
      transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    }

    /* Hero Section Positioning */
    .peerspace-hero {
      position: relative;
    }

    /* Sticky Navbar Styling (Hidden Initially) */
    .peerspace-header-nav {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      z-index: 1050;
      background: rgba(0, 0, 0, 0.9);
      backdrop-filter: blur(10px);
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
      transform: translateY(-100%);
      opacity: 0;
      visibility: hidden;
    }

    .peerspace-header-nav.sticky-active {
      transform: translateY(0);
      opacity: 1;
      visibility: visible;
      transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .peerspace-header-nav .navbar {
      padding: 15px 0;
    }

    .peerspace-header-nav .navbar-brand img {
      max-height: 40px;
      width: auto;
    }

    .peerspace-header-nav .brand-text {
      color: #fff;
      font-weight: 600;
      font-size: 1.5rem;
      text-transform: uppercase;
    }

    .peerspace-header-nav .header-actions {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .peerspace-header-nav .language-selector select {
      background: transparent;
      border: 1px solid rgba(255, 255, 255, 0.3);
      border-radius: 6px;
      padding: 6px 12px;
      font-size: 14px;
      color: #fff;
    }

    .peerspace-header-nav .language-selector select option {
      background: #333;
      color: #fff;
    }

    .peerspace-header-nav .btn {
      border-radius: 6px;
      font-size: 14px;
      padding: 8px 16px;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .peerspace-header-nav .btn-outline-light {
      border-color: rgba(255, 255, 255, 0.5);
      color: #fff;
      background: transparent;
    }

    .peerspace-header-nav .btn-outline-light:hover {
      background: rgba(255, 255, 255, 0.1);
      color: #fff;
      border-color: rgba(255, 255, 255, 0.8);
    }

    .peerspace-header-nav .btn-light {
      background: rgba(255, 255, 255, 0.9);
      color: #000;
      border-color: rgba(255, 255, 255, 0.9);
    }

    .peerspace-header-nav .btn-light:hover {
      background: #fff;
      color: #000;
    }

    /* Mobile Toggle Button Styling */
    .mobile-toggle {
      display: none;
      border: none;
      background: transparent;
      padding: 8px;
      border-radius: 4px;
      transition: all 0.3s ease;
    }

    .mobile-toggle .navbar-toggler-icon {
      background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.9%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
      width: 24px;
      height: 24px;
    }

    .hero-navbar .mobile-toggle .navbar-toggler-icon {
      background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.9%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }

    .peerspace-header-nav .mobile-toggle .navbar-toggler-icon {
      background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.9%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }

    .mobile-toggle:hover {
      background: rgba(255, 255, 255, 0.1);
    }

    /* Mobile Responsive Styles */
    @media (max-width: 991px) {
      .mobile-toggle {
        display: block;
      }

      .navbar {
        align-items: center;
        justify-content: space-between;
      }

      .navbar-brand {
        margin-right: 0;
      }

      .navbar-collapse {
        position: absolute;
        top: 100%;
        left: 0;
        right: 0;
        background: rgba(0, 0, 0, 0.95);
        backdrop-filter: blur(10px);
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        padding: 20px;
        z-index: 1000;
        display: none;
      }

      .navbar-collapse.show {
        display: block;
      }

      .hero-navbar .navbar-collapse {
        background: rgba(0, 0, 0, 0.9);
      }

      .header-actions {
        flex-direction: column;
        gap: 15px;
        align-items: stretch;
      }

      .language-selector,
      .user-actions,
      .vendor-actions {
        display: flex;
        flex-direction: column;
        gap: 10px;
      }

      .user-actions .btn,
      .vendor-actions .btn {
        width: 100%;
        justify-content: center;
      }

      .dropdown-menu {
        position: static !important;
        transform: none !important;
        background: transparent;
        border: none;
        padding: 10px 0;
      }

      .dropdown-item {
        color: #fff;
        padding: 8px 0;
      }

      .dropdown-item:hover {
        background: rgba(255, 255, 255, 0.1);
        color: #fff;
      }
    }

    @media (max-width: 576px) {
      .hero-navbar .navbar,
      .peerspace-header-nav .navbar {
        padding: 10px 0;
      }

      .navbar-brand img {
        max-height: 32px;
      }

      .brand-text {
        font-size: 1.2rem;
      }

      .mobile-toggle {
        padding: 6px;
      }

      .mobile-toggle .navbar-toggler-icon {
        width: 20px;
        height: 20px;
      }
    }

    /* Peerspace Hero Section Styling */
    .content {
      background: #ffffff;
      padding: 80px 0;
    }

    .main-headline {
      font-size: 3.5rem;
      font-weight: 700;
      color: #000000;
      line-height: 1.1;
      margin-bottom: 1rem;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    }

    .sub-headline {
      font-size: 1.25rem;
      color: #000000;
      margin-bottom: 3rem;
      font-weight: 400;
      line-height: 1.4;
    }

    .activity-categories {
      margin-bottom: 3rem;
    }

    .category-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
      gap: 1rem;
      max-width: 600px;
    }

    .category-link {
      display: inline-block;
      color: #000000;
      text-decoration: none;
      font-size: 1rem;
      font-weight: 400;
      padding: 0.5rem 0;
      transition: all 0.2s ease;
      border-bottom: 1px solid transparent;
      cursor: pointer;
    }

    .category-link:hover {
      color: #000000;
      text-decoration: none;
      border-bottom: 1px solid #000000;
    }

    .category-link.active {
      font-weight: 700;
      border-bottom: 1px solid #000000;
    }

    .cta-section {
      margin-top: 2rem;
    }

    .browse-button {
      display: inline-block;
      background: #000000;
      color: #ffffff;
      padding: 1rem 2rem;
      text-decoration: none;
      font-weight: 600;
      font-size: 1rem;
      transition: all 0.2s ease;
      border: 2px solid #000000;
    }

    .browse-button:hover {
      background: #ffffff;
      color: #000000;
      text-decoration: none;
    }

    .hero-image {
      position: relative;
      border-radius: 12px;
      overflow: hidden;
      min-height: 500px;
      aspect-ratio: 4/3;
    }

    .hero-image img {
      width: 100%;
      height: 100%;
      display: block;
      transition: opacity 0.3s ease;
      object-fit: cover;
      object-position: center;
    }

    .intro-image {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      opacity: 0;
      transition: opacity 0.3s ease;
      display: none;
      object-fit: cover;
      object-position: center;
    }

    .intro-image.active {
      opacity: 1;
      display: block;
    }

    .image-label {
      position: absolute;
      right: 20px;
      top: 50%;
      transform: translateY(-50%);
      background: rgba(0, 0, 0, 0.8);
      color: #ffffff;
      padding: 0.5rem 1rem;
      font-size: 0.9rem;
      font-weight: 600;
      writing-mode: vertical-rl;
      text-orientation: mixed;
    }

    /* Responsive Design */
    @media (max-width: 991px) {
      .main-headline {
        font-size: 2.5rem;
      }
      
      .category-grid {
        grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
        gap: 0.75rem;
      }
      
      .content-right {
        margin-top: 3rem;
      }
    }

    @media (max-width: 768px) {
      .main-headline {
        font-size: 2rem;
      }
      
      .sub-headline {
        font-size: 1.1rem;
      }
      
      .category-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 0.5rem;
      }
    }

    /* Cities Section Styling */
    .category-area {
      background: #f8f9fa;
      padding: 40px 0;
    }

    .category-area .card {
      margin-bottom: 30px;
      transition: all 0.3s ease;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .category-area .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
    }

    .category-area .card_img {
      position: relative;
      overflow: hidden;
    }

    .category-area .card_img img {
      transition: transform 0.3s ease;
    }

    .category-area .card:hover .card_img img {
      transform: scale(1.05);
    }

    .category-area .card_content {
      padding: 20px;
      background: white;
    }

    .category-area .btn {
      width: 100%;
      justify-content: space-between;
      padding: 12px 20px;
      font-weight: 600;
      border-radius: 8px;
      transition: all 0.3s ease;
    }

    .category-area .btn:hover {
      transform: translateX(5px);
    }

    /* Swiper spacing */
    .swiper-slide {
      padding: 0 15px;
    }

    /* Section title spacing */
    .category-area .section-title {
      margin-bottom: 60px;
    }

    /* Hotel Grid Layout */
    .hotel-grid {
      display: flex;
      flex-wrap: wrap;
      margin-left: -12px;
      margin-right: -12px;
    }

    .hotel-grid .col-xl-4,
    .hotel-grid .col-lg-4,
    .hotel-grid .col-md-6 {
      padding-left: 12px;
      padding-right: 12px;
      margin-bottom: 24px;
    }

    /* Desktop: 3 cards per row */
    @media (min-width: 992px) {
      .hotel-grid .col-xl-4,
      .hotel-grid .col-lg-4 {
        flex: 0 0 33.333333%;
        max-width: 33.333333%;
      }
    }

    /* Tablet: 2 cards per row */
    @media (min-width: 768px) and (max-width: 991px) {
      .hotel-grid .col-md-6 {
        flex: 0 0 50%;
        max-width: 50%;
      }
    }

    /* Mobile: 1 card per row */
    @media (max-width: 767px) {
      .hotel-grid .col-sm-6 {
        flex: 0 0 100%;
        max-width: 100%;
      }
    }

    /* Blog Grid Layout */
    .blog-grid {
      display: flex;
      flex-wrap: wrap;
      margin-left: -12px;
      margin-right: -12px;
    }

    .blog-grid .col-xl-4,
    .blog-grid .col-lg-4,
    .blog-grid .col-md-6 {
      padding-left: 12px;
      padding-right: 12px;
      margin-bottom: 24px;
    }

    /* Desktop: 3 cards per row */
    @media (min-width: 992px) {
      .blog-grid .col-xl-4,
      .blog-grid .col-lg-4 {
        flex: 0 0 33.333333%;
        max-width: 33.333333%;
      }
    }

    /* Tablet: 2 cards per row */
    @media (min-width: 768px) and (max-width: 991px) {
      .blog-grid .col-md-6 {
        flex: 0 0 50%;
        max-width: 50%;
      }
    }

    /* Mobile: 1 card per row */
    @media (max-width: 767px) {
      .blog-grid .col-sm-6 {
        flex: 0 0 100%;
        max-width: 100%;
      }
    }

    /* Peerspace Card Styling - Exact Match */
    .space-card {
      background: #ffffff;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
      transition: all 0.2s ease;
      height: 400px;
      width: 100%;
      display: flex;
      flex-direction: column;
      margin-bottom: 0;
      border: 1px solid #e1e1e1;
    }

    .space-card:hover {
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
      transform: translateY(-2px);
    }

    .card-image-container {
      position: relative;
      height: 240px;
      overflow: hidden;
    }

    .card-image {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.3s ease;
    }

    .space-card:hover .card-image {
      transform: scale(1.05);
    }

    .heart-button {
      position: absolute;
      top: 12px;
      right: 12px;
      background: rgba(255, 255, 255, 0.9);
      border: none;
      border-radius: 50%;
      width: 36px;
      height: 36px;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      transition: all 0.2s ease;
      color: #484848;
      backdrop-filter: blur(4px);
    }

    .heart-button:hover {
      background: rgba(255, 255, 255, 1);
      transform: scale(1.1);
    }

    .heart-button.active {
      color: #ff385c;
    }

    .heart-button.active svg path {
      fill: #ff385c;
    }

    .card-content {
      padding: 16px;
      flex: 1;
      display: flex;
      flex-direction: column;
    }

    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 8px;
    }

    .rating-badge {
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .stars {
      display: flex;
      align-items: center;
      gap: 1px;
    }

    .stars i {
      font-size: 12px;
      color: #ddd;
    }

    .stars i.filled {
      color: #ffc107;
    }

    .rating-number {
      font-size: 12px;
      color: #717171;
    }

    .guest-capacity {
      font-size: 14px;
      color: #717171;
    }

    .guest-capacity .badge {
      background-color: #f7f7f7 !important;
      color: #484848 !important;
      border: 1px solid #e1e1e1 !important;
      font-size: 12px !important;
      font-weight: 500 !important;
      padding: 4px 8px !important;
      border-radius: 4px !important;
    }

    .card-title {
      margin: 0 0 4px 0;
      font-size: 16px;
      font-weight: 600;
      line-height: 1.3;
      color: #484848;
    }

    .card-title a {
      color: inherit;
      text-decoration: none;
    }

    .card-title a:hover {
      color: #000;
    }

    .card-location {
      font-size: 14px;
      color: #717171;
      margin-bottom: 12px;
      line-height: 1.3;
    }

    .card-features {
      display: flex;
      flex-wrap: wrap;
      gap: 6px;
      margin-bottom: 16px;
      flex: 1;
    }

    .card-features .badge {
      margin-right: 6px;
      margin-bottom: 6px;
      padding: 6px 10px;
      font-size: 12px;
      font-weight: 500;
      border: 1px solid #e1e1e1;
    }

    .card-features .badge i {
      margin-right: 4px;
      font-size: 12px;
    }

    .feature-more {
      color: #717171;
      font-size: 12px;
      font-weight: 500;
      align-self: center;
    }

    /* Grid Layout */
    .row {
      margin-left: -12px;
      margin-right: -12px;
    }

    .col-xl-4, .col-lg-4, .col-md-6, .col-sm-6 {
      padding-left: 12px;
      padding-right: 12px;
    }

    /* Responsive Design */
    @media (max-width: 1200px) {
      .col-xl-4 {
        flex: 0 0 33.333333%;
        max-width: 33.333333%;
      }
    }

    @media (max-width: 992px) {
      .col-lg-4 {
        flex: 0 0 50%;
        max-width: 50%;
      }
      
      .space-card {
        height: 380px;
      }
      
      .card-image-container {
        height: 220px;
      }
    }

    /* Mobile Slider Display Logic */
    @media (max-width: 767px) {
      .hotel-grid {
        display: none !important;
      }
      
      .mobile-hotel-slider {
        display: block !important;
      }
      
      .blog-grid {
        display: none !important;
      }
      
      .mobile-blog-slider {
        display: block !important;
      }
    }

    @media (min-width: 768px) {
      .hotel-grid {
        display: flex !important;
      }
      
      .mobile-hotel-slider {
        display: none !important;
      }
      
      .blog-grid {
        display: flex !important;
      }
      
      .mobile-blog-slider {
        display: none !important;
      }
    }

    @media (max-width: 768px) {
      .col-md-6 {
        flex: 0 0 50%;
        max-width: 50%;
      }
      
      .space-card {
        height: 360px;
      }
      
      .card-image-container {
        height: 200px;
      }
      
      .card-content {
        padding: 12px;
      }
    }

    @media (max-width: 576px) {
      .col-sm-6 {
        flex: 0 0 100%;
        max-width: 100%;
      }
      
      .space-card {
        height: 380px;
      }
      
      .card-image-container {
        height: 200px;
      }

      .mobile-hotel-slider .space-card {
        height: 400px;
      }

      .mobile-hotel-slider .card-image-container {
        height: 220px;
      }
    }

    /* Mobile Hotel Slider Styles */
    .mobile-hotel-slider {
      display: none;
    }

    .hotel-swiper {
      padding: 0 15px 40px 15px;
    }

    .hotel-swiper .swiper-slide {
      width: 320px;
      margin-right: 20px;
    }

    .hotel-pagination {
      position: relative;
      margin-top: 20px;
    }

    .hotel-pagination .swiper-pagination-bullet {
      width: 8px;
      height: 8px;
      background: #ddd;
      opacity: 1;
      margin: 0 4px;
    }

    .hotel-pagination .swiper-pagination-bullet-active {
      background: #000;
    }

    /* Responsive Display */
    @media (max-width: 991px) {
      .desktop-hotel-grid {
        display: none;
      }
      
      .mobile-hotel-slider {
        display: block;
      }
    }

    @media (min-width: 992px) {
      .desktop-hotel-grid {
        display: block;
      }
      
      .mobile-hotel-slider {
        display: none;
      }

      .desktop-blog-grid {
        display: block;
      }
      
      .mobile-blog-slider {
        display: none;
      }
    }

    /* Mobile Blog Slider Styles */
    .mobile-blog-slider {
      display: none;
    }

    .blog-swiper {
      padding: 0 15px 40px 15px;
    }

    .blog-swiper .swiper-slide {
      width: 320px;
      margin-right: 20px;
    }

    .blog-pagination {
      position: relative;
      margin-top: 20px;
    }

    .blog-pagination .swiper-pagination-bullet {
      width: 8px;
      height: 8px;
      background: #ddd;
      opacity: 1;
      margin: 0 4px;
    }

    .blog-pagination .swiper-pagination-bullet-active {
      background: #000;
    }

    /* Blog Responsive Display */
    @media (max-width: 991px) {
      .desktop-blog-grid {
        display: none;
      }
      
      .mobile-blog-slider {
        display: block;
      }
    }
  </style>

@endsection
@section('script')
  @if ($basicInfo->google_map_api_key_status == 1)
    <script src="{{ asset('assets/front/js/map-init.js') }}"></script>
    <script
      src="https://maps.googleapis.com/maps/api/js?key={{ $basicInfo->google_map_api_key }}&libraries=places&callback=initMap"
      async defer></script>
  @endif
  <script src="{{ asset('assets/front/js/search-home.js') }}"></script>
  
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // Navbar Elements
      const heroNavbar = document.getElementById('heroNavbar');
      const stickyNavbar = document.getElementById('stickyNavbar');
      const heroSection = document.querySelector('.peerspace-hero');
      let lastScrollTop = 0;
      let ticking = false;
      
      function handleScroll() {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        if (!ticking) {
          requestAnimationFrame(function() {
            const triggerDistance = 300; // Adjust this value (higher = earlier appearance)
            
            if (scrollTop >= triggerDistance) {
              if (heroNavbar) heroNavbar.classList.add('hidden');
              if (stickyNavbar) stickyNavbar.classList.add('sticky-active');
            } else {
              if (heroNavbar) heroNavbar.classList.remove('hidden');
              if (stickyNavbar) stickyNavbar.classList.remove('sticky-active');
            }
            
            lastScrollTop = scrollTop;
            ticking = false;
          });
          
          ticking = true;
        }
      }
      
      window.addEventListener('scroll', handleScroll, { passive: true });
      handleScroll();
      const categoryLinks = document.querySelectorAll('.category-link');
      const introImages = document.querySelectorAll('.intro-image');
      
      if (introImages.length > 0) {
        introImages[0].classList.add('active');
      }
      
      categoryLinks.forEach(link => {
        link.addEventListener('mouseenter', function() {
          const introId = this.getAttribute('data-intro-id');
          introImages.forEach(img => {
            img.classList.remove('active');
          });
          
          const targetImage = document.querySelector(`.intro-image[data-intro-id="${introId}"]`);
          if (targetImage) {
            targetImage.classList.add('active');
          }
          
          categoryLinks.forEach(l => l.classList.remove('active'));
          this.classList.add('active');
        });
      });
      
      const activityCategories = document.querySelector('.activity-categories');
      activityCategories.addEventListener('mouseleave', function() {
        introImages.forEach((img, index) => {
          if (index === 0) {
            img.classList.add('active');
          } else {
            img.classList.remove('active');
          }
        });
        
        // Remove active class from all links
        categoryLinks.forEach(l => l.classList.remove('active'));
      });

      // Initialize Hotel Slider for Mobile
      let hotelSwiper = null;
      
      function initHotelSwiper() {
        if (window.innerWidth <= 991) {
          if (!hotelSwiper) {
            hotelSwiper = new Swiper('#hotel-swiper', {
              slidesPerView: 'auto',
              spaceBetween: 20,
              centeredSlides: false,
              loop: false,
              pagination: {
                el: '.hotel-pagination',
                clickable: true,
              },
              breakpoints: {
                320: {
                  slidesPerView: 1.1,
                  spaceBetween: 15,
                },
                480: {
                  slidesPerView: 1.3,
                  spaceBetween: 20,
                },
                768: {
                  slidesPerView: 1.8,
                  spaceBetween: 20,
                },
                991: {
                  slidesPerView: 2.1,
                  spaceBetween: 20,
                }
              }
            });
          }
        } else {
          if (hotelSwiper) {
            hotelSwiper.destroy(true, true);
            hotelSwiper = null;
          }
        }
      }

      // Initialize Blog Slider for Mobile
      let blogSwiper = null;
      
      function initBlogSwiper() {
        if (window.innerWidth <= 991) {
          if (!blogSwiper) {
            blogSwiper = new Swiper('#blog-swiper', {
              slidesPerView: 'auto',
              spaceBetween: 20,
              centeredSlides: false,
              loop: false,
              pagination: {
                el: '.blog-pagination',
                clickable: true,
              },
              breakpoints: {
                320: {
                  slidesPerView: 1.1,
                  spaceBetween: 15,
                },
                480: {
                  slidesPerView: 1.3,
                  spaceBetween: 20,
                },
                768: {
                  slidesPerView: 1.8,
                  spaceBetween: 20,
                },
                991: {
                  slidesPerView: 2.1,
                  spaceBetween: 20,
                }
              }
            });
          }
        } else {
          if (blogSwiper) {
            blogSwiper.destroy(true, true);
            blogSwiper = null;
          }
        }
      }

      // Initialize on load
      initHotelSwiper();
      initBlogSwiper();

      // Reinitialize on resize
      window.addEventListener('resize', function() {
        initHotelSwiper();
        initBlogSwiper();
      });
    });
  </script>
@endsection
