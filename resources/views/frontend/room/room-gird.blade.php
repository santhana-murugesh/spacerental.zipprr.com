@extends('frontend.layout')

@section('pageHeading')
  @if (!empty($pageHeading->rooms_page_title))
    {{ $pageHeading->rooms_page_title }}   
  @else
    {{ __('Rooms') }}
  @endif
@endsection

@section('metaKeywords')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_keyword_rooms }}
  @endif
@endsection

@section('metaDescription')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_description_rooms }}
  @endif
@endsection

@section('content')

  <!-- Page title start-->
  @includeIf('frontend.partials.breadcrumb', [
      'breadcrumb' => $bgImg->breadcrumb,
      'title' => !empty($pageHeading) ? $pageHeading->rooms_page_title : __('Rooms'),
  ])
  <!-- Page title end-->

  <!-- Listing-area start -->
  <div class="listing-area pt-100 pb-60">
    <div class="container">
      <div class="row gx-xl-5">
        <div class="col-12 order-first">
          <div class="sort-area" data-aos="fade-up">
            <div class="row align-items-center">
              <div class="col-lg-4">
              </div>
              <div class="col-lg-8 col-sm-8">
              </div>
            </div>
          </div>
        </div>
        <div class="col-xl-3" data-aos="fade-up">
          <div class="widget-offcanvas offcanvas-xl offcanvas-start sticky" tabindex="-1" id="widgetOffcanvas"
            aria-labelledby="widgetOffcanvas">
            <div class="sidebar-scroll">
              <div class="offcanvas-header px-20">
                <h4 class="offcanvas-title">{{ __('Filter') }}</h4>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#widgetOffcanvas"
                  aria-label="Close"></button>
              </div>
              @include('frontend.room.side-bar')
            </div>
          </div>
          <!-- Spacer -->
          <div class="pb-25 d-none d-xl-block"></div>
        </div>
        <div class="col-xl-9">
          <!-- Sort-Area -->
          <div class="sort-area" data-aos="fade-up">
            <!-- Filter Button -->
            <button class="btn btn-sm btn-outline icon-end  radius-sm d-block d-xl-none" type="button"
              data-bs-toggle="offcanvas" data-bs-target="#widgetOffcanvas" aria-controls="widgetOffcanvas">
              {{ __('Filter') }} <i class="fal fa-filter"></i>
            </button>
            <!-- Sort List -->
            <ul class="sort-list list-unstyled w-100 justify-content-between">
              <li class="item">
                <div class="form-group icon-end location-group">
                  <input class="form-control" value="{{ request()->input('location') }}" type="text" autocomplete="off"
                    placeholder="{{ __('Enter location') }}" name="location" id="location">
                  @if ($basicInfo->google_map_api_key_status == 1)
                    <button type="button" class="btn btn-sm current-location" onclick="getCurrentLocation()">
                      <i class="fas fa-crosshairs"></i>
                    </button>
                  @endif
                </div>
              </li>

              <li class="item">
                <form>
                  <div class="sort-item d-flex align-items-center">
                    <label class="me-2 font-sm" for="select_sort">{{ __('Sort By') }}:</label>
                    <select name="select_sort" id="select_sort" class="sort nice-select right color-dark">

                      <option {{ request()->input('sort') == 'new' ? 'selected' : '' }} value="new">
                        {{ __('Newest on top') }}
                      </option>
                      <option {{ request()->input('sort') == 'old' ? 'selected' : '' }} value="old">
                        {{ __('Oldest on top') }}
                      </option>
                      <option {{ request()->input('sort') == 'starhigh' ? 'selected' : '' }} value="starhigh">
                        {{ __('Stars: High to Low') }}
                      </option>
                      <option {{ request()->input('sort') == 'starlow' ? 'selected' : '' }} value="starlow">
                        {{ __('Stars: Low to High') }}
                      </option>

                      <option {{ request()->input('sort') == 'reviewshigh' ? 'selected' : '' }} value="reviewshigh">
                        {{ __('Reviews: High to Low') }}
                      </option>
                      <option {{ request()->input(' sort') == 'reviewslow' ? 'selected' : '' }} value="reviewslow">
                        {{ __('Reviews: Low to High') }}
                      </option>

                    </select>
                  </div>
                </form>
              </li>
            </ul>
          </div>

          <div class="search-container mb-40">
            @if (count($featured_contents) < 1 && count($currentPageData) < 1)
              <div class="p-3 text-center bg-light radius-md">
                <h6 class="mb-0">{{ __('NO ROOM FOUND') }}</h6>
              </div>
            @else
              <div class="row pb-15" data-aos="fade-up">
                @foreach ($featured_contents as $room)
                  <div class="col-lg-4 col-md-6">
                    <div class="product-default product-default-style-2 border radius-md mb-25  border-primary featured">
                      <figure class="product_img">
                        <a href="javascript:void(0)" 
                           class="room-details-link lazy-container ratio ratio-2-3 radius-sm"
                           data-room-id="{{ $room->id }}"
                           data-room-title="{{ $room->title }}"
                           data-room-slug="{{ $room->slug }}">
                          <img class="lazyload" src="{{ asset('assets/img/room/featureImage/' . $room->feature_image) }}"
                            alt="{{ __('Room Image') }}">
                        </a>
                        @if (Auth::guard('web')->check())
                          @php
                            $user_id = Auth::guard('web')->user()->id;
                            $checkWishList = checkroomWishList($room->id, $user_id);
                          @endphp
                        @else
                          @php
                            $checkWishList = false;
                          @endphp
                        @endif

                        <a href="{{ $checkWishList == false ? route('addto.wishlist.room', $room->id) : route('remove.wishlist.room', $room->id) }}"
                          class="btn btn-icon radius-sm {{ $checkWishList == false ? '' : 'active' }}"
                          data-tooltip="tooltip" data-bs-placement="top"
                          title="{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}">
                          <i class="fal fa-heart"></i>
                        </a>

                        <div class="rank-star">
                          @for ($i = 0; $i < $room->stars; $i++)
                            <i class="fas fa-star"></i>
                          @endfor
                        </div>

                      </figure>
                      <div class="product_details">
                        <div class="p-20">
                          <div class="product_title">
                            <h4 class="title lc-1 mb-0">
                              <a href="{{ route('frontend.room.details', ['slug' => $room->slug, 'id' => $room->id]) }}"
                                target="_self" title="{{ __('Link') }}">{{ $room->title }}</a>
                            </h4>
                          </div>
                          @php
                            $city = null;
                            $State = null;
                            $country = null;

                            if ($room->city_id) {
                                $city = App\Models\Location\City::Where('id', $room->city_id)->first()->name;
                            }
                            if ($room->state_id) {
                                $State = App\Models\Location\State::Where('id', $room->state_id)->first()->name;
                            }
                            if ($room->country_id) {
                                $country = App\Models\Location\Country::Where('id', $room->country_id)->first()->name;
                            }

                          @endphp
                          <div class="list-unstyled mt-10">
                            <li class="icon-start location mb-2">
                              <i class="fal fa-map-marker-alt"></i>
                              <span>
                                {{ @$city }}@if (@$State)
                                  , {{ $State }}
                                  @endif @if (@$country)
                                    , {{ $country }}
                                  @endif
                              </span>
                            </li>

                            <li>
                              <div class="ratings"dir="{{ $currentLanguageInfo->direction == 1 ? 'rtl' : '' }}">
                                <div class="product-ratings rate text-xsm">
                                  <div class="rating" style="width: {{ $room->average_rating * 20 }}%;"></div>
                                </div>
                                <span>{{ number_format($room->average_rating, 2) }}
                                  ({{ totalRoomReview($room->id) }}
                                  {{ totalRoomReview($room->id) > 1 ? __('Reviews') : __('Review') }})
                                </span>
                              </div>
                            </li>
                          </div>
                          <div class="product_author mt-14">
                            <a class="d-flex align-items-center gap-1"
                              href="{{ route('frontend.hotel.details', ['slug' => $room->hotelSlug, 'id' => $room->hotelId]) }}"
                              target="_self" title="{{ __('Link') }}">
                              <img class="lazyload blur-up"
                                src="{{ asset('assets/img/hotel/logo/' . $room->hotelImage) }}"alt="{{ __('Image') }}">
                              <span class="underline lc-1 font-sm" data-tooltip="tooltip" data-bs-placement="bottom"
                                aria-label="{{ $room->hotelName }}" data-bs-original-title="{{ $room->hotelName }}"
                                aria-describedby="tooltip">
                                {{ $room->hotelName }}
                              </span>
                            </a>
                          </div>
                          @php
                            $amenities = json_decode($room->amenities);
                            $totalAmenities = count($amenities);
                            $displayCount = 5;
                          @endphp

                          <ul class="product-icon_list mt-14 list-unstyled">
                            @foreach ($amenities as $index => $amenitie)
                              @php
                                if ($index >= $displayCount) {
                                    break;
                                }
                                $amin = App\Models\Amenitie::find($amenitie);
                              @endphp
                              <li class="list-item" data-tooltip="tooltip" data-bs-placement="bottom"
                                aria-label="{{ $amin->title }}" data-bs-original-title="{{ $amin->title }}"
                                aria-describedby="tooltip"><i class="{{ $amin->icon }}"></i></li>
                            @endforeach

                            @if ($totalAmenities > $displayCount)
                              <li class="more_item_show_btn">
                                (+{{ $totalAmenities - $displayCount }}<i class="fas fa-ellipsis-h"></i>)

                                <div class="more_items_icons">
                                  @foreach ($amenities as $index => $amenitie)
                                    @php
                                      if ($index < $displayCount) {
                                          continue;
                                      }
                                      $amin = App\Models\Amenitie::find($amenitie);
                                    @endphp
                                    <a data-tooltip="tooltip" data-bs-placement="bottom"
                                      aria-label="{{ $amin->title }}" data-bs-original-title="{{ $amin->title }}"
                                      aria-describedby="tooltip" href="#"><i class="{{ $amin->icon }}"
                                        title="{{ $amin->title }}"></i></a>
                                  @endforeach
                                </div>
                              </li>
                            @endif
                          </ul>

                        </div>
                        <div class="product_bottom pt-20 pb-20 px-10 border-top text-center">
                          <ul class="product-price_list list-unstyled">
                            @php
                              $prices = App\Models\HourlyRoomPrice::where('room_id', $room->id)
                                  ->where('hourly_room_prices.price', '!=', null)
                                  ->join('booking_hours', 'hourly_room_prices.hour_id', '=', 'booking_hours.id')
                                  ->orderBy('booking_hours.serial_number')
                                  ->select('hourly_room_prices.*', 'booking_hours.serial_number')
                                  ->get();
                            @endphp
                            @foreach ($prices as $price)
                              <li class="radius-sm">
                                <span class="h6 mb-0">{{ symbolPrice($price->price) }}</span>
                                <span class="time">{{ $price->hour }} {{ __('Hrs') }}</span>
                              </li>
                            @endforeach
                          </ul>
                          <div class="mt-15">
                            <button type="button" class="btn btn-primary btn-sm book-now-btn" 
                                    data-room-id="{{ $room->id }}" 
                                    data-room-title="{{ $room->title }}"
                                    data-bs-toggle="modal" 
                                    data-bs-target="#bookingModal">
                              <i class="fal fa-calendar-check me-1"></i>{{ __('Book Now') }}
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                    <!-- product-default -->
                  </div>
                @endforeach
                @foreach ($currentPageData as $room)
                  <div class="col-lg-4 col-md-6">
                    <div class="product-default product-default-style-2 border radius-md mb-25">
                      <figure class="product_img">
                        <a href="javascript:void(0)" 
                           class="room-details-link lazy-container ratio ratio-2-3 radius-sm"
                           data-room-id="{{ $room->id }}"
                           data-room-title="{{ $room->title }}"
                           data-room-slug="{{ $room->slug }}">
                          <img class="lazyload"
                            src="{{ asset('assets/img/room/featureImage/' . $room->feature_image) }}"
                            alt="{{ __('Room Image') }}">
                        </a>
                        @if (Auth::guard('web')->check())
                          @php
                            $user_id = Auth::guard('web')->user()->id;
                            $checkWishList = checkroomWishList($room->id, $user_id);
                          @endphp
                        @else
                          @php
                            $checkWishList = false;
                          @endphp
                        @endif

                        <a href="{{ $checkWishList == false ? route('addto.wishlist.room', $room->id) : route('remove.wishlist.room', $room->id) }}"
                          class="btn btn-icon radius-sm {{ $checkWishList == false ? '' : 'active' }}"
                          data-tooltip="tooltip" data-bs-placement="top"
                          title="{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}">
                          <i class="fal fa-heart"></i>
                        </a>
                        <div class="rank-star">
                          @for ($i = 0; $i < $room->stars; $i++)
                            <i class="fas fa-star"></i>
                          @endfor
                        </div>
                      </figure>
                      <div class="product_details">
                        <div class="p-20">
                          <div class="product_title">
                            <h4 class="title lc-1 mb-0">
                              <a href="{{ route('frontend.room.details', ['slug' => $room->slug, 'id' => $room->id]) }}"
                                target="_self" title="{{ __('Link') }}">{{ $room->title }}</a>
                            </h4>
                          </div>
                          @php
                            $city = null;
                            $State = null;
                            $country = null;

                            if ($room->city_id) {
                                $city = App\Models\Location\City::Where('id', $room->city_id)->first()->name;
                            }
                            if ($room->state_id) {
                                $State = App\Models\Location\State::Where('id', $room->state_id)->first()->name;
                            }
                            if ($room->country_id) {
                                $country = App\Models\Location\Country::Where('id', $room->country_id)->first()->name;
                            }

                          @endphp
                          <div class="list-unstyled mt-10">
                            <li class="icon-start location mb-2">
                              <i class="fal fa-map-marker-alt"></i>
                              <span>
                                {{ @$city }}@if (@$State)
                                  , {{ $State }}
                                  @endif @if (@$country)
                                    , {{ $country }}
                                  @endif
                              </span>
                            </li>
                            <li>
                              <div class="ratings"dir="{{ $currentLanguageInfo->direction == 1 ? 'rtl' : '' }}">
                                <div class="product-ratings rate text-xsm">
                                  <div class="rating" style="width: {{ $room->average_rating * 20 }}%;"></div>
                                </div>
                                <span>
                                  {{ number_format($room->average_rating, 2) }}
                                  ({{ totalRoomReview($room->id) }}
                                  {{ totalRoomReview($room->id) > 1 ? __('Reviews') : __('Review') }})
                                </span>
                              </div>
                            </li>
                          </div>
                          <div class="product_author mt-14">
                            <a class="d-flex align-items-center gap-1"
                              href="{{ route('frontend.hotel.details', ['slug' => $room->hotelSlug, 'id' => $room->hotelId]) }}"
                              target="_self" title="{{ __('Link') }}">
                              <img class="lazyload blur-up"
                                src="{{ asset('assets/img/hotel/logo/' . $room->hotelImage) }}"
                                alt="{{ __('Image') }}">
                              <span class="underline lc-1 font-sm" data-tooltip="tooltip" data-bs-placement="bottom"
                                aria-label="{{ $room->hotelName }}" data-bs-original-title="{{ $room->hotelName }}"
                                aria-describedby="tooltip">
                                {{ $room->hotelName }}
                              </span>
                            </a>
                          </div>
                          @php
                            $amenities = json_decode($room->amenities);
                            $totalAmenities = count($amenities);
                            $displayCount = 5;
                          @endphp

                          <ul class="product-icon_list mt-15 list-unstyled">
                            @foreach ($amenities as $index => $amenitie)
                              @php
                                if ($index >= $displayCount) {
                                    break;
                                }
                                $amin = App\Models\Amenitie::find($amenitie);
                              @endphp
                              <li class="list-item" data-tooltip="tooltip" data-bs-placement="bottom"
                                aria-label="{{ $amin->title }}" data-bs-original-title="{{ $amin->title }}"
                                aria-describedby="tooltip"><i class="{{ $amin->icon }}"></i></li>
                            @endforeach

                            @if ($totalAmenities > $displayCount)
                              <li class="more_item_show_btn">
                                (+{{ $totalAmenities - $displayCount }}<i class="fas fa-ellipsis-h"></i>)
                                <div class="more_items_icons">
                                  @foreach ($amenities as $index => $amenitie)
                                    @php
                                      if ($index < $displayCount) {
                                          continue;
                                      }
                                      $amin = App\Models\Amenitie::find($amenitie);
                                    @endphp
                                    <a data-tooltip="tooltip" data-bs-placement="bottom"
                                      aria-label="{{ $amin->title }}" data-bs-original-title="{{ $amin->title }}"
                                      aria-describedby="tooltip" href="#"><i class="{{ $amin->icon }}"
                                        title="{{ $amin->title }}"></i></a>
                                  @endforeach
                                </div>
                              </li>
                            @endif
                          </ul>
                        </div>
                        <div class="product_bottom pt-20 pb-20 px-10 border-top text-center">
                          <ul class="product-price_list list-unstyled">
                            @php
                              $prices = App\Models\HourlyRoomPrice::where('room_id', $room->id)
                                  ->where('hourly_room_prices.price', '!=', null)
                                  ->join('booking_hours', 'hourly_room_prices.hour_id', '=', 'booking_hours.id')
                                  ->orderBy('booking_hours.serial_number')
                                  ->select('hourly_room_prices.*', 'booking_hours.serial_number')
                                  ->get();

                            @endphp
                            @foreach ($prices as $price)
                              <li class="radius-sm">
                                <span class="h6 mb-0">{{ symbolPrice($price->price) }}</span>
                                <span class="time">{{ $price->hour }} {{ __('Hrs') }}</span>
                              </li>
                            @endforeach
                          </ul>
                          <div class="mt-15">
                            <button type="button" class="btn btn-primary btn-sm book-now-btn" 
                                    data-room-id="{{ $room->id }}" 
                                    data-room-title="{{ $room->title }}"
                                    data-bs-toggle="modal" 
                                    data-bs-target="#bookingModal">
                              <i class="fal fa-calendar-check me-1"></i>{{ __('Book Now') }}
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                    <!-- product-default -->
                  </div>
                @endforeach

              </div>
              <nav class="pagination-nav " data-aos="fade-up">
                <ul class="pagination justify-content-center">
                  @php
                    $totalPages = ceil($room_contents->count() / $perPage);
                  @endphp
                  @if ($totalPages > 1)
                    <li class="page-item disabled">
                      <a class="page-link" aria-label="Previous" tabindex="-1" aria-disabled="true">
                        <i class="far fa-angle-left"></i>
                      </a>
                    </li>
                  @endif
                  @php
                    $totalPages = ceil($room_contents->count() / $perPage);
                  @endphp
                  @if ($room_contents->count() / $perPage > 1)
                    @for ($i = 1; $i <= ceil($room_contents->count() / $perPage); $i++)
                      <li class="page-item @if ($i == 1) active @endif">
                        <a class="page-link" data-page="{{ $i }}">{{ $i }}</a>
                      </li>
                    @endfor
                  @endif
                  @if ($totalPages > 1)
                    <li class="page-item">
                      <a class="page-link" data-page="2" aria-label="Previous">
                        <i class="far fa-angle-right"></i>
                      </a>
                    </li>
                  @endif
                </ul>
              </nav>
            @endif
          </div>
          @if (!empty(showAd(3)))
            <div class="text-center">
              {!! showAd(3) !!}
            </div>
          @endif
        </div>
      </div>
    </div>
  </div>
  <!-- Listing-area end -->

  <form action="{{ route('frontend.rooms') }}" id="searchForm" method="GET">
    <input type="hidden" name="title" id="title"value="{{ request()->input('title') }}">
    <input type="hidden" name="address" id="address"value="{{ request()->input('address') }}">
    <input type="hidden" name="category" id="category"value="{{ request()->input('category') }}">
    <input type="hidden" name="max_val" id="max_val"value="{{ request()->input('max_val') }}">
    <input type="hidden" name="min_val" id="min_val"value="{{ request()->input('min_val') }}">
    <input type="hidden" name="ratings" id="ratings"value="{{ request()->input('ratings') }}">
    <input type="hidden" name="amenitie" id="amenitie"value="{{ request()->input('amenitie') }}">
    <input type="hidden" name="sort" id="sort"value="{{ request()->input('sort') }}">
    <input type="hidden" name="hotelId" id="hotelId"value="{{ request()->input('hotelId') }}">
    <input type="hidden" name="country" id="country"value="{{ request()->input('country') }}">
    <input type="hidden" name="state" id="state"value="{{ request()->input('state') }}">
    <input type="hidden" name="city" id="city"value="{{ request()->input('city') }}">
    <input type="hidden" name="checkInDates" id="checkInDates"value="{{ request()->input('checkInDates') }}">
    <input type="hidden" name="checkInTimes" id="checkInTimes"value="{{ request()->input('checkInTimes') }}">
    <input type="hidden" name="hour" id="hour"value="{{ request()->input('hour') }}">
    <input type="hidden" name="stars" id="stars"value="{{ request()->input('stars') }}">
    <input type="hidden" name="adult" id="adult"value="{{ request()->input('adult') }}">
    <input type="hidden" name="children" id="children"value="{{ request()->input('children') }}">
    <input type="hidden" name="page" id="page"value="">
    <input type="hidden" id="location" name="location" value="{{ request()->input('location') }}">
  </form>
  @include('frontend.partials.map-modal')
  
  <!-- Booking Modal -->
  <div class="modal fade" id="bookingModal" tabindex="-1" aria-labelledby="bookingModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content border-0 shadow-lg">
        <div class="modal-header bg-primary text-white border-0">
          <h5 class="modal-title fw-bold" id="bookingModalLabel">
            <i class="fas fa-calendar-check me-2"></i>{{ __('Book Here') }}
          </h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body p-4">
          <form id="modalRoomCheckoutForm" class="subscription" action="{{ route('frontend.room.go.checkout') }}" method="POST">
            @csrf
            <input type="hidden" name="room_id" id="modal_room_id" value="">
            
            <div class="row g-3 mb-4">
              <div class="col-md-6">
                <div class="form-group">
                  <label for="modalCheckInDate" class="form-label fw-semibold text-dark">
                    <i class="fas fa-calendar-alt me-2 text-primary"></i>{{ __('Start Date') }}
                  </label>
                  <input type="text" class="form-control border-2 border-light rounded-3 shadow-sm" 
                         id="modalCheckInDate" name="checkInDate"
                         value="{{ \Carbon\Carbon::now()->format('m/d/Y') }}"
                         placeholder="MM/DD/YYYY" autocomplete="off" readonly/>
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <label for="modalCheckInTime" class="form-label fw-semibold text-dark">
                    <i class="fas fa-clock me-2 text-primary"></i>{{ __('Start Time') }}
                  </label>
                  <select name="checkInTime" id="modalCheckInTime" class="form-select border-2 border-light rounded-3 shadow-sm" required>
                    <option value="" disabled selected>{{ __('Select Time') }}</option>
                  </select>
                </div>
              </div>
            </div>
            
            <div class="form-group mb-4">
              <label class="form-label fw-semibold text-dark mb-3">
                <i class="fas fa-hourglass-half me-2 text-primary"></i>{{ __('Select Duration') }}
              </label>
              <div class="search-container" id="modalSearchContainer">
                <!-- Hourly prices will be loaded here -->
              </div>
            </div>
            
            <div class="bg-light rounded-4 p-4 mb-4">
              <h6 class="fw-semibold text-dark mb-3">
                <i class="fas fa-users me-2 text-primary"></i>{{ __('Guest Information') }}
              </h6>
              <div class="row g-3">
                <div class="col-md-6">
                  <div class="form-group">
                    <label for="modalAdult" class="form-label fw-medium text-muted">{{ __('Total Adults') }}</label>
                    <select class="form-select border-2 border-light rounded-3 shadow-sm" id="modalAdult" name="adult">
                      <option value="1" selected>1</option>
                      <option value="2">2</option>
                      <option value="3">3</option>
                      <option value="4">4</option>
                    </select>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label for="modalChild" class="form-label fw-medium text-muted">{{ __('Total Children') }}</label>
                    <select class="form-select border-2 border-light rounded-3 shadow-sm" id="modalChild" name="children">
                      <option value="0" selected>0</option>
                      <option value="1">1</option>
                      <option value="2">2</option>
                      <option value="3">3</option>
                    </select>
                  </div>
                </div>
              </div>
            </div>
            
            <div class="modal-footer border-0 pt-0">
              <button type="button" class="btn btn-outline-secondary rounded-3 px-4" data-bs-dismiss="modal">
                <i class="fas fa-times me-2"></i>{{ __('Cancel') }}
              </button>
              <button type="submit" class="btn btn-primary rounded-3 px-4 fw-semibold" aria-label="button">
                <i class="fas fa-calendar-check me-2"></i>{{ __('Book Now') }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  
  <!-- Room Details Modal -->
  <div class="modal fade" id="roomDetailsModal" tabindex="-1" aria-labelledby="roomDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
      <div class="modal-content border-0 shadow-lg">
        <div class="modal-header bg-white border-0">
          <h5 class="modal-title fw-bold text-dark" id="roomDetailsModalLabel">
            <span id="roomModalTitle">{{ __('Room Details') }}</span>
          </h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body p-0">
          <div class="row g-0">
            <!-- Room Images Section -->
            <div class="col-lg-8">
              <div class="room-gallery-container position-relative">
                <div class="swiper room-gallery-swiper">
                  <div class="swiper-wrapper" id="roomGalleryWrapper">
                    <!-- Images will be loaded here -->
                  </div>
                  <!-- Navigation arrows -->
                  <div class="swiper-button-next"></div>
                  <div class="swiper-button-prev"></div>
                  <!-- Expand button -->
                  <button class="btn btn-light btn-sm position-absolute top-0 end-0 m-3" id="expandGallery">
                    <i class="fas fa-expand"></i>
                  </button>
                </div>
                <!-- Thumbnail navigation -->
                <div class="swiper room-thumbnail-swiper mt-3">
                  <div class="swiper-wrapper" id="roomThumbnailWrapper">
                    <!-- Thumbnails will be loaded here -->
                  </div>
                </div>
              </div>
            </div>
            
            <!-- Room Information Section -->
            <div class="col-lg-4">
              <div class="room-info-container p-4 h-100">
                <!-- Room Title and Rating -->
                <div class="room-header mb-4">
                  <h4 class="room-title fw-bold mb-2" id="roomModalTitleText"></h4>
                  <div class="room-rating d-flex align-items-center mb-3">
                    <div class="stars me-2">
                      <i class="fas fa-star text-warning"></i>
                      <i class="fas fa-star text-warning"></i>
                      <i class="fas fa-star text-warning"></i>
                      <i class="fas fa-star text-warning"></i>
                      <i class="fas fa-star text-warning"></i>
                    </div>
                    <span class="rating-text text-muted" id="roomModalRating"></span>
                  </div>
                </div>
                
                <!-- Room Details -->
                <div class="room-details mb-4">
                  <h6 class="fw-semibold mb-3">{{ __('Room Details') }}</h6>
                  <div class="row g-3">
                    <div class="col-6">
                      <div class="detail-item">
                        <i class="fas fa-bed text-primary me-2"></i>
                        <span id="roomModalBeds"></span>
                      </div>
                    </div>
                    <div class="col-6">
                      <div class="detail-item">
                        <i class="fas fa-bath text-primary me-2"></i>
                        <span id="roomModalBathrooms"></span>
                      </div>
                    </div>
                    <div class="col-6">
                      <div class="detail-item">
                        <i class="fas fa-users text-primary me-2"></i>
                        <span id="roomModalGuests"></span>
                      </div>
                    </div>
                    <div class="col-6">
                      <div class="detail-item">
                        <i class="fas fa-ruler-combined text-primary me-2"></i>
                        <span id="roomModalArea"></span>
                      </div>
                    </div>
                  </div>
                </div>
                
                <!-- Location -->
                <div class="room-location mb-4">
                  <h6 class="fw-semibold mb-3">{{ __('Location') }}</h6>
                  <div class="location-item">
                    <i class="fas fa-map-marker-alt text-primary me-2"></i>
                    <span id="roomModalLocation"></span>
                  </div>
                </div>
                
                <!-- Amenities -->
                <div class="room-amenities mb-4">
                  <h6 class="fw-semibold mb-3">{{ __('Amenities') }}</h6>
                  <div class="amenities-grid" id="roomModalAmenities">
                    <!-- Amenities will be loaded here -->
                  </div>
                </div>
                
                <!-- Pricing -->
                <div class="room-pricing mb-4">
                  <h6 class="fw-semibold mb-3">{{ __('Pricing') }}</h6>
                  <div class="pricing-options" id="roomModalPricing">
                    <!-- Pricing options will be loaded here -->
                  </div>
                </div>
                
                <!-- Action Buttons -->
                <div class="room-actions">
                  <button type="button" class="btn btn-primary w-100 mb-2" id="bookThisRoom">
                    <i class="fas fa-calendar-check me-2"></i>{{ __('Book This Room') }}
                  </button>
                  <button type="button" class="btn btn-outline-secondary w-100" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>{{ __('Close') }}
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
@endsection
@section('script')
  <!-- Map JS -->
  @if ($basicInfo->google_map_api_key_status == 1)
    <script
      src="https://maps.googleapis.com/maps/api/js?key={{ $basicInfo->google_map_api_key }}&libraries=places&callback=initMap"
      async defer></script>
    <script src="{{ asset('assets/front/js/api-search-2.js') }}"></script>
  @endif
  <script src="{{ asset('assets/front/js/map-room.js') }}"></script>
  <script>
    "use strict";
    var featured_contents = {!! json_encode($featured_contents) !!};
    var room_contents = {!! json_encode($currentPageData) !!};
    var searchUrl = "{{ route('frontend.search_room') }}";
    var getStateUrl = "{{ route('frontend.hotels.get-state') }}";
    var getCityUrl = "{{ route('frontend.hotels.get-city') }}";
    var getAddress = "{{ route('frontend.rooms.get-address') }}";
  </script>
  <script src="{{ asset('assets/front/js/room-search.js') }}"></script>
  
  <!-- Custom CSS for Booking Modal -->
  <style>
    .modal-content {
      border-radius: 1rem !important;
    }
    
    .modal-header {
      border-radius: 1rem 1rem 0 0 !important;
    }
    
    .form-control:focus, .form-select:focus {
      border-color: #0d6efd !important;
      box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25) !important;
    }
    
    /* Style for price options */
    .search-container .product-price_list {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
      gap: 0.75rem;
      margin: 0;
      padding: 0;
    }
    
    .search-container .product-price_list li {
      background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
      border: 2px solid #e9ecef;
      border-radius: 1rem;
      padding: 1.25rem 1rem;
      margin: 0;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      cursor: pointer;
      position: relative;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }
    
    .search-container .product-price_list li::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 3px;
      background: linear-gradient(90deg, #0d6efd, #6f42c1);
      transform: scaleX(0);
      transition: transform 0.3s ease;
    }
    
    .search-container .product-price_list li:hover {
      border-color: #0d6efd;
      background: linear-gradient(135deg, #f0f8ff 0%, #e3f2fd 100%);
      transform: translateY(-3px);
      box-shadow: 0 8px 25px rgba(13, 110, 253, 0.15);
    }
    
    .search-container .product-price_list li:hover::before {
      transform: scaleX(1);
    }
    
    .search-container .product-price_list li input[type="radio"] {
      position: absolute;
      opacity: 0;
    }
    
    .search-container .product-price_list li input[type="radio"]:checked + label {
      color: #0d6efd;
    }
    
    .search-container .product-price_list li input[type="radio"]:checked + label .qty {
      color: #0d6efd;
      font-weight: 700;
    }
    
    .search-container .product-price_list li input[type="radio"]:checked {
      background-color: #0d6efd;
    }
    
    .search-container .product-price_list li label {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin: 0;
      cursor: pointer;
      font-weight: 600;
      font-size: 0.95rem;
    }
    
    .search-container .product-price_list li label span:first-child {
      color: #495057;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }
    
    .search-container .product-price_list li label span:first-child::before {
      content: '⏱️';
      font-size: 1.1rem;
    }
    
    .search-container .product-price_list li label .qty {
      color: #6c757d;
      font-size: 1rem;
      font-weight: 600;
      background: rgba(13, 110, 253, 0.1);
      padding: 0.25rem 0.75rem;
      border-radius: 0.5rem;
      border: 1px solid rgba(13, 110, 253, 0.2);
    }
    
    .search-container .product-price_list li.selected {
      border-color: #0d6efd;
      background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(13, 110, 253, 0.2);
    }
    
    .search-container .product-price_list li.selected::before {
      transform: scaleX(1);
    }
    
    .search-container .product-price_list li.selected label .qty {
      background: #0d6efd;
      color: white;
      border-color: #0d6efd;
    }
    
    /* Loading state */
    .search-container .loading {
      text-align: center;
      padding: 2rem;
      color: #6c757d;
    }
    
    .search-container .loading i {
      font-size: 2rem;
      margin-bottom: 1rem;
      color: #0d6efd;
    }
    
    /* Error state */
    .search-container .error {
      text-align: center;
      padding: 2rem;
      color: #dc3545;
      background: #f8d7da;
      border-radius: 0.5rem;
    }
    
    /* Success badge */
    .badge.bg-success {
      background-color: #198754 !important;
      font-size: 0.75rem;
      padding: 0.25rem 0.5rem;
    }
    
    /* Room Details Modal Styles */
    .room-gallery-container {
      background: #f8f9fa;
      border-radius: 0.5rem;
      overflow: hidden;
    }
    
    .room-gallery-swiper {
      height: 400px;
    }
    
    .room-gallery-swiper .swiper-slide {
      background: #fff;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    
    .room-gallery-swiper .swiper-slide img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    
    .room-thumbnail-swiper {
      height: 80px;
    }
    
    .room-thumbnail-swiper .swiper-slide {
      cursor: pointer;
      border: 2px solid transparent;
      border-radius: 0.5rem;
      overflow: hidden;
      transition: all 0.3s ease;
    }
    
    .room-thumbnail-swiper .swiper-slide img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    
    .room-thumbnail-swiper .swiper-slide-thumb-active {
      border-color: #0d6efd;
    }
    
    .room-info-container {
      background: #fff;
      border-left: 1px solid #e9ecef;
    }
    
    .detail-item {
      display: flex;
      align-items: center;
      font-size: 0.9rem;
      color: #6c757d;
    }
    
    .location-item {
      display: flex;
      align-items: center;
      font-size: 0.9rem;
      color: #6c757d;
    }
    
    .amenities-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 0.5rem;
    }
    
    .amenity-item {
      display: flex;
      align-items: center;
      font-size: 0.85rem;
      color: #6c757d;
      padding: 0.25rem 0;
    }
    
    .amenity-item i {
      margin-right: 0.5rem;
      color: #0d6efd;
      width: 16px;
    }
    
    .pricing-options {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
    }
    
    .pricing-option {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0.75rem;
      background: #f8f9fa;
      border-radius: 0.5rem;
      border: 1px solid #e9ecef;
      transition: all 0.3s ease;
    }
    
    .pricing-option:hover {
      background: #e9ecef;
      border-color: #0d6efd;
    }
    
    .pricing-option .duration {
      font-weight: 600;
      color: #495057;
    }
    
    .pricing-option .price {
      font-weight: 700;
      color: #0d6efd;
      font-size: 1.1rem;
    }
    
    /* Make room cards clickable */
    .room-details-link {
      cursor: pointer;
      transition: all 0.3s ease;
    }
    
    .room-details-link:hover {
      opacity: 0.8;
    }
  </style>
  
  <!-- Room Details Modal JavaScript -->
  <script>
    // Initialize room details modal functionality
    document.addEventListener('DOMContentLoaded', function() {
      // Handle room details link clicks
      document.addEventListener('click', function(e) {
        if (e.target.closest('.room-details-link')) {
          e.preventDefault();
          const link = e.target.closest('.room-details-link');
          const roomId = link.getAttribute('data-room-id');
          const roomTitle = link.getAttribute('data-room-title');
          const roomSlug = link.getAttribute('data-room-slug');
          
          loadRoomDetails(roomId, roomTitle, roomSlug);
        }
      });
      
      // Handle "Book This Room" button click
      document.getElementById('bookThisRoom').addEventListener('click', function() {
        const roomId = this.getAttribute('data-room-id');
        if (roomId) {
          // Close room details modal
          const roomDetailsModal = bootstrap.Modal.getInstance(document.getElementById('roomDetailsModal'));
          roomDetailsModal.hide();
          
          // Set room ID in booking modal
          document.getElementById('modal_room_id').value = roomId;
          document.getElementById('bookingModalLabel').textContent = `Book Here - ${this.getAttribute('data-room-title')}`;
          
          // Show booking modal
          const bookingModal = new bootstrap.Modal(document.getElementById('bookingModal'));
          bookingModal.show();
          
          // Load initial booking data
          loadRoomBookingData(roomId, document.getElementById('modalCheckInDate').value);
        }
      });
      
      // Function to load room details
      function loadRoomDetails(roomId, roomTitle, roomSlug) {
        // Show loading state
        document.getElementById('roomModalTitle').textContent = 'Loading...';
        
        // Fetch room details via AJAX
        fetch(`/room/${roomSlug}/${roomId}/details-data`)
          .then(response => response.json())
          .then(data => {
            populateRoomDetails(data, roomTitle);
            
            // Show the modal
            const roomDetailsModal = new bootstrap.Modal(document.getElementById('roomDetailsModal'));
            roomDetailsModal.show();
            
            // Initialize Swiper for gallery
            initializeRoomGallery();
          })
          .catch(error => {
            console.error('Error loading room details:', error);
            // Fallback: show basic modal with available data
            showBasicRoomDetails(roomId, roomTitle);
          });
      }
      
      // Function to populate room details
      function populateRoomDetails(data, roomTitle) {
        // Set modal title
        document.getElementById('roomModalTitle').textContent = roomTitle;
        document.getElementById('roomModalTitleText').textContent = roomTitle;
        
        // Set room details
        document.getElementById('roomModalBeds').textContent = data.beds || 'N/A';
        document.getElementById('roomModalBathrooms').textContent = data.bathrooms || 'N/A';
        document.getElementById('roomModalGuests').textContent = data.guests || 'N/A';
        document.getElementById('roomModalArea').textContent = data.area || 'N/A';
        document.getElementById('roomModalLocation').textContent = data.location || 'N/A';
        document.getElementById('roomModalRating').textContent = data.rating || 'N/A';
        
        // Populate gallery
        populateGallery(data.images || []);
        
        // Populate amenities
        populateAmenities(data.amenities || []);
        
        // Populate pricing
        populatePricing(data.pricing || []);
        
        // Set data for booking button
        document.getElementById('bookThisRoom').setAttribute('data-room-id', data.id);
        document.getElementById('bookThisRoom').setAttribute('data-room-title', roomTitle);
      }
      
      // Function to populate gallery
      function populateGallery(images) {
        const galleryWrapper = document.getElementById('roomGalleryWrapper');
        const thumbnailWrapper = document.getElementById('roomThumbnailWrapper');
        
        galleryWrapper.innerHTML = '';
        thumbnailWrapper.innerHTML = '';
        
        images.forEach((image, index) => {
          // Main gallery slide
          const slide = document.createElement('div');
          slide.className = 'swiper-slide';
          slide.innerHTML = `<img src="${image.url}" alt="Room Image ${index + 1}">`;
          galleryWrapper.appendChild(slide);
          
          // Thumbnail slide
          const thumbSlide = document.createElement('div');
          thumbSlide.className = 'swiper-slide';
          thumbSlide.innerHTML = `<img src="${image.thumbnail || image.url}" alt="Thumbnail ${index + 1}">`;
          thumbnailWrapper.appendChild(thumbSlide);
        });
      }
      
      // Function to populate amenities
      function populateAmenities(amenities) {
        const amenitiesContainer = document.getElementById('roomModalAmenities');
        amenitiesContainer.innerHTML = '';
        
        amenities.forEach(amenity => {
          const amenityItem = document.createElement('div');
          amenityItem.className = 'amenity-item';
          amenityItem.innerHTML = `<i class="${amenity.icon}"></i><span>${amenity.title}</span>`;
          amenitiesContainer.appendChild(amenityItem);
        });
      }
      
      // Function to populate pricing
      function populatePricing(pricing) {
        const pricingContainer = document.getElementById('roomModalPricing');
        pricingContainer.innerHTML = '';
        
        pricing.forEach(price => {
          const pricingOption = document.createElement('div');
          pricingOption.className = 'pricing-option';
          pricingOption.innerHTML = `
            <span class="duration">${price.duration}</span>
            <span class="price">${price.price}</span>
          `;
          pricingContainer.appendChild(pricingOption);
        });
      }
      
      // Function to initialize Swiper gallery
      function initializeRoomGallery() {
        // Initialize main gallery
        const gallerySwiper = new Swiper('.room-gallery-swiper', {
          spaceBetween: 10,
          navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
          },
          thumbs: {
            swiper: {
              el: '.room-thumbnail-swiper',
              spaceBetween: 10,
              slidesPerView: 4,
              freeMode: true,
              watchSlidesProgress: true,
            }
          }
        });
      }
      
      // Fallback function for basic room details
      function showBasicRoomDetails(roomId, roomTitle) {
        document.getElementById('roomModalTitle').textContent = roomTitle;
        document.getElementById('roomModalTitleText').textContent = roomTitle;
        
        // Set basic info
        document.getElementById('roomModalBeds').textContent = '2 Beds';
        document.getElementById('roomModalBathrooms').textContent = '1 Bathroom';
        document.getElementById('roomModalGuests').textContent = '4 Guests';
        document.getElementById('roomModalArea').textContent = '500 sq ft';
        document.getElementById('roomModalLocation').textContent = 'City Center';
        document.getElementById('roomModalRating').textContent = '4.5 (25 reviews)';
        
        // Set data for booking button
        document.getElementById('bookThisRoom').setAttribute('data-room-id', roomId);
        document.getElementById('bookThisRoom').setAttribute('data-room-title', roomTitle);
        
        // Show the modal
        const roomDetailsModal = new bootstrap.Modal(document.getElementById('roomDetailsModal'));
        roomDetailsModal.show();
      }
    });
  </script>
  
  <!-- Booking Modal JavaScript -->
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const bookingModal = document.getElementById('bookingModal');
      const modalRoomId = document.getElementById('modal_room_id');
      const modalCheckInDate = document.getElementById('modalCheckInDate');
      const modalCheckInTime = document.getElementById('modalCheckInTime');
      const modalSearchContainer = document.getElementById('modalSearchContainer');
      const modalRoomCheckoutForm = document.getElementById('modalRoomCheckoutForm');
      
      // Handle Book Now button clicks
      document.querySelectorAll('.book-now-btn').forEach(button => {
        button.addEventListener('click', function() {
          const roomId = this.getAttribute('data-room-id');
          const roomTitle = this.getAttribute('data-room-title');
          
          // Set room ID in modal
          modalRoomId.value = roomId;
          
          // Update modal title
          document.getElementById('bookingModalLabel').textContent = `Book Here - ${roomTitle}`;
          
          // Load initial data for the room
          loadRoomBookingData(roomId, modalCheckInDate.value);
        });
      });
      
      // Handle date change in modal
      modalCheckInDate.addEventListener('change', function() {
        const roomId = modalRoomId.value;
        if (roomId) {
          loadRoomBookingData(roomId, this.value);
        }
      });
      
      // Handle time change in modal
      modalCheckInTime.addEventListener('change', function() {
        const roomId = modalRoomId.value;
        const date = modalCheckInDate.value;
        if (roomId && date) {
          loadHourlyPrices(roomId, date);
        }
      });
      
      // Function to load room booking data
      function loadRoomBookingData(roomId, date) {
        // Load time slots
        loadTimeSlots(roomId, date);
        
        // Clear hourly prices until time is selected
        modalSearchContainer.innerHTML = '<div class="text-center py-4"><i class="fas fa-clock text-primary mb-2" style="font-size: 2rem;"></i><p class="text-muted mb-0">{{ __("Please select a time to see available durations") }}</p></div>';
      }
      
      // Function to load time slots
      function loadTimeSlots(roomId, date) {
        // This would typically make an AJAX call to get time slots
        // For now, we'll populate with basic time slots
        const timeSlots = [
          '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM',
          '12:00 PM', '12:30 PM', '1:00 PM', '1:30 PM', '2:00 PM', '2:30 PM',
          '3:00 PM', '3:30 PM', '4:00 PM', '4:30 PM', '5:00 PM', '5:30 PM',
          '6:00 PM', '6:30 PM', '7:00 PM', '7:30 PM', '8:00 PM', '8:30 PM'
        ];
        
        modalCheckInTime.innerHTML = '<option value="" disabled selected>{{ __("Select Time") }}</option>';
        timeSlots.forEach(time => {
          const option = document.createElement('option');
          option.value = time;
          option.textContent = time;
          modalCheckInTime.appendChild(option);
        });
      }
      
      // Function to load hourly prices
      function loadHourlyPrices(roomId, date) {
        const url = `{{ route('frontend.room.details.get_hourly_price', ['slug' => ':slug', 'id' => ':id']) }}`;
        const searchUrl = url.replace(':slug', 'room').replace(':id', roomId);
        
        // Get the selected time
        const selectedTime = modalCheckInTime.value;
        if (!selectedTime) {
          modalSearchContainer.innerHTML = '<div class="text-muted text-center py-4"><i class="fas fa-info-circle me-2"></i>{{ __("Please select a time first") }}</div>';
          return;
        }
        
        // Show loading state
        modalSearchContainer.innerHTML = '<div class="loading"><i class="fas fa-spinner fa-spin"></i><p>{{ __("Loading available durations...") }}</p></div>';
        
        fetch(`${searchUrl}?checkInDates=${date}&checkInTime=${selectedTime}`)
          .then(response => response.text())
          .then(html => {
            modalSearchContainer.innerHTML = html;
            
            // Add click handlers for price options
            const priceOptions = modalSearchContainer.querySelectorAll('.product-price_list li');
            priceOptions.forEach(option => {
              option.addEventListener('click', function() {
                // Remove selected class from all options
                priceOptions.forEach(opt => opt.classList.remove('selected'));
                // Add selected class to clicked option
                this.classList.add('selected');
                // Check the radio button
                const radio = this.querySelector('input[type="radio"]');
                if (radio) {
                  radio.checked = true;
                }
              });
            });
          })
          .catch(error => {
            console.error('Error loading hourly prices:', error);
            modalSearchContainer.innerHTML = '<div class="error"><i class="fas fa-exclamation-triangle me-2"></i>{{ __("Error loading prices. Please try again.") }}</div>';
          });
      }
      
      // Handle form submission
      modalRoomCheckoutForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        if (!modalCheckInDate.value || !modalCheckInTime.value) {
          alert('{{ __("Please select both date and time") }}');
          return false;
        }
        
        // Check if a price option is selected
        const selectedPrice = document.querySelector('#modalSearchContainer input[name="price"]:checked');
        if (!selectedPrice) {
          alert('{{ __("Please select a duration") }}');
          return false;
        }
        
        // Submit form via AJAX
        const formData = new FormData(modalRoomCheckoutForm);
        
        fetch(modalRoomCheckoutForm.action, {
          method: 'POST',
          body: formData,
          headers: {
            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          }
        })
        .then(response => response.json())
        .then(data => {
          if (data.redirect_url) {
            window.location.href = data.redirect_url;
          } else {
            alert('{{ __("An error occurred. Please try again.") }}');
          }
        })
        .catch(error => {
          console.error('Error:', error);
          alert('{{ __("An error occurred. Please try again.") }}');
        });
      });
      
      // Initialize datepicker for modal if available
      if (typeof $.fn.datepicker !== 'undefined') {
        $('#modalCheckInDate').datepicker({
          format: 'mm/dd/yyyy',
          autoclose: true,
          todayHighlight: true,
          startDate: new Date()
        }).on('changeDate', function() {
          const roomId = modalRoomId.value;
          if (roomId) {
            loadRoomBookingData(roomId, this.value);
          }
        });
      }
    });
  </script>
@endsection
