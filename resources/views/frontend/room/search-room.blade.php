@if (count($featured_contents) < 1 && count($currentPageData) < 1)
  <div class="p-3 text-center bg-light radius-md">
    <h6 class="mb-0">{{ __('NO HOTEL FOUND') }}</h6>
  </div>
@else
  <div class="row pb-15" data-aos="fade-up">
    @foreach ($featured_contents as $room)
      <div class="col-xl-4 col-lg-4 col-md-6 col-sm-6">
        <div class="space-card ">
          <div class="card-image-container">
            <a href="{{ route('frontend.hotel.details', ['slug' => $room->hotelSlug, 'id' => $room->hotelId]) }}"
              target="_self" title="{{ __('Link') }}">
              <img class="card-image lazyload"
                data-src="{{ asset('assets/img/hotel/logo/' . $room->hotelImage) }}" alt="Hotel">
            </a>
            @if (Auth::guard('web')->check())
              @php
                $user_id = Auth::guard('web')->user()->id;
                $checkWishList = checkHotelWishList($room->hotelId, $user_id);
              @endphp
            @else
              @php
                $checkWishList = false;
              @endphp
            @endif

            <button class="heart-button {{ $checkWishList == false ? '' : 'active' }}" 
              onclick="window.location.href='{{ $checkWishList == false ? route('addto.wishlist.hotel', $room->hotelId) : route('remove.wishlist.hotel', $room->hotelId) }}'">
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
                    @if ($i <= $room->average_rating)
                      <i class="fas fa-star filled"></i>
                    @elseif ($i - $room->average_rating < 1)
                      <i class="fas fa-star-half-alt filled"></i>
                    @else
                      <i class="far fa-star"></i>
                    @endif
                  @endfor
                </div>
                <span class="rating-number">({{ totalHotelReview($room->hotelId) }})</span>
              </div>
              <div class="guest-capacity">
                <span class="badge bg-light text-dark">{{ totalHotelRoom($room->hotelId) }} {{ __('Rooms') }}</span>
              </div>
            </div>
            
            <h3 class="card-title">
              <a href="{{ route('frontend.hotel.details', ['slug' => $room->hotelSlug, 'id' => $room->hotelId]) }}"
                target="_self" title="{{ __('Link') }}">
                {{ $room->hotelName }}
              </a>
            </h3>
            
            <div class="card-location">
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
              <span>{{ @$city }}@if (@$State), {{ $State }}@endif @if (@$country), {{ $country }}@endif</span>
            </div>
            
            <div class="card-features">
              @php
                $amenities = json_decode($room->amenities);
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
    
    @foreach ($currentPageData as $room)
      <div class="col-xl-4 col-lg-4 col-md-6 col-sm-6">
        <div class="space-card">
          <div class="card-image-container">
            <a href="{{ route('frontend.hotel.details', ['slug' => $room->hotelSlug, 'id' => $room->hotelId]) }}"
              target="_self" title="{{ __('Link') }}">
              <img class="card-image lazyload"
                data-src="{{ asset('assets/img/hotel/logo/' . $room->hotelImage) }}" alt="Hotel">
            </a>
            @if (Auth::guard('web')->check())
              @php
                $user_id = Auth::guard('web')->user()->id;
                $checkWishList = checkHotelWishList($room->hotelId, $user_id);
              @endphp
            @else
              @php
                $checkWishList = false;
              @endphp
            @endif

            <button class="heart-button {{ $checkWishList == false ? '' : 'active' }}" 
              onclick="window.location.href='{{ $checkWishList == false ? route('addto.wishlist.hotel', $room->hotelId) : route('remove.wishlist.hotel', $room->hotelId) }}'">
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
                    @if ($i <= $room->average_rating)
                      <i class="fas fa-star filled"></i>
                    @elseif ($i - $room->average_rating < 1)
                      <i class="fas fa-star-half-alt filled"></i>
                    @else
                      <i class="far fa-star"></i>
                    @endif
                  @endfor
                </div>
                <span class="rating-number">({{ totalHotelReview($room->hotelId) }})</span>
              </div>
              <div class="guest-capacity">
                <span class="badge bg-light text-dark">{{ totalHotelRoom($room->hotelId) }} {{ __('Rooms') }}</span>
              </div>
            </div>
            
            <h3 class="card-title">
              <a href="{{ route('frontend.hotel.details', ['slug' => $room->hotelSlug, 'id' => $room->hotelId]) }}"
                target="_self" title="{{ __('Link') }}">
                {{ $room->hotelName }}
              </a>
            </h3>
            
            <div class="card-location">
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
              <span>{{ @$city }}@if (@$State), {{ $State }}@endif @if (@$country), {{ $country }}@endif</span>
            </div>
            
            <div class="card-features">
              @php
                $amenities = json_decode($room->amenities);
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
  
  @if ($room_contents->count() / $perPage > 1)
    <nav class="pagination-nav mb-40" data-aos="fade-up">
      <ul class="pagination justify-content-center">
        @if (request()->input('page'))
          @if (request()->input('page') != 1)
            <li class="page-item">
              <a class="page-link" data-page="{{ request()->input('page') - 1 }}" aria-label="Previous">
                <i class="far fa-angle-left"></i>
              </a>
            </li>
          @else
            <li class="page-item disabled">
              <a class="page-link" aria-label="Previous" tabindex="-1" aria-disabled="true">
                <i class="far fa-angle-left"></i>
              </a>
            </li>
          @endif
        @endif

        @if ($room_contents->count() / $perPage > 1)
          @for ($i = 1; $i <= ceil($room_contents->count() / $perPage); $i++)
            <li class="page-item @if (request()->input('page') == $i) active @endif">
              <a class="page-link" data-page="{{ $i }}">{{ $i }}</a>
            </li>
          @endfor
        @endif
        @php
          $totalPages = ceil($room_contents->count() / $perPage);
        @endphp

        @if (request()->input('page'))
          @if (request()->input('page') != $totalPages)
            <li class="page-item">
              <a class="page-link" data-page="{{ request()->input('page') + 1 }}" aria-label="Previous">
                <i class="far fa-angle-right"></i>
              </a>
            </li>
          @else
            <li class="page-item disabled">
              <a class="page-link" aria-label="Previous" tabindex="-1" aria-disabled="true">
                <i class="far fa-angle-right"></i>
              </a>
            </li>
          @endif
        @endif
      </ul>
    </nav>
  @endif
@endif

<script>
  "use strict";
  var featured_contents = {!! json_encode($featured_contents) !!};
  var room_contents = {!! json_encode($currentPageData) !!};
</script>

<style>
  /* Space Card Styling - Exact Match */
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
    margin-bottom: 24px;
    border: 1px solid #e1e1e1;
  }

  .space-card:hover {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    transform: translateY(-2px);
  }

  .space-card.featured {
    border: 1px solid #e1e1e1;
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

  .card-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: auto;
  }

  .price-info {
    display: flex;
    align-items: baseline;
    gap: 2px;
  }

  .price-from {
    font-size: 14px;
    color: #717171;
  }

  .price-amount {
    font-size: 16px;
    font-weight: 600;
    color: #484848;
  }

  .price-unit {
    font-size: 14px;
    color: #717171;
  }

  .instant-book-badge {
    background: #00a699;
    color: white;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 12px;
    font-weight: 500;
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
      height: 340px;
    }
    
    .card-image-container {
      height: 180px;
    }
  }
</style>
