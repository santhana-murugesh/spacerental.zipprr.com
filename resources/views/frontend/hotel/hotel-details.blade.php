@extends('frontend.layout')

@section('pageHeading')
  {{ $hotel->title }}
@endsection

@section('metaKeywords')
  @if (!empty($hotel))
    {{ $hotel->meta_keyword }}
  @endif
@endsection

@section('metaDescription')
  @if (!empty($hotel))
    {{ $hotel->meta_description }}
  @endif
@endsection

@section('ogTitle')
  @if (!empty($hotel))
    {{ $hotel->title }}
  @endif
@endsection

@section('content')
  <!-- Page title start-->
  @includeIf('frontend.partials.breadcrumb', [
      'breadcrumb' => $bgImg->breadcrumb,
      'title' => strlen(@$hotel->title) > 35 ? mb_substr(@$hotel->title, 0, 35, 'utf-8') . '...' : @$hotel->title,
  ])
  <!-- Page title end-->

  <!-- Hotel-details-area start -->
  <div class="hotel-details-area pt-100 pb-60">
    <div class="container">
      <!-- Hotel Info -->
      <div class="row gx-xl-5 mb-30" data-aos="fade-up">

        <div class="col-lg-6">
          <div class="hotel-info mb-30">
            <figure class="hotel_img">

              <img class="lazyload rounded-circle" src="assets/images/placeholder.png"
                data-src="{{ asset('assets/img/hotel/logo/' . $hotel->logo) }}
                " alt="{{ __('Hotel') }}">
            </figure>
            <div class="hotel-info_details">
              <span class="hotel_subtitle d-inline-block fw-medium">
                <a href="{{ route('frontend.hotels', ['category' => $hotel->categorySlug]) }}" target="_self"
                  title="{{ __('Link') }}">{{ $hotel->categoryName }}</a>
              </span>
              <h3 class="hotel_title mb-10">
                {{ $hotel->title }}
              </h3>
              <div class="d-flex flex-wrap row-gap-2 column-gap-2">
                <div class="vendore_author pe-2 border-end">
                  <a href="{{ route('frontend.vendor.details', ['username' => $userName]) }}" target="_self"
                    title="{{ __('Link') }}">

                    @if ($hotel->vendor_id == 0)
                      <img class="ls-is-cached lazyloaded" src="{{ asset('assets/img/admins/' . $vendor->image) }}"
                        alt="{{ __('Vendor') }}">
                    @else
                      @if ($vendor->photo)
                        <img class="ls-is-cached lazyloaded"
                          src="{{ asset('assets/admin/img/vendor-photo/' . $vendor->photo) }}"
                          alt="{{ __('Vendor') }}">
                      @else
                        <img class="ls-is-cached lazyloaded" src="{{ asset('assets/front/images/avatar-1.jpg') }}"
                          alt="{{ __('Vendor') }}">
                      @endif
                    @endif
                    <span class="font-sm">{{ __('By') }} {{ $userName }}</span>
                  </a>
                </div>
                <div class="rank-star d-flex align-items-center flex-wrap gap-2 mb-0 ">
                  <div class="icons">
                    <i class="fas fa-star"></i>
                  </div>
                  <span class="fw-semibold text-nowrap">{{ $hotel->stars }} {{ __('Star') }}</span>
                </div>
              </div>
            </div>
          </div>

        </div>

        <div class="col-lg-6">
          <div class="hotel-info_right mb-lg-0 mb-lg-30">
            @if (count($hotelCounters) > 0)
              <ul class="hotel-info_list list-unstyled p-20 border radius-md">
                @foreach ($hotelCounters as $hotelCounter)
                  <li>
                    <span class="h3 mb-1">{{ $hotelCounter->value }}</span>
                    <span>{{ $hotelCounter->label }}</span>
                  </li>
                @endforeach
              </ul>
            @endif

            <ul class="hotel-share_list list-unstyled mt-20">

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


              <li class="ratings flex-nowrap" dir="{{ $currentLanguageInfo->direction == 1 ? 'rtl' : '' }}">
                <div class="product-ratings rate text-xsm">
                  <div class="rating" style="width: {{ $hotel->average_rating * 20 }}%;"></div>
                </div>
                <p class="text-nowrap">{{ number_format($hotel->average_rating, 2) }}
                  ({{ totalHotelReview($hotel->id) }}
                  {{ __('Reviews') }})
                </p>
              </li>


              <li>
                <a class="btn-icon-text radius-sm {{ $checkWishList == false ? '' : 'active' }}"
                  href="{{ $checkWishList == false ? route('addto.wishlist.hotel', $hotel->id) : route('remove.wishlist.hotel', $hotel->id) }}"
                  target="_self" title="{{ __('Link') }}">
                  <i class="fal fa-bookmark"></i>
                  <span>{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}</span>
                </a>
              </li>
              <li>
                <a class="btn-icon-text radius-sm" href="#" data-bs-toggle="modal"
                  data-bs-target="#socialMediaModal">
                  <i class="fal fa-share-alt"></i>
                  <span>{{ __('Share Hotel') }}</span>
                </a>
              </li>
            </ul>

          </div>
        </div>
      </div>
      <!-- Hotel Details -->
      <div class="hotel-single-details" data-aos="fade-up">
        <!-- Product description -->
        <div class="hotel-desc">

          <!-- Hotel gallery -->
          <div class="hotel-gallery mb-20">
            <h3 class="title mb-20">{{ __('Gallery') }}</h3>
            <div class="row gallery-popup">
              <div class="col-lg-10">
                <!-- Start product-slider wrapper -->
                <div class="product-slider-style2-wrapper">
                  <!-- Start product-slider -->
                  <div class="swiper product-slider-style2 radius-md">
                    <div class="swiper-wrapper">
                      @foreach ($hotelImages as $gallery)
                        <div class="swiper-slide product-slider-item">
                          <figure class="lazy-container ratio ratio-5-3">
                            <a href="{{ asset('assets/img/hotel/hotel-gallery/' . $gallery->image) }}"
                              class="lightbox-single">
                              <img class="lazyload"
                                src="{{ asset('assets/img/hotel/hotel-gallery/' . $gallery->image) }}"
                                data-src="{{ asset('assets/img/hotel/hotel-gallery/' . $gallery->image) }}"
                                alt="{{ __('hotel image') }}">
                            </a>
                          </figure>
                        </div>
                      @endforeach
                    </div>
                    <div class="product-slider-button-prev slider-btn"><i class="fal fa-angle-left"></i></div>
                    <div class="product-slider-button-next slider-btn"><i class="fal fa-angle-right"></i></div>
                  </div>

                  <!-- product-slider-style2-thumb -->
                  <div thumbsSlider="" class="swiper product-slider-style2-thumb">
                    <div class="swiper-wrapper">
                      @foreach ($hotelImages as $gallery)
                        <div class="swiper-slide product-slider-thumb-item">
                          <img class="lazyload" src="{{ asset('assets/img/hotel/hotel-gallery/' . $gallery->image) }}"
                            alt="Image">
                        </div>
                      @endforeach
                    </div>
                  </div>
                  <!-- End product-slider -->
                </div>
              </div>
            </div>
          </div>

          <div class="tinymce-content">
            {!! optional($hotel)->description !!}
          </div>
        </div>
        @if ($hotel->amenities != '[]')
          <div class="row">
            <div class="col-lg-10">
              <div class="pt-60 pb-60">
                <div class="product-amenities aos-init aos-animate" data-aos="fade-up">
                  <h3 class="title mb-20">{{ __('Amenities') }}</h3>
                  <ul class="amenities-list list-unstyled p-20 radius-md border">
                    @php
                      $amenities = json_decode($hotel->amenities);
                    @endphp
                    @foreach ($amenities as $amenitie)
                      @php
                        $amin = App\Models\Amenitie::find($amenitie);
                      @endphp
                      <li class="icon-start">
                        <i class="{{ $amin->icon }}"></i>
                        <span>{{ $amin->title }}</span>
                      </li>
                    @endforeach
                  </ul>
                </div>
              </div>
            </div>
          </div>
        @endif

        <!-- Rooms Section -->
        @if (count($rooms) > 0)
          <div class="row">
            <div class="col-lg-10">
              <div class="hotel-rooms-section pt-60 pb-60" data-aos="fade-up">
                <div class="section-title title-inline mb-30">
                  <h3 class="title">{{ __('Available Rooms') }}</h3>
                  <span class="badge bg-primary ms-2">{{ count($rooms) }} {{ __('Rooms') }}</span>
                </div>
                
                   <div class="rooms-grid">
                  @foreach($rooms as $room)
                    @php
                      $roomContent = $room->room_content && $room->room_content->first() ? $room->room_content->first() : null;
                      $roomAmenities = [];
                      $roomAmenitiesCount = 0;
                      if ($roomContent) {
                          $roomAmenities = json_decode($roomContent->amenities ?? '[]');
                          $roomAmenitiesCount = count($roomAmenities);
                      }
                    @endphp
                    <div class="room-card border radius-md p-20 mb-20">
                      <div class="row align-items-center">
                        <!-- Room Image -->
                        <div class="col-md-3">
                          <div class="room-image position-relative" style="cursor: pointer;">
                            @if($room->feature_image)
                              @php
                                $roomGalleryImages = $room->room_galleries;
                                $galleryImageUrls = [];
                                if($roomGalleryImages && count($roomGalleryImages) > 0) {
                                    foreach($roomGalleryImages as $galleryImage) {
                                        \Log::info('Gallery Image: ' . $galleryImage->image);
                                        $galleryImagePath = public_path('assets/img/room/room-gallery/' . $galleryImage->image);
                                        if(file_exists($galleryImagePath)) {
                                            $galleryImageUrls[] = asset('assets/img/room/room-gallery/' . $galleryImage->image);
                                        } else {
                                            \Log::warning('Gallery image file not found: ' . $galleryImagePath);
                                        }
                                    }
                                }
                                if(empty($galleryImageUrls)) {
                                    $galleryImageUrls[] = asset('assets/img/room/featureImage/' . $room->feature_image);
                                }
                                $imageCount = count($galleryImageUrls);
                                
                                // Debug: Log gallery images
                                \Log::info('Room ID: ' . $room->id);
                                \Log::info('Gallery Images Count: ' . ($roomGalleryImages ? count($roomGalleryImages) : 0));
                                
                                // Debug: Also log to browser console
                                echo "<script>console.log('Room ID: " . $room->id . "');</script>";
                                echo "<script>console.log('Feature Image: " . $room->feature_image . "');</script>";
                                echo "<script>console.log('Gallery Images: " . json_encode($galleryImageUrls) . "');</script>";
                                echo "<script>console.log('Gallery Images Count: " . count($galleryImageUrls) . "');</script>";
                                
                                // Test if feature image exists
                                $featureImagePath = public_path('assets/img/room/featureImage/' . $room->feature_image);
                                echo "<script>console.log('Feature Image Path: " . $featureImagePath . "');</script>";
                                echo "<script>console.log('Feature Image Exists: " . (file_exists($featureImagePath) ? 'Yes' : 'No') . "');</script>";
                              @endphp
                              <img src="{{ asset('assets/img/room/featureImage/' . $room->feature_image) }}"
                                   alt="{{ $roomContent ? $roomContent->title : 'Room' }}"
                                   class="img-fluid rounded room-image-clickable" 
                                   style="width: 100%; height: 120px; object-fit: cover;"
                                   data-room-id="{{ $room->id }}" 
                                   data-room-title="{{ $roomContent ? $roomContent->title : 'Room' }}"
                                   data-room-image="{{ asset('assets/img/room/featureImage/' . $room->feature_image) }}"
                                   data-room-gallery="{{ json_encode($galleryImageUrls) }}"
                                   data-room-bed="{{ $room->bed }}"
                                   data-room-bathroom="{{ $room->bathroom }}"
                                   data-room-area="{{ $room->area }}"
                                   data-room-amenities="{{ json_encode($roomAmenities) }}"
                                   data-bs-toggle="modal" 
                                   data-bs-target="#roomDetailsModal">
                              <div class="position-absolute bottom-0 end-0 bg-dark bg-opacity-75 text-white px-2 py-1 rounded-top-start" style="font-size: 0.75rem;">
                                <i class="fas fa-images me-1"></i>{{ $imageCount }}
                              </div>
                            @else
                              <div class="placeholder-image bg-light rounded d-flex align-items-center justify-content-center"
                                   style="width: 100%; height: 120px;">
                                <i class="fas fa-bed fa-2x text-muted"></i>
                              </div>
                            @endif
                          </div>
                        </div>
                        
                        <!-- Room Details -->
                        <div class="col-md-6">
                          <div class="room-details">
                            <h5 class="room-title mb-2 fw-bold">
                              <span>{{ $roomContent ? $roomContent->title : 'Room' }}</span>
                            </h5>
                            
                            <!-- Room Amenities -->
                            @if($roomAmenitiesCount > 0)
                              <div class="room-amenities mb-2">
                                @foreach(array_slice($roomAmenities, 0, 4) as $amenityId)
                                  @php
                                    $amenity = App\Models\Amenitie::find($amenityId);
                                  @endphp
                                  @if($amenity)
                                    <span class="badge bg-light text-dark me-1" title="{{ $amenity->title }}">
                                      <i class="{{ $amenity->icon }} text-primary me-1"></i>
                                      {{ $amenity->title }}
                                    </span>
                                  @endif
                                @endforeach
                                @if($roomAmenitiesCount > 4)
                                  <span class="badge bg-secondary">+{{ $roomAmenitiesCount - 4 }} more</span>
                                @endif
                              </div>
                            @endif
                            
                            <!-- Room Features -->
                            <div class="room-features text-muted small">
                              @if($room->bed)
                                <span class="me-3"><i class="fas fa-bed me-1"></i>{{ $room->bed }} {{ __('Beds') }}</span>
                              @endif
                              @if($room->bathroom)
                                <span class="me-3"><i class="fas fa-bath me-1"></i>{{ $room->bathroom }} {{ __('Bathrooms') }}</span>
                              @endif
                              @if($room->area)
                                <span><i class="fas fa-ruler-combined me-1"></i>{{ $room->area }} {{ __('sq ft') }}</span>
                              @endif
                            </div>
                          </div>
                        </div>
                        
                        <!-- Room Pricing and Action -->
                        <div class="col-md-3">
                          <div class="room-pricing text-end">
                            <button type="button" class="btn btn-primary book-now-btn" 
                                    data-room-id="{{ $room->id }}" 
                                    data-room-title="{{ $roomContent ? $roomContent->title : 'Room' }}"
                                    data-bs-toggle="modal" 
                                    data-bs-target="#bookingModal">
                              <i class="fal fa-calendar-check me-1"></i>{{ __('Book Now') }}
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  @endforeach
                </div>
              </div>
            </div>
          </div>
        @endif

        <div class="row">
          <div class="col-lg-10">
            <div class="hotel-location pb-90 aos-init aos-animate" data-aos="fade-up">
              <h3 class="title mb-20">{{ __('Location') }}</h3>
              <div class="p-20 radius-md border">

                <p class=" mb-10">
                  <i class="fal fa-map-marker-alt"></i>
                  <span>
                    {{ $hotel->address }}
                  </span>
                </p>
                <p class=" mb-20">
                  <i class="fas fa-city"></i>
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
                  <span>
                    {{ @$city }}@if (@$State)
                      , {{ $State }}
                      @endif @if (@$country)
                        , {{ $country }}
                      @endif
                  </span>
                </p>
                <div class="lazy-container radius-md ratio ratio-21-8">
                    <div id="map"></div>
                </div>
              </div>
            </div>
          </div>
        </div>

 

        <!-- Hotel Review -->
        <div class="hotel-review pt-60" data-aos="fade-up">
          <div class="section-title title-inline mb-30">
            <h3 class="title">{{ __('Reviews') }}</h3>
          </div>
          <div class="review-progresses bg-primary-light p-30 radius-md mb-40">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-30">
              <div class="d-flex gap-3">
                <h4 class="mb-0">{{ __('Average Rating') }} </h4>
                <h4 class="mb-0">{{ $hotel->average_rating }}</h4>
              </div>

              <h5 class="mb-0">{{ __('Total') }}: {{ $numOfReview }} </h5>
            </div>
            @php
              $total_review = App\Models\RoomReview::where('hotel_id', $hotel->id)->count();
              $ratings = [
                  5 => 'Excellent',
                  4 => 'Good',
                  3 => 'Average',
                  2 => 'Poor',
                  1 => 'Bad',
              ];
            @endphp
            @foreach ($ratings as $rating => $label)
              @php
                $totalReviewForRating = App\Models\RoomReview::where('hotel_id', $hotel->id)
                    ->where('rating', $rating)
                    ->count();
                $percentage = $total_review > 0 ? round(($totalReviewForRating / $total_review) * 100) : 0;
              @endphp

              <!-- percentage grid start-->
              <div class="review-progress mb-10 review-progress-grid">
                <div class="rating-icon-area">
                  <div class="review-ratings rate">
                    <div class="rating" style="width: {{ 20 * $rating }}%;"></div>
                  </div>
                  <p class="mb-0">{{ $rating }} {{ $rating == 1 ? __('Star') : __('Stars') }}</p>
                </div>

                <div class="progress-line">
                  <div class="progress">
                    <div class="progress-bar bg-primary" style="width: {{ $percentage }}%" role="progressbar"
                      aria-label="Basic example" aria-valuenow="{{ $percentage }}" aria-valuemin="0"
                      aria-valuemax="100">
                    </div>
                  </div>
                </div>
                <div class="percentage-area">
                  <div class="percentage">{{ $percentage }}%</div>
                </div>
              </div>
              <!-- percentage grid end-->
            @endforeach
          </div>
          <div class="review-box pb-10">
            <div class="row">
              @foreach ($reviews as $review)
                <div class="col-lg-6">
                  <div class="review-list mb-30 border radius-md">
                    <div class="review-item p-30">
                      <div class="review-header flex-wrap mb-20">
                        <div class="author d-flex align-items-center justify-content-between gap-3">
                          <div class="author-img">
                            @if (empty($review->user->image))
                              <img class="lazyload  ratio ratio-1-1 rounded-circle"
                                data-src="{{ asset('assets/img/user.png') }}" alt="Avatar">
                            @else
                              <img class="lazyload  ratio ratio-1-1 rounded-circle"
                                data-src="{{ asset('assets/img/users/' . $review->user->image) }}" alt="Avatar">
                            @endif
                          </div>
                          <div class="author-info">
                            <h6 class="mb-1">
                              <a href="#" target="_self"
                                title="{{ __('Link') }}">{{ $review->user->username }}</a>
                            </h6>
                            <div class="ratings mb-1">
                              <div class="rate" style="background-image: url('{{ asset($rateStar) }}')">
                                <div class="rating-icon"
                                  style="background-image:url('{{ asset($rateStar) }}'); width: {{ $review->rating * 20 . '%;' }}">
                                </div>
                              </div>
                              <span class="ratings-total">({{ $review->rating }})</span>
                            </div>
                          </div>
                        </div>
                        <div class="more-info font-sm">
                          @if ($review->user->address)
                            <div class="icon-start">
                              <i class="fal fa-map-marker-alt"></i>
                              {{ $review->user->address }}
                            </div>
                          @endif
                          <div class="icon-start">
                            <i class="fal fa-clock"></i>
                            {{ $review->updated_at->diffForHumans() }}
                          </div>
                        </div>
                      </div>
                      <p>{{ $review->review }}
                      </p>
                    </div>
                  </div>
                </div>
              @endforeach
              @if (!empty(showAd(3)))
                <div class="text-center">
                  {!! showAd(3) !!}
                </div>
              @endif
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Hotel-details-area end -->
  @include('frontend.hotel.share')
  
  <!-- Booking Modal -->
  <div class="modal fade" id="bookingModal" tabindex="-1" aria-labelledby="bookingModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content border-0 shadow-lg">
        <div class="modal-header bg-primary text-white border-0">
          <h5 class="modal-title fw-bold text-white" id="bookingModalLabel">
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
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content border-0 shadow-lg">
        <div class="modal-header bg-white border-0">
          <h5 class="modal-title fw-bold text-dark" id="roomDetailsModalLabel">
          </h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body p-0">
        
          <div class="room-main-image">
            <img id="roomMainImage" src="" alt="Room Image" class="img-fluid w-100" style="height: 400px; object-fit: cover;">
          </div>
          
          <div class="room-image-carousel p-3">
            <div class="d-flex gap-2 overflow-auto" id="roomThumbnailsContainer">

            </div>
          </div>
          <div class="room-details-content p-4">
            <div class="vehicle-location mb-4">
              <h6 class="fw-bold text-dark mb-2">{{ $roomContent ? $roomContent->title : 'Room' }}</h6>
            </div>
            @if($roomAmenitiesCount > 0)
            <div class="amenities-section mb-4">
              <h6 class="fw-bold text-dark mb-3">{{ __('Amenities') }}</h6>
              <div class="row g-2">
                @foreach($roomAmenities as $amenityId)
                  @php
                    $amenity = App\Models\Amenitie::find($amenityId);
                  @endphp
                  @if($amenity)
                    <div class="col-6 col-md-4">
                      <div class="d-flex align-items-center">
                        <i class="{{ $amenity->icon }} text-primary me-2"></i>
                        <span>{{ $amenity->title }}</span>
                      </div>
                    </div>
                  @endif
                @endforeach
              </div>
            </div>
          @endif
            
            <!-- Rules Section -->
            @if($roomContent && $roomContent->description)
            <div class="description-section">
              <h6 class="fw-bold text-dark mb-3">{{ __('Description') }}</h6>
              <div class="tinymce-content">
                {!! $roomContent->description !!}
              </div>
            </div>
          @endif
          </div>
        </div>
      </div>
    </div>
  </div>
@endsection
@section('script')
  <script>
    var latitude = "{{ $hotel->latitude }}";
    var longitude = "{{ $hotel->longitude }}"; 
  </script>
  <script src="{{ asset('assets/front/js/hotel-single-map.js') }}"></script>
  
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
    
    /* Room Image Clickable Styles */
    .room-image-clickable {
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
    }
    
    .room-image-clickable:hover {
      transform: scale(1.05);
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    
    .room-image {
      overflow: hidden;
      border-radius: 0.5rem;
    }
    
    /* Room Details Modal Styles */
    #roomDetailsModal .modal-dialog {
      max-width: 800px;
    }
    
    #roomDetailsModal .modal-content {
      border-radius: 0.5rem;
      overflow: hidden;
    }
    
    #roomDetailsModal .room-main-image {
      overflow: hidden;
    }
    
    #roomDetailsModal .room-image-carousel {
      background-color: #f8f9fa;
    }
    
    #roomDetailsModal .room-thumbnail {
      cursor: pointer;
      transition: all 0.3s ease;
    }
    
    #roomDetailsModal .room-thumbnail:hover {
      transform: translateY(-2px);
    }
    
    #roomDetailsModal .room-thumbnail img {
      transition: border-color 0.3s ease;
    }
    
    #roomDetailsModal .vehicle-location .btn {
      border-radius: 20px;
      font-size: 0.875rem;
      padding: 0.375rem 1rem;
    }
    
    #roomDetailsModal .vehicle-location .btn.active {
      background-color: #007bff;
      border-color: #007bff;
      color: white;
    }
    
    #roomDetailsModal .form-check-input:checked {
      background-color: #007bff;
      border-color: #007bff;
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
      #roomDetailsModal .modal-dialog {
        margin: 0.5rem;
        max-width: calc(100% - 1rem);
      }
      
      #roomDetailsModal .room-main-image img {
        height: 250px !important;
      }
    }
  </style>
  
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
    
    // Room Details Modal JavaScript
    document.addEventListener('DOMContentLoaded', function() {
      const roomDetailsModal = document.getElementById('roomDetailsModal');
      const roomMainImage = document.getElementById('roomMainImage');
      
      let currentRoomId = null;
      let currentRoomTitle = null;
      
      // Handle room image clicks
      document.querySelectorAll('.room-image-clickable').forEach(image => {
        image.addEventListener('click', function() {
          const roomId = this.getAttribute('data-room-id');
          const roomTitle = this.getAttribute('data-room-title');
          const roomImage = this.getAttribute('data-room-image');
          const roomGallery = JSON.parse(this.getAttribute('data-room-gallery') || '[]');
          
          // Store current room info for booking
          currentRoomId = roomId;
          currentRoomTitle = roomTitle;
          
          // Update modal content
          document.getElementById('roomDetailsModalLabel').textContent = roomTitle;
          
          // Set main image to first gallery image or feature image as fallback
          const mainImageSrc = roomGallery && roomGallery.length > 0 ? roomGallery[0] : roomImage;
          console.log('Room Gallery:', roomGallery);
          console.log('Main Image Source:', mainImageSrc);
          console.log('Room Image:', roomImage);
          
          roomMainImage.src = mainImageSrc || 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAwIiBoZWlnaHQ9IjMwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjZjhmOWZhIi8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCwgc2Fucy1zZXJpZiIgZm9udC1zaXplPSIxOCIgZmlsbD0iIzZjNzU3ZCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZHk9Ii4zZW0iPkltYWdlIG5vdCBhdmFpbGFibGU8L3RleHQ+PC9zdmc+';
          roomMainImage.alt = roomTitle;
          
                      // Add error handling for image loading
            roomMainImage.onerror = function() {
              console.error('Failed to load image:', mainImageSrc);
              this.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAwIiBoZWlnaHQ9IjMwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjZjhmOWZhIi8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCwgc2Fucy1zZXJpZiIgZm9udC1zaXplPSIxOCIgZmlsbD0iIzZjNzU3ZCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZHk9Ii4zZW0iPkltYWdlIG5vdCBhdmFpbGFibGU8L3RleHQ+PC9zdmc+';
            };
          
          roomMainImage.onload = function() {
            console.log('Image loaded successfully:', mainImageSrc);
          };
          
          // Update image carousel thumbnails with actual gallery images
          updateImageCarousel(roomGallery);
        });
      });
      

      

      
      // Function to update image carousel
      function updateImageCarousel(galleryImages) {
        const thumbnailsContainer = document.getElementById('roomThumbnailsContainer');
        thumbnailsContainer.innerHTML = '';
        
        if (galleryImages && galleryImages.length > 0) {
          galleryImages.forEach((imageSrc, index) => {
            const thumbnailDiv = document.createElement('div');
            thumbnailDiv.className = `room-thumbnail ${index === 0 ? 'active' : ''}`;
            thumbnailDiv.setAttribute('data-image', imageSrc);
            
            const img = document.createElement('img');
            img.src = imageSrc;
            img.alt = 'Room Thumbnail';
            img.className = 'img-fluid rounded';
            img.style.width = '80px';
            img.style.height = '60px';
            img.style.objectFit = 'cover';
            img.style.border = index === 0 ? '2px solid #007bff' : '2px solid transparent';
            
            // Add error handling for thumbnail images
            img.onerror = function() {
              console.error('Failed to load thumbnail:', imageSrc);
              this.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAwIiBoZWlnaHQ9IjMwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjZjhmOWZhIi8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCwgc2Fucy1zZXJpZiIgZm9udC1zaXplPSIxOCIgZmlsbD0iIzZjNzU3ZCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZHk9Ii4zZW0iPkltYWdlIG5vdCBhdmFpbGFibGU8L3RleHQ+PC9zdmc+';
            };
            
            thumbnailDiv.appendChild(img);
            thumbnailsContainer.appendChild(thumbnailDiv);
            
            // Add click event to thumbnail
            thumbnailDiv.addEventListener('click', function() {
              // Update main image
              roomMainImage.src = imageSrc;
              
              // Update active thumbnail
              document.querySelectorAll('.room-thumbnail').forEach(thumb => {
                thumb.querySelector('img').style.border = '2px solid transparent';
                thumb.classList.remove('active');
              });
              this.querySelector('img').style.border = '2px solid #007bff';
              this.classList.add('active');
            });
          });
        } else {
          // Fallback if no gallery images
          const thumbnailDiv = document.createElement('div');
          thumbnailDiv.className = 'room-thumbnail active';
          thumbnailDiv.setAttribute('data-image', roomMainImage.src);
          
          const img = document.createElement('img');
          img.src = roomMainImage.src;
          img.alt = 'Room Thumbnail';
          img.className = 'img-fluid rounded';
          img.style.width = '80px';
          img.style.height = '60px';
          img.style.objectFit = 'cover';
          img.style.border = '2px solid #007bff';
          
          // Add error handling for fallback thumbnail
          img.onerror = function() {
            console.error('Failed to load fallback thumbnail:', roomMainImage.src);
            this.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAwIiBoZWlnaHQ9IjMwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjZjhmOWZhIi8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCwgc2Fucy1zZXJpZiIgZm9udC1zaXplPSIxOCIgZmlsbD0iIzZjNzU3ZCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZHk9Ii4zZW0iPkltYWdlIG5vdCBhdmFpbGFibGU8L3RleHQ+PC9zdmc+';
          };
          
          thumbnailDiv.appendChild(img);
          thumbnailsContainer.appendChild(thumbnailDiv);
        }
      }
      
      // Handle vehicle location buttons
      document.querySelectorAll('.vehicle-location .btn').forEach(button => {
        button.addEventListener('click', function() {
          document.querySelectorAll('.vehicle-location .btn').forEach(btn => {
            btn.classList.remove('active');
          });
          this.classList.add('active');
        });
      });
    });
  </script>
@endsection
