@extends('frontend.layout')
@section('pageHeading')
  {{ __('Search Hotels') }}
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
  <div>
    <!-- Filter Bar -->
    <div class="filter-bar bg-white border-bottom py-3">
    <div class="container-fluid">
      <div class="row align-items-center">
      <div class="col-12">
        <div class="d-flex flex-wrap gap-3 align-items-center">
        <!-- Hotel Category Filter -->
        <div class="filter-dropdown">
          <select class="space-select categoryDropdown" id="categoryDropdown">
          <option value="">{{ __('All Hotel Categories') }}</option>
          @foreach ($hotelCategories ?? [] as $category)
        <option @if (request()->input('category') == $category->slug) selected @endif
        value="{{ $category->slug }}">
        {{ $category->name }}
        </option>
      @endforeach
          </select>
        </div>
        <!-- Hotel Filter -->
        <div class="filter-dropdown">
          <select class="space-select hotelDropdown" id="hotelDropdown">
          <option value="">{{ __('All Hotels') }}</option>
          @foreach ($hotels ?? [] as $hotel)
        <option @if (request()->input('hotelId') == $hotel->id) selected @endif value="{{ $hotel->id }}">
        {{ @$hotel->title }}
        </option>
      @endforeach
          </select>
        </div>
        <!-- Country Filter -->
        @if (isset($countries) && $countries->count() > 0)
        <div class="filter-dropdown">
        <select class="space-select countryDropdown" id="countryDropdown">
        <option value="">{{ __('All Countries') }}</option>
        @foreach ($countries as $country)
        <option @if (request()->input('country') == $country->id) selected @endif value="{{ $country->id }}">
        {{ $country->name }}
        </option>
      @endforeach
        </select>
        </div>
      @endif
        <!-- State Filter -->
        @if (isset($states) && $states->count() > 0)
        <div class="filter-dropdown">
        <select class="space-select stateDropdown" id="stateDropdown">
        <option value="">{{ __('All States') }}</option>
        @foreach ($states as $state)
        <option @if (request()->input('state') == $state->id) selected @endif value="{{ $state->id }}">
        {{ $state->name }}
        </option>
      @endforeach
        </select>
        </div>
      @endif
        <!-- City Filter -->
        @if (isset($cities) && $cities->count() > 0)
        <div class="filter-dropdown">
        <select class="space-select cityDropdown" id="cityDropdown">
        <option value="">{{ __('All Cities') }}</option>
        @foreach ($cities as $city)
        <option @if (request()->input('city') == $city->id) selected @endif value="{{ $city->id }}">
        {{ $city->name }}
        </option>
      @endforeach
        </select>
        </div>
      @endif
        <!-- Rating Filter -->
        <div class="filter-dropdown">
          <select class="space-select ratingDropdown" id="ratingDropdown">
          <option value="">{{ __('All Ratings') }}</option>
          <option @if (request()->input('ratings') == 5) selected @endif value="5">{{ __('5 stars') }}</option>
          <option @if (request()->input('ratings') == 4) selected @endif value="4">{{ __('4+ stars') }}</option>
          <option @if (request()->input('ratings') == 3) selected @endif value="3">{{ __('3+ stars') }}</option>
          <option @if (request()->input('ratings') == 2) selected @endif value="2">{{ __('2+ stars') }}</option>
          <option @if (request()->input('ratings') == 1) selected @endif value="1">{{ __('1+ star') }}</option>
          </select>
        </div>
        <!-- Stars Filter -->
        {{-- <div class="filter-dropdown">
          <select class="space-select starsDropdown" id="starsDropdown">
          <option value="">{{ __('All Stars') }}</option>
          <option @if (request()->input('stars') == 5) selected @endif value="5">{{ __('5 ★★★★★') }}</option>
          <option @if (request()->input('stars') == 4) selected @endif value="4">{{ __('4 ★★★★') }}</option>
          <option @if (request()->input('stars') == 3) selected @endif value="3">{{ __('3 ★★★') }}</option>
          <option @if (request()->input('stars') == 2) selected @endif value="2">{{ __('2 ★★') }}</option>
          <option @if (request()->input('stars') == 1) selected @endif value="1">{{ __('1 ★') }}</option>
          </select>
        </div> --}}
        <!-- Stars Filter -->
        <div class="filter-dropdown">
          <select class="space-select starsDropdown" id="starsDropdown">
          <option value="">{{ __('All Stars') }}</option>
          <option @if (request()->input('stars') == 5) selected @endif value="5">{{ __('5 ★★★★★') }}</option>
          <option @if (request()->input('stars') == 4) selected @endif value="4">{{ __('4 ★★★★') }}</option>
          <option @if (request()->input('stars') == 3) selected @endif value="3">{{ __('3 ★★★') }}</option>
          <option @if (request()->input('stars') == 2) selected @endif value="2">{{ __('2 ★★') }}</option>
          <option @if (request()->input('stars') == 1) selected @endif value="1">{{ __('1 ★') }}</option>
          </select>
        </div>
        <!-- Sort Filter -->
        <div class="filter-dropdown">
          <select class="space-select sortDropdown" id="sortDropdown">
          <option value="">{{ __('Sort By') }}</option>
          <option @if (request()->input('sort') == 'new') selected @endif value="new">{{ __('Newest') }}</option>
          <option @if (request()->input('sort') == 'old') selected @endif value="old">{{ __('Oldest') }}</option>
          <option @if (request()->input('sort') == 'starhigh') selected @endif value="starhigh">
            {{ __('Stars: High to Low') }}</option>
          <option @if (request()->input('sort') == 'starlow') selected @endif value="starlow">
            {{ __('Stars: Low to High') }}</option>
          <option @if (request()->input('sort') == 'reviewshigh') selected @endif value="reviewshigh">
            {{ __('Reviews: High to Low') }}</option>
          <option @if (request()->input('sort') == 'reviewslow') selected @endif value="reviewslow">
            {{ __('Reviews: Low to High') }}</option>
          </select>
        </div>
        <!-- Reset Button -->
        <div class="filter-dropdown">
          <a href="{{ route('frontend.search_room') }}" class="space-btn">
          <i class="fal fa-sync-alt me-2"></i>{{ __('Reset') }}
          </a>
        </div>
        <!-- Map Filter Toggle -->
        <div class="filter-dropdown">
          <div class="map-filter-toggle">
          <label class="toggle-switch">
            <input type="checkbox" id="mapFilterToggle">
            <span class="toggle-slider"></span>
          </label>
          <span class="toggle-label">{{ __('Search as map moves') }}</span>
          </div>
        </div>
        <!-- Clear Map Filter Button -->
        <div class="filter-dropdown">
          <button id="clearMapFilter" class="space-btn" style="display: none;">
          <i class="fal fa-map-marker-alt me-2"></i>{{ __('Clear Map Filter') }}
          </button>
        </div>
        </div>
      </div>
      </div>
    </div>
    </div>
  </div>
  <section class="mt-3">
    <div class="py-3">
    <div class="container-fluid">
      <div class="row">
      <div class="col-lg-7">
        <div class="search-results-panel">
        <div class="search-container">
          @include('frontend.room.search-room')
        </div>
        <div id="loadingOverlay" class="loading-overlay" style="display: none;">
          <div class="loading-content">
          <i class="fas fa-spinner fa-spin"></i>
          <p>Loading hotels...</p>
          </div>
        </div>
        </div>
      </div>
      <div class="col-lg-5">
        <div id="searchMap" class="search-map">
        <div id="boundsIndicator" class="map-bounds-indicator" style="display: none;">
          <i class="fas fa-filter"></i> Filtering by location
        </div>
        </div>
      </div>
      </div>
    </div>
    </div>
  </section>
@endsection
@section('script')
  @if ($basicInfo->google_map_api_key_status == 1)
    <script src="{{ asset('assets/front/js/map-init.js') }}"></script>
    <script
    src="https://maps.googleapis.com/maps/api/js?key={{ $basicInfo->google_map_api_key }}&libraries=places&loading=async&callback=initSearchMap"
    async defer></script>
  @else
    <script>
    function initSearchMap() {
    console.log('Google Maps API not available');
    document.getElementById('searchMap').innerHTML = '<div style="height: 100%; display: flex; align-items: center; justify-content: center; background: #f5f5f5; color: #666;">Map not available</div>';
    }
    </script>
  @endif
  <script src="{{ asset('assets/front/js/search-home.js') }}"></script>
  <script>
    "use strict";
    var searchUrl = "{{ route('frontend.search_room') }}";
    var featured_contents = {!! json_encode($featured_contents ?? []) !!};
    var room_contents = {!! json_encode($currentPageData ?? []) !!};
    var assetUrl = "{{ asset('') }}";

    $(document).ready(function () {
    window.mapFilteringActive = false;
    window.currentMap = null;

    function triggerMapFiltering() {
      if (window.currentMap && window.mapFilteringActive && $('#mapFilterToggle').is(':checked')) {
      filterHotelsByMapBounds(window.currentMap);
      }
    }

    function applyFilters() {
      console.log('applyFilters called');
      var url = new URL(window.location);

      var category = $('#categoryDropdown').val();
      var hotelId = $('#hotelDropdown').val();
      var country = $('#countryDropdown').val();
      var state = $('#stateDropdown').val();
      var city = $('#cityDropdown').val();
      var ratings = $('#ratingDropdown').val();
      var stars = $('#starsDropdown').val();
      var sort = $('#sortDropdown').val();

      console.log('Filter values:', {
      category: category,
      hotelId: hotelId,
      country: country,
      state: state,
      city: city,
      ratings: ratings,
      stars: stars,
      sort: sort
      });

      if (category) url.searchParams.set('category', category);
      else url.searchParams.delete('category');

      if (hotelId) url.searchParams.set('hotelId', hotelId);
      else url.searchParams.delete('hotelId');

      if (country) url.searchParams.set('country', country);
      else url.searchParams.delete('country');

      if (state) url.searchParams.set('state', state);
      else url.searchParams.delete('state');

      if (city) url.searchParams.set('city', city);
      else url.searchParams.delete('city');

      if (ratings) url.searchParams.set('ratings', ratings);
      else url.searchParams.delete('ratings');

      if (stars) url.searchParams.set('stars', stars);
      else url.searchParams.delete('stars');

      if (sort) url.searchParams.set('sort', sort);
      else url.searchParams.delete('sort');

      url.searchParams.delete('page');

      console.log('New URL:', url.toString());

      window.location.href = url.toString();
    }

    $('#mapFilterToggle').on('change', function () {
      if ($(this).is(':checked')) {
      window.mapFilteringActive = true;
      $('.map-filter-toggle').addClass('active');
      $('.toggle-label').text('Map Filter (ON)').addClass('active');
      $('#boundsIndicator').show();
      $('#clearMapFilter').show();

      showAllHotelsOnMap();
      } else {
      window.mapFilteringActive = false;
      $('.map-filter-toggle').removeClass('active');
      $('.toggle-label').text('Map Filter').removeClass('active');
      $('#boundsIndicator').hide();
      $('#clearMapFilter').hide();
      window.location.reload();
      }
    });

    $('#categoryDropdown').on('change', function () {
      console.log('Category dropdown changed to:', $(this).val());
      if ($('#mapFilterToggle').is(':checked')) {
      triggerMapFiltering();
      } else {
      applyFilters();
      }
    });
    $('#hotelDropdown').on('change', function () {
      if ($('#mapFilterToggle').is(':checked')) {
      triggerMapFiltering();
      } else {
      applyFilters();
      }
    });
    $('#countryDropdown').on('change', function () {
      if ($('#mapFilterToggle').is(':checked')) {
      triggerMapFiltering();
      } else {
      applyFilters();
      }
    });
    $('#stateDropdown').on('change', function () {
      if ($('#mapFilterToggle').is(':checked')) {
      triggerMapFiltering();
      } else {
      applyFilters();
      }
    });
    $('#cityDropdown').on('change', function () {
      if ($('#mapFilterToggle').is(':checked')) {
      triggerMapFiltering();
      } else {
      applyFilters();
      }
    });
    $('#ratingDropdown').on('change', function () {
      if ($('#mapFilterToggle').is(':checked')) {
      triggerMapFiltering();
      } else {
      applyFilters();
      }
    });
    $('#starsDropdown').on('change', function () {
      if ($('#mapFilterToggle').is(':checked')) {
      triggerMapFiltering();
      } else {
      applyFilters();
      }
    });

    $('#sortDropdown').on('change', function () {
      if ($('#mapFilterToggle').is(':checked')) {
      triggerMapFiltering();
      } else {
      applyFilters();
      }
    });

    $('#clearMapFilter').on('click', function () {
      window.mapFilteringActive = false;
      $('#mapFilterToggle').prop('checked', false);
      $('.map-filter-toggle').removeClass('active');
      $('.toggle-label').text('Map Filter').removeClass('active');
      $('#boundsIndicator').hide();
      $('#clearMapFilter').hide();
      window.location.reload();
    });

    function showAllHotelsOnMap() {
      // Show loading
      $('#loadingOverlay').show();
      $('#boundsIndicator').html('<i class="fas fa-spinner fa-spin"></i> Loading all hotels...');

      var currentFilters = {
      category: $('#categoryDropdown').val(),
      hotelId: $('#hotelDropdown').val(),
      country: $('#countryDropdown').val(),
      state: $('#stateDropdown').val(),
      city: $('#cityDropdown').val(),
      ratings: $('#ratingDropdown').val(),
      stars: $('#starsDropdown').val(),
      sort: $('#sortDropdown').val()
      };

      $.ajax({
      url: '/api/hotels/filter-by-bounds',
      method: 'GET',
      data: currentFilters,
      success: function (response) {
        console.log('AJAX success response:', response);
        $('#loadingOverlay').hide();
        if (response.success) {
        console.log('Response successful, calling updateHotelDisplay with', response.hotels.length, 'hotels');
        updateHotelDisplay(response.hotels);
        updateMapMarkers(response.hotels, window.currentMap);
        $('#boundsIndicator').html('<i class="fas fa-globe"></i> Showing all ' + response.count + ' hotels worldwide');
        } else {
        console.log('Response not successful');
        $('.search-container').html('<div class="text-center p-4 text-muted">No hotels found</div>');
        $('#boundsIndicator').html('<i class="fas fa-globe"></i> No hotels found');
        }
      },
      error: function (xhr, status, error) {
        console.error('AJAX error:', { xhr: xhr, status: status, error: error });
        $('#loadingOverlay').hide();
        $('#boundsIndicator').hide();
        console.error('Error loading all hotels:', error);
        $('.search-container').html('<div class="text-center p-4 text-danger">Error loading hotels. Please try again.</div>');
      }
      });
    }

    function updateSearchParams(param, value) {
      var url = new URL(window.location);
      if (value && value !== '') {
      url.searchParams.set(param, value);
      } else {
      url.searchParams.delete(param);
      }
      url.searchParams.delete('page');
      window.location.href = url.toString();
    }
    });

    // Global function for Google Maps callback
    window.initSearchMap = function() {
    try {
      var mapContainer = document.getElementById('searchMap');
      if (!mapContainer) {
      console.error('Map container not found');
      return;
      }
      if (typeof google === 'undefined' || typeof google.maps === 'undefined') {
      console.error('Google Maps API not loaded');
      mapContainer.innerHTML = '<div style="height: 100%; display: flex; align-items: center; justify-content: center; background: #f5f5f5; color: #666;">Google Maps not available</div>';
      return;
      }
      var map = new google.maps.Map(mapContainer, {
      zoom: 4,
      center: { lat: 39.8283, lng: -98.5795 },
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      styles: [
        {
        featureType: "poi",
        elementType: "labels",
        stylers: [{ visibility: "off" }]
        },
        {
        featureType: "transit",
        elementType: "labels",
        stylers: [{ visibility: "off" }]
        }
      ]
      });

      window.currentMap = map;

      var boundsChangeTimeout;
      google.maps.event.addListener(map, 'bounds_changed', function () {
      clearTimeout(boundsChangeTimeout);
      boundsChangeTimeout = setTimeout(function () {
        // Only filter if toggle is enabled
        if ($('#mapFilterToggle').is(':checked')) {
        window.mapFilteringActive = true;
        filterHotelsByMapBounds(map);
        }
      }, 500);
      });
      window.mapMarkers = [];

      if (featured_contents && featured_contents.length > 0) {
      featured_contents.forEach(function (room) {
        if (room.latitude && room.longitude) {
        var priceText = room.total_rooms ? room.total_rooms.toString() : '0';
        var marker = new google.maps.Marker({
          position: { lat: parseFloat(room.latitude), lng: parseFloat(room.longitude) },
          map: map,
          title: room.hotelName,
          icon: {
          url: 'data:image/svg+xml;charset=UTF-8,' + encodeURIComponent(`
            <svg width="32" height="32" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">
              <path d="M16 2L2 8v20h28V8L16 2z" fill="#007bff" stroke="#fff" stroke-width="1"/>
              <rect x="8" y="12" width="4" height="8" fill="#fff"/>
              <rect x="12" y="12" width="4" height="8" fill="#fff"/>
              <rect x="16" y="12" width="4" height="8" fill="#fff"/>
              <rect x="20" y="12" width="4" height="8" fill="#fff"/>
              <rect x="10" y="22" width="2" height="6" fill="#fff"/>
              <rect x="14" y="22" width="2" height="6" fill="#fff"/>
              <rect x="18" y="22" width="2" height="6" fill="#fff"/>
            </svg>
            `),
          scaledSize: new google.maps.Size(32, 32),
          anchor: new google.maps.Point(16, 32)
          }
        });

        window.mapMarkers.push(marker);
        var infoWindow = new google.maps.InfoWindow({
          content: `
            <div class="map-popup-card ${room.featured === 1 ? 'featured' : ''}">
              <div class="map-popup-image">
                <img src="${assetUrl}assets/img/hotel/logo/${room.hotelImage}" alt="${room.hotelName}">
                ${room.featured === 1 ? '<div class="map-popup-badge">Featured</div>' : ''}
                <button class="map-popup-close" onclick="this.closest('.gm-style-iw-d').parentElement.parentElement.parentElement.remove()">×</button>
              </div>
              <div class="map-popup-content">
                <div class="product_title">
                  <h4><a href="/hotel/${room.hotelSlug}/${room.hotelId}">${room.hotelName}</a></h4>
                </div>
                
                <div class="rating-capacity-row">
                  <div class="rating-info">
                    <i class="fas fa-star"></i>
                    <span>${room.average_rating ? parseFloat(room.average_rating).toFixed(1) : '0.0'}</span>
                  </div>
                  <div class="capacity-info">
                    <i class="fas fa-bed"></i>
                    <span>${room.total_rooms || 0} Rooms</span>
                  </div>
                </div>
                
                ${room.amenities && Array.isArray(room.amenities) && room.amenities.length > 0 ? '<div class="features-list">' + room.amenities.slice(0, 3).join(', ') + '</div>' : ''}
                
                <div class="pricing-info">
                  <div class="price-details">
                     <a href="/venue/${room.hotelSlug}/${room.hotelId}" class="price-text">Check Check Available Rooms</a>
                  </div>
                </div>
              </div>
            </div>
          `
        });
        marker.addListener('click', function () {
          infoWindow.open(map, marker);
        });
        }
      });
      }
      if (room_contents && room_contents.length > 0) {
      room_contents.forEach(function (room) {
        if (room.latitude && room.longitude) {
        var priceText = room.total_rooms ? room.total_rooms.toString() : '0';
        var marker = new google.maps.Marker({
          position: { lat: parseFloat(room.latitude), lng: parseFloat(room.longitude) },
          map: map,
          title: room.hotelName,
          icon: {
          url: 'data:image/svg+xml;charset=UTF-8,' + encodeURIComponent(`
            <svg width="32" height="32" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">
              <path d="M16 2L2 8v20h28V8L16 2z" fill="#28a745" stroke="#fff" stroke-width="1"/>
              <rect x="8" y="12" width="4" height="8" fill="#fff"/>
              <rect x="12" y="12" width="4" height="8" fill="#fff"/>
              <rect x="16" y="12" width="4" height="8" fill="#fff"/>
              <rect x="20" y="12" width="4" height="8" fill="#fff"/>
              <rect x="10" y="22" width="2" height="6" fill="#fff"/>
              <rect x="14" y="22" width="2" height="6" fill="#fff"/>
              <rect x="18" y="22" width="2" height="6" fill="#fff"/>
            </svg>
            `),
          scaledSize: new google.maps.Size(32, 32),
          anchor: new google.maps.Point(16, 32)
          }
        });

        window.mapMarkers.push(marker);
        var infoWindow = new google.maps.InfoWindow({
          content: `
              <div class="map-popup-image">
                <img src="${assetUrl}assets/img/hotel/logo/${room.hotelImage}" alt="${room.hotelName}">
                ${room.featured === 1 ? '<div class="map-popup-badge">Featured</div>' : ''}
                <button class="map-popup-close" onclick="this.closest('.gm-style-iw-d').parentElement.parentElement.parentElement.remove()">×</button>
              </div>
              <div class="map-popup-content">
                <div class="product_title">
                  <h4><a href="/hotel/${room.hotelSlug}/${room.hotelId}">${room.hotelName}</a></h4>
                </div>
                
                <div class="rating-capacity-row">
                  <div class="rating-info">
                    <i class="fas fa-star"></i>
                    <span>${room.average_rating ? parseFloat(room.average_rating).toFixed(1) : '3.0'}</span>
                  </div>
                </div>
                
                ${room.amenities && Array.isArray(room.amenities) && room.amenities.length > 0 ? '<div class="features-list">' + room.amenities.slice(0, 3).join(', ') + '</div>' : ''}
                
                <div class="pricing-info">
                  <div class="price-details">
                    <a href="/venue/${room.hotelSlug}/${room.hotelId}" class="price-text">Check Available Rooms</a>
                  </div>
                </div>
              </div>
            </div>
          `
        });
        marker.addListener('click', function () {
          infoWindow.open(map, marker);
        });
        }
      });
      }
      console.log('Map initialized successfully');
    } catch (error) {
      console.error('Error initializing map:', error);
      var mapContainer = document.getElementById('searchMap');
      if (mapContainer) {
      mapContainer.innerHTML = '<div style="height: 100%; display: flex; align-items: center; justify-content: center; background: #f5f5f5; color: #666;">Error loading map</div>';
      }
    }
    }
    $('input[name="checkInDates"]').daterangepicker({
    "singleDatePicker": true,
    autoUpdateInput: true,
    minDate: moment().format('MM/DD/YYYY'),
    });
    $('input[name="checkInDates"]').on('apply.daterangepicker', function (ev, picker) {
    $(this).val(picker.startDate.format('MM/DD/YYYY'));
    });
    $('input[name="checkInDates"]').on('cancel.daterangepicker', function (ev, picker) {
    $(this).val('');
    });
    $('.filter-tag').on('click', function () {
    $(this).toggleClass('active');
    });

    function filterHotelsByMapBounds(map) {
    if (!$('#mapFilterToggle').is(':checked')) {
      return;
    }

    var bounds = map.getBounds();
    if (!bounds) return;

    var ne = bounds.getNorthEast();
    var sw = bounds.getSouthWest();

    var currentFilters = {
      category: $('#categoryDropdown').val(),
      hotelId: $('#hotelDropdown').val(),
      country: $('#countryDropdown').val(),
      state: $('#stateDropdown').val(),
      city: $('#cityDropdown').val(),
      ratings: $('#ratingDropdown').val(),
      stars: $('#starsDropdown').val(),
      sort: $('#sortDropdown').val(),
      north: ne.lat(),
      south: sw.lat(),
      east: ne.lng(),
      west: sw.lng()
    };

    $('#loadingOverlay').show();
    $('#boundsIndicator').show();
    $('#clearMapFilter').show();

    $.ajax({
      url: '/api/hotels/filter-by-bounds',
      method: 'GET',
      data: currentFilters,
      success: function (response) {
      $('#loadingOverlay').hide();
      if (response.success) {
        updateHotelDisplay(response.hotels);
        updateMapMarkers(response.hotels, map);
        $('#boundsIndicator').html('<i class="fas fa-filter"></i> ' + response.count + ' hotels in this area');
      } else {
        $('.search-container').html('<div class="text-center p-4 text-muted">No hotels found in this area</div>');
        $('#boundsIndicator').html('<i class="fas fa-filter"></i> No hotels in this area');
      }
      },
      error: function (xhr, status, error) {
      $('#loadingOverlay').hide();
      $('#boundsIndicator').hide();
      console.error('Error filtering hotels:', error);
      $('.search-container').html('<div class="text-center p-4 text-danger">Error loading hotels. Please try again.</div>');
      }
    });
    }

    function updateHotelDisplay(hotels) {
    console.log('updateHotelDisplay called with hotels:', hotels);

    var searchContainer = $('.search-container');
    console.log('Search container found:', searchContainer.length);
    if (searchContainer.length === 0) {
      console.error('Search container not found!');
      return;
    }

    if (!hotels || hotels.length === 0) {
      console.log('No hotels found, showing empty message');
      searchContainer.html('<div class="text-center p-4 text-muted">No hotels found in this area</div>');
      return;
    }

    console.log('Generating HTML for', hotels.length, 'hotels');
    var html = '<div class="row">';
    hotels.forEach(function (hotel) {
      html += generateHotelCard(hotel);
    });
    html += '</div>';

    console.log('Updating search-container with HTML');
    searchContainer.html(html);
    console.log('Hotel display updated successfully');
    }

    function generateHotelCard(hotel) {
    var isFeatured = hotel.featured === 1;
    var cardClass = isFeatured ? 'product-default product-default-style-2 border radius-md border-primary featured' : 'product-default product-default-style-2 border radius-md mb-25';

    var amenities = [];
    if (hotel.amenities && hotel.amenities.length > 0) {
      amenities = hotel.amenities.slice(0, 5);
    }
    var amenitiesText = amenities.length > 0 ? amenities.join(', ') : '';

    function generateStars(count) {
      var stars = '';
      for (var i = 0; i < count; i++) {
        stars += '<i class="fas fa-star"></i>';
      }
      return stars;
    }

    function generateAmenitiesIcons(amenities) {
      if (!amenities || amenities.length === 0) return '';

      var icons = '';
      var displayCount = Math.min(amenities.length, 5);

      for (var i = 0; i < displayCount; i++) {
        icons += '<li class="list-item" data-tooltip="tooltip" data-bs-placement="bottom" aria-label="Amenity" data-bs-original-title="Amenity" aria-describedby="tooltip"><i class="fas fa-check"></i></li>';
      }

      if (amenities.length > displayCount) {
        icons += '<li class="more_item_show_btn">(+' + (amenities.length - displayCount) + '<i class="fas fa-ellipsis-h"></i>)</li>';
      }

      return icons;
    }

    var html = '<div class="col-lg-4 col-md-6">';
    html += '<div class="' + cardClass + '">';
    html += '<div class="product_img">';
    html += '<a href="/hotel/' + hotel.slug + '/' + hotel.id + '">';
    html += '<img src="' + assetUrl + 'assets/img/hotel/logo/' + hotel.logo + '" alt="' + hotel.title + '">';
    html += '</a>';
    if (isFeatured) {
      html += '<div class="btn-icon active" style="position: absolute; top: 12px; right: 12px; background: #007bff; color: white; padding: 4px 8px; border-radius: 12px; font-size: 11px; font-weight: 600;">Featured</div>';
    }
    html += '</div>';
    html += '<div class="product_details">';
    html += '<div class="product_title">';
    html += '<h4><a href="/hotel/' + hotel.slug + '/' + hotel.id + '">' + hotel.title + '</a></h4>';
    html += '</div>';
    html += '<div class="rating-capacity-row">';
    html += '<div class="rating-info">';
    html += '<i class="fas fa-star"></i>';
    html += '<span>' + (hotel.average_rating ? parseFloat(hotel.average_rating).toFixed(1) : '0.0') + '</span>';
    html += '</div>';
    html += '<div class="capacity-info">';
    html += '<i class="fas fa-bed"></i>';
    html += '<span>' + (hotel.total_rooms || 0) + ' Rooms</span>';
    html += '</div>';
    html += '</div>';
    if (amenitiesText) {
      html += '<div class="features-list">' + amenitiesText + '</div>';
    }
    html += '<div class="pricing-info">';
    html += '<div class="price-details">';
    html += '<a href="/venue/${room.hotelSlug}/${room.hotelId}" class="price-text">Check Check Available Rooms</a>';
    html += '</div>';
    html += '</div>';
    html += '</div>';
    html += '</div>';
    html += '</div>';

    return html;
    }

    // Function to update map markers
    function updateMapMarkers(hotels, map) {
    // Clear existing markers
    if (window.mapMarkers) {
      window.mapMarkers.forEach(function (marker) {
      marker.setMap(null);
      });
    }
    window.mapMarkers = [];

    // Add new markers
    hotels.forEach(function (hotel) {
      if (hotel.latitude && hotel.longitude) {
      var priceText = hotel.total_rooms ? hotel.total_rooms.toString() : '0';
      var markerColor = hotel.featured === 1 ? '#007bff' : '#28a745';

      var marker = new google.maps.Marker({
        position: { lat: parseFloat(hotel.latitude), lng: parseFloat(hotel.longitude) },
        map: map,
        title: hotel.title,
        icon: {
        url: 'data:image/svg+xml;charset=UTF-8,' + encodeURIComponent(`
          <svg width="32" height="32" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">
            <path d="M16 2L2 8v20h28V8L16 2z" fill="${markerColor}" stroke="#fff" stroke-width="1"/>
            <rect x="8" y="12" width="4" height="8" fill="#fff"/>
            <rect x="12" y="12" width="4" height="8" fill="#fff"/>
            <rect x="16" y="12" width="4" height="8" fill="#fff"/>
            <rect x="20" y="12" width="4" height="8" fill="#fff"/>
            <rect x="10" y="22" width="2" height="6" fill="#fff"/>
            <rect x="14" y="22" width="2" height="6" fill="#fff"/>
            <rect x="18" y="22" width="2" height="6" fill="#fff"/>
          </svg>
          `),
        scaledSize: new google.maps.Size(32, 32),
        anchor: new google.maps.Point(16, 32)
        }
      });

      var infoWindow = new google.maps.InfoWindow({
        content: `
          <div class="map-popup-card ${hotel.featured === 1 ? 'featured' : ''}">
            <div class="map-popup-image">
              <img src="${assetUrl}assets/img/hotel/logo/${hotel.logo}" alt="${hotel.title}">
              ${hotel.featured === 1 ? '<div class="map-popup-badge">Featured</div>' : ''}
              <button class="map-popup-close" onclick="this.closest('.gm-style-iw-d').parentElement.parentElement.parentElement.remove()">×</button>
            </div>
            <div class="map-popup-content">
              <div class="product_title">
                <h4><a href="/hotel/${hotel.slug}/${hotel.id}">${hotel.title}</a></h4>
              </div>
              
              <div class="rating-capacity-row">
                <div class="rating-info">
                  <i class="fas fa-star"></i>
                  <span>${hotel.average_rating ? parseFloat(hotel.average_rating).toFixed(1) : '0.0'}</span>
                </div>
                <div class="capacity-info">
                  <i class="fas fa-bed"></i>
                  <span>${hotel.total_rooms || 0} Rooms</span>
                </div>
              </div>
              
              ${hotel.amenities && Array.isArray(hotel.amenities) && hotel.amenities.length > 0 ? '<div class="features-list">' + hotel.amenities.slice(0, 3).join(', ') + '</div>' : ''}
              
                              <div class="pricing-info">
                  <div class="price-details">
                   <a href="/venue/${room.hotelSlug}/${room.hotelId}" class="price-text">Check Check Available Rooms</a>
                  </div>
                </div>
            </div>
          </div>
        `
      });

      marker.addListener('click', function () {
        infoWindow.open(map, marker);
      });

      window.mapMarkers.push(marker);
      }
    });
    }
  </script>
  <style>
    body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    background-color: #f7f7f7;
    margin: 0;
    padding: 0;
    }

    .search-header {
    background: #fff;
    border-bottom: 1px solid #e1e1e1;
    position: sticky;
    top: 0;
    z-index: 100;
    }

    .search-main-content {
    min-height: calc(100vh - 200px);
    }

    .search-results-panel {
    height: calc(100vh - 200px);
    overflow-y: auto;
    padding-right: 20px;
    }

    .search-container {
    padding: 20px 0;
    }

    .search-container .row {
    margin: 0 -10px;
    }

    .search-container .col-lg-4 {
    padding: 0 10px;
    margin-bottom: 20px;
    }

    .product-default {
    border: 1px solid #e1e1e1 !important;
    border-radius: 12px !important;
    overflow: hidden !important;
    background: #fff !important;
    transition: all 0.2s ease !important;
    height: 100% !important;
    }

    .product-default:hover {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15) !important;
    transform: translateY(-2px) !important;
    }

    .product_img {
    position: relative !important;
    border-radius: 12px 12px 0 0 !important;
    overflow: hidden !important;
    }

    .product_img img {
    width: 100% !important;
    height: 200px !important;
    object-fit: cover !important;
    transition: transform 0.3s ease !important;
    }

    .product-default:hover .product_img img {
    transform: scale(1.05) !important;
    }

    .product_details {
    /* padding: 16px !important; */
    }

    .product_title h4 {
    font-size: 16px !important;
    font-weight: 600 !important;
    line-height: 1.4 !important;
    margin-bottom: 8px !important;
    color: #000 !important;
    }

    .product_title a {
    color: #000 !important;
    text-decoration: none !important;
    }

    .product_title a:hover {
    color: #666 !important;
    }

    .rating-capacity-row {
    display: ruby !important;
    align-items: center !important;
    gap: 12px !important;
    margin-bottom: 8px !important;
    font-size: 14px !important;
    }

    .rating-info {
    display: flex !important;
    align-items: center !important;
    gap: 4px !important;
    color: #000 !important;
    }

    .rating-info i {
    color: #000 !important;
    font-size: 12px !important;
    }

    .capacity-info {
    display: flex !important;
    align-items: center !important;
    gap: 4px !important;
    color: #666 !important;
    }

    .capacity-info i {
    color: #666 !important;
    font-size: 12px !important;
    }

    .features-list {
    font-size: 13px !important;
    color: #666 !important;
    margin-bottom: 12px !important;
    line-height: 1.4 !important;
    }

    .pricing-info {
    margin-top: 8px !important;
    }

    .price-text {
    font-size: 16px !important;
    font-weight: 600 !important;
    color: #000 !important;
    margin-bottom: 4px !important;
    }

    .price-details {
    font-size: 12px !important;
    color: #666 !important;
    }

    .btn-icon {
    position: absolute !important;
    top: 12px !important;
    right: 12px !important;
    background: rgba(255, 255, 255, 0.9) !important;
    border: 1px solid #e1e1e1 !important;
    color: #666 !important;
    width: 32px !important;
    height: 32px !important;
    border-radius: 50% !important;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    transition: all 0.2s ease !important;
    }

    .btn-icon:hover {
    background: #fff !important;
    color: #000 !important;
    transform: scale(1.1) !important;
    }

    .btn-icon.active {
    background: #ff385c !important;
    border-color: #ff385c !important;
    color: #fff !important;
    }

    .space-select {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    font-size: 14px;
    padding: 8px 12px;
    background-color: #fff;
    transition: all 0.2s ease;
    height: 38px;
    }

    .space-select:focus {
    border-color: #000;
    box-shadow: 0 0 0 2px rgba(0, 0, 0, 0.1);
    outline: none;
    }

    .space-btn {
    border-radius: 6px;
    font-size: 14px;
    padding: 8px 16px;
    font-weight: 500;
    transition: all 0.2s ease;
    height: 38px;
    border: 1px solid #d1d5db;
    background: #fff;
    color: #333;
    }

    .space-btn:hover {
    background: #f8f9fa;
    border-color: #000;
    color: #000;
    }

    .filter-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    }

    .filter-tag {
    background: #fff;
    border: 1px solid #d1d5db;
    border-radius: 20px;
    padding: 6px 16px;
    font-size: 13px;
    color: #333;
    cursor: pointer;
    transition: all 0.2s ease;
    font-weight: 400;
    white-space: nowrap;
    }

    .filter-tag:hover {
    background: #f8f9fa;
    border-color: #000;
    color: #000;
    }

    .filter-tag.active {
    background: #000;
    border-color: #000;
    color: #fff;
    }

    .filter-tag-more {
    background: #fff;
    border: 1px solid #d1d5db;
    border-radius: 20px;
    padding: 6px 12px;
    font-size: 13px;
    color: #666;
    cursor: pointer;
    transition: all 0.2s ease;
    }

    .filter-tag-more:hover {
    background: #f8f9fa;
    border-color: #000;
    color: #000;
    }

    .results-count {
    padding: 8px 16px;
    background: #f8f9fa;
    border-radius: 6px;
    border: 1px solid #e1e1e1;
    }

    .results-text {
    font-size: 14px;
    color: #666;
    font-weight: 400;
    }

    .map-toggle {
    background: #fff;
    padding: 12px 16px;
    border-radius: 6px;
    border: 1px solid #e1e1e1;
    }

    .form-check-input:checked {
    background-color: #000;
    border-color: #000;
    }

    .search-results-panel::-webkit-scrollbar {
    width: 8px;
    }

    .search-results-panel::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 4px;
    }

    .search-results-panel::-webkit-scrollbar-thumb {
    background: #c1c1c1;
    border-radius: 4px;
    }

    .search-results-panel::-webkit-scrollbar-thumb:hover {
    background: #a8a8a8;
    }

    .product-default {
    border-radius: 8px !important;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1) !important;
    transition: all 0.2s ease !important;
    border: 1px solid #e1e1e1 !important;
    background: #fff !important;
    margin-bottom: 20px !important;
    }

    .product-default:hover {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15) !important;
    transform: translateY(-1px) !important;
    }

    .product_img {
    border-radius: 8px 8px 0 0 !important;
    overflow: hidden !important;
    }

    .product_img img {
    border-radius: 8px 8px 0 0 !important;
    width: 100% !important;
    height: 200px !important;
    object-fit: cover !important;
    }

    .product_title h4 {
    font-weight: 600 !important;
    color: #333 !important;
    font-size: 16px !important;
    margin-bottom: 8px !important;
    line-height: 1.3 !important;
    }

    .product_title a {
    color: #333 !important;
    text-decoration: none !important;
    }

    .product_title a:hover {
    color: #000 !important;
    }

    .location {
    color: #666 !important;
    font-size: 14px !important;
    margin-bottom: 8px !important;
    }

    .ratings {
    margin-bottom: 12px !important;
    }

    .ratings span {
    color: #666 !important;
    font-size: 14px !important;
    }

    .product_author {
    margin-bottom: 12px !important;
    }

    .product_author span {
    color: #666 !important;
    font-size: 14px !important;
    font-weight: 500 !important;
    }

    .product-icon_list {
    margin-bottom: 16px !important;
    }

    .product-icon_list li {
    color: #666 !important;
    font-size: 14px !important;
    margin-right: 8px !important;
    }

    .product-price_list {
    display: flex !important;
    flex-wrap: wrap !important;
    gap: 8px !important;
    }

    .product-price_list li {
    background: #f8f9fa !important;
    border-radius: 6px !important;
    padding: 8px 12px !important;
    border: 1px solid #e1e1e1 !important;
    flex: 1 !important;
    min-width: 80px !important;
    text-align: center !important;
    }

    .product-price_list .h6 {
    color: #000 !important;
    font-weight: 600 !important;
    font-size: 16px !important;
    margin-bottom: 2px !important;
    }

    .product-price_list span:last-child {
    color: #666 !important;
    font-size: 12px !important;
    }

    .featured {
    border: 2px solid #000 !important;
    }

    .btn-icon {
    background: rgba(255, 255, 255, 0.9) !important;
    border: 1px solid #e1e1e1 !important;
    color: #666 !important;
    }

    .btn-icon:hover {
    background: #fff !important;
    color: #000 !important;
    }

    .btn-icon.active {
    background: #ff385c !important;
    border-color: #ff385c !important;
    color: #fff !important;
    }

    .rank-star {
    background: rgba(255, 255, 255, 0.9) !important;
    padding: 4px 8px !important;
    border-radius: 4px !important;
    }

    .rank-star i {
    color: #ffd700 !important;
    font-size: 12px !important;
    }

    @media (max-width: 768px) {

    .search-results-panel,
    .search-map {
      height: auto;
      min-height: 400px;
    }

    .search-map {
      height: 400px;
      border-left: none;
      border-top: 1px solid #e1e1e1;
    }

    .filter-tags {
      justify-content: flex-start;
    }

    .search-container .col-lg-4 {
      padding: 0 5px;
      margin-bottom: 15px;
    }
    }

    .row {
    margin: 0 !important;
    }

    .col-lg-7 {
    padding: 0 15px 0 0 !important;
    }

    .col-lg-5 {
    padding: 0 !important;
    }

    .col-md-6 {
    padding: 0 10px !important;
    }

    .p-3.text-center.bg-light.radius-md {
    background: #f8f9fa !important;
    border: 1px solid #e1e1e1 !important;
    border-radius: 8px !important;
    padding: 40px 20px !important;
    }

    .p-3.text-center.bg-light.radius-md h6 {
    color: #666 !important;
    font-weight: 500 !important;
    }

    .filter-bar {
    position: sticky;
    top: 0;
    z-index: 100;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .filter-dropdown {
    min-width: 140px;
    }

    .filter-dropdown .space-select {
    width: 100%;
    min-width: 140px;
    }

    .filter-dropdown .space-btn {
    width: 100%;
    min-width: 140px;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    }

    @media (max-width: 768px) {
    .filter-dropdown {
      min-width: 120px;
    }

    .filter-dropdown .space-select,
    .filter-dropdown .space-btn {
      min-width: 120px;
      font-size: 12px;
      padding: 6px 8px;
    }
    }

    .search-map {
    height: calc(100vh - 200px);
    width: 100%;
    border-left: 1px solid #e1e1e1;
    background: #f5f5f5;
    position: relative;
    min-height: 400px;
    }

    .search-map>div {
    height: 100% !important;
    width: 100% !important;
    }

    /* Map popup price styling */
    .price-info {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-top: 8px;
    padding: 6px 10px;
    background: #f8f9fa;
    border-radius: 6px;
    border: 1px solid #e9ecef;
    }

    .price-info .price {
    font-weight: 600;
    color: #28a745;
    font-size: 14px;
    }

    .price-info .duration {
    color: #6c757d;
    font-size: 12px;
    font-weight: 500;
    }

    /* Enhanced Map popup styling */
    .leaflet-popup-content-wrapper {
    border-radius: 12px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
    border: 1px solid rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(10px);
    }

    .leaflet-popup-content {
    margin: 0;
    padding: 0;
    border-radius: 12px;
    overflow: hidden;
    }

    /* Google Maps InfoWindow custom styling */
    .gm-style .gm-style-iw-c {
    border-radius: 16px !important;
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15) !important;
    border: none !important;
    padding: 0 !important;
    background: transparent !important;
    }

    .gm-style .gm-style-iw-d {
    border-radius: 16px !important;
    overflow: hidden !important;
    background: transparent !important;
    }

    .gm-style .gm-style-iw-t::after {
    background: linear-gradient(45deg, rgba(255,255,255,1) 50%, rgba(255,255,255,0) 51%, rgba(255,255,255,0) 100%) !important;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1) !important;
    }

    /* Remove white header from Google Maps InfoWindow */
    .gm-style .gm-style-iw-t {
    background: transparent !important;
    }

    .gm-style .gm-style-iw-tc {
    background: transparent !important;
    }

    .gm-style .gm-style-iw-tc::after {
    background: transparent !important;
    }

    .gm-style .gm-style-iw-tc::before {
    background: transparent !important;
    }

    /* Hide default close button and header elements */
    .gm-style .gm-style-iw-tc .gm-style-iw-d {
    background: transparent !important;
    }

    .gm-style .gm-style-iw-tc .gm-style-iw-c {
    background: transparent !important;
    }

    /* Remove any white backgrounds from InfoWindow */
    .gm-style .gm-style-iw-c,
    .gm-style .gm-style-iw-d,
    .gm-style .gm-style-iw-t,
    .gm-style .gm-style-iw-tc {
    background: transparent !important;
    }

    /* Ensure content area is transparent */
    .gm-style .gm-style-iw-c > div {
    background: transparent !important;
    }

    /* Modern Map popup card styling - inspired by Google Maps */
    .map-popup-card {
    max-width: 350px;
    border-radius: 12px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
    border: 1px solid #e1e5e9;
    background: #fff;
    overflow: hidden;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    }

    .map-popup-image {
    position: relative;
    height: 200px;
    overflow: hidden;
    background: #f8f9fa;
    }

    .map-popup-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s ease;
    }

    .map-popup-image:hover img {
    transform: scale(1.02);
    }

    .map-popup-badge {
    position: absolute;
    top: 12px;
    right: 12px;
    background: #007bff;
    color: white;
    padding: 6px 10px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: 600;
    box-shadow: 0 2px 8px rgba(0, 123, 255, 0.3);
    }

    .map-popup-status {
    position: absolute;
    top: 12px;
    left: 12px;
    background: #dc3545;
    color: white;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 10px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    }

    .map-popup-content {
    padding: 16px;
    background: #fff;
    }

    .map-popup-title {
    margin: 0 0 8px 0;
    font-size: 18px;
    font-weight: 700;
    color: #1a1a1a;
    line-height: 1.2;
    }

    .map-popup-title a {
    color: #1a1a1a;
    text-decoration: none;
    transition: color 0.2s ease;
    }

    .map-popup-title a:hover {
    color: #007bff;
    }

    .map-popup-subtitle {
    font-size: 14px;
    color: #666;
    margin-bottom: 12px;
    font-weight: 500;
    }

    .map-popup-address {
    font-size: 13px;
    color: #666;
    margin-bottom: 8px;
    line-height: 1.4;
    }

    .map-popup-phone {
    font-size: 13px;
    color: #666;
    margin-bottom: 12px;
    }

    .map-popup-hours {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 16px;
    padding: 8px 12px;
    background: #f8f9fa;
    border-radius: 6px;
    border: 1px solid #e9ecef;
    }

    .map-popup-hours-text {
    font-size: 13px;
    color: #333;
    font-weight: 500;
    }

    .map-popup-hours-link {
    font-size: 13px;
    color: #007bff;
    text-decoration: none;
    font-weight: 500;
    }

    .map-popup-hours-link:hover {
    text-decoration: underline;
    color: #0056b3;
    }

    .map-popup-rating {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
    font-size: 13px;
    color: #666;
    }

    .map-popup-rating-item {
    display: flex;
    align-items: center;
    gap: 4px;
    }

    .map-popup-rating-item i {
    font-size: 12px;
    }

    .map-popup-rating-item .rating-stars {
    color: #ffd700;
    }

    .map-popup-rating-item .rating-score {
    color: #ffc107;
    }

    .map-popup-rooms {
    background: #f8f9fa;
    border-radius: 6px;
    padding: 10px 12px;
    margin-bottom: 12px;
    border: 1px solid #e9ecef;
    }

    .map-popup-rooms-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    }

    .map-popup-rooms-count {
    font-weight: 600;
    color: #28a745;
    font-size: 14px;
    }

    .map-popup-rooms-label {
    color: #6c757d;
    font-size: 12px;
    font-weight: 500;
    }

    .map-popup-location {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 13px;
    color: #666;
    margin-bottom: 16px;
    }

    .map-popup-location i {
    color: #007bff;
    font-size: 12px;
    }

    .map-popup-button {
    display: block;
    width: 100%;
    text-align: center;
    background: #007bff;
    color: white;
    text-decoration: none;
    padding: 12px 16px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 600;
    transition: all 0.2s ease;
    border: none;
    cursor: pointer;
    box-shadow: 0 2px 8px rgba(0, 123, 255, 0.2);
    }

    .map-popup-button:hover {
    background: #0056b3;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
    color: white;
    text-decoration: none;
    }

    .map-popup-button.featured {
    background: #28a745;
    box-shadow: 0 2px 8px rgba(40, 167, 69, 0.2);
    }

    .map-popup-button.featured:hover {
    background: #1e7e34;
    box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
    }

    /* Featured hotel popup styling */
    .map-popup-card.featured {
    border: 2px solid #007bff;
    box-shadow: 0 8px 32px rgba(0, 123, 255, 0.15);
    }

    .map-popup-card.featured .map-popup-badge {
    background: #007bff;
    color: white;
    }

    .product-details {
    padding: 12px;
    }

    .product-title {
    margin-bottom: 8px;
    }

    .product-title a {
    color: #333;
    text-decoration: none;
    font-weight: 600;
    font-size: 14px;
    line-height: 1.3;
    }

    .product-location {
    color: #666;
    font-size: 12px;
    margin-bottom: 8px;
    }

    /* Loading overlay styles */
    .loading-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(255, 255, 255, 0.9);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
    }

    .loading-content {
    text-align: center;
    color: #666;
    }

    .loading-content i {
    font-size: 2rem;
    margin-bottom: 1rem;
    color: #007bff;
    }

    .loading-content p {
    margin: 0;
    font-size: 1rem;
    }

    /* Map bounds indicator */
    .map-bounds-indicator {
    position: absolute;
    top: 10px;
    right: 10px;
    background: rgba(0, 0, 0, 0.7);
    color: white;
    padding: 8px 12px;
    border-radius: 4px;
    font-size: 12px;
    z-index: 1000;
    }

    /* Toggle switch styles */
    .map-filter-toggle {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 8px 12px;
    background: #fff;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    height: 38px;
    }

    .toggle-label {
    font-size: 14px;
    color: #333;
    font-weight: 500;
    white-space: nowrap;
    }

    .toggle-switch {
    position: relative;
    display: inline-block;
    width: 44px;
    height: 24px;
    }

    .toggle-switch input {
    opacity: 0;
    width: 0;
    height: 0;
    }

    .toggle-slider {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #ccc;
    transition: 0.3s;
    border-radius: 24px;
    }

    .toggle-slider:before {
    position: absolute;
    content: "";
    height: 18px;
    width: 18px;
    left: 3px;
    bottom: 3px;
    background-color: white;
    transition: 0.3s;
    border-radius: 50%;
    }

    .toggle-switch input:checked+.toggle-slider {
    background-color: #007bff;
    }

    .toggle-switch input:checked+.toggle-slider:before {
    transform: translateX(20px);
    }

    .toggle-switch input:focus+.toggle-slider {
    box-shadow: 0 0 1px #007bff;
    }

    /* Active toggle state */
    .map-filter-toggle.active {
    border-color: #007bff;
    background-color: #f8f9ff;
    }

    .toggle-label.active {
    color: #007bff !important;
    font-weight: 600;
    }

    /* Room card styling to match original */
    .product-default-style-2 {
    border-radius: 8px !important;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1) !important;
    transition: all 0.2s ease !important;
    border: 1px solid #e1e1e1 !important;
    background: #fff !important;
    overflow: hidden !important;
    }

    .product-default-style-2:hover {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15) !important;
    transform: translateY(-1px) !important;
    }

    .product-default-style-2 .product_img {
    border-radius: 8px 8px 0 0 !important;
    overflow: hidden !important;
    position: relative !important;
    }

    .product-default-style-2 .product_img img {
    width: 100% !important;
    height: 200px !important;
    object-fit: cover !important;
    transition: transform 0.3s ease !important;
    }

    .product-default-style-2:hover .product_img img {
    transform: scale(1.05) !important;
    }

    .product-default-style-2 .product_details {
    padding: 0 !important;
    }

    .product-default-style-2 .product_title h4 {
    font-size: 16px !important;
    font-weight: 600 !important;
    line-height: 1.4 !important;
    margin-bottom: 8px !important;
    color: #000 !important;
    }

    .product-default-style-2 .product_title a {
    color: #000 !important;
    text-decoration: none !important;
    }

    .product-default-style-2 .product_title a:hover {
    color: #666 !important;
    }

    .product-default-style-2 .rating-capacity-row {
    display: flex !important;
    align-items: center !important;
    gap: 12px !important;
    margin-bottom: 8px !important;
    font-size: 14px !important;
    }

    .product-default-style-2 .rating-info {
    display: flex !important;
    align-items: center !important;
    gap: 4px !important;
    color: #000 !important;
    }

    .product-default-style-2 .rating-info i {
    color: #000 !important;
    font-size: 12px !important;
    }

    .product-default-style-2 .capacity-info {
    display: flex !important;
    align-items: center !important;
    gap: 4px !important;
    color: #666 !important;
    }

    .product-default-style-2 .capacity-info i {
    color: #666 !important;
    font-size: 12px !important;
    }

    .product-default-style-2 .features-list {
    font-size: 13px !important;
    color: #666 !important;
    margin-bottom: 12px !important;
    line-height: 1.4 !important;
    }

    .product-default-style-2 .pricing-info {
    margin-top: 8px !important;
    }

    .product-default-style-2 .price-details {
    display: flex !important;
    flex-wrap: wrap !important;
    gap: 8px !important;
    }

    .product-default-style-2 .price-option {
    background: #f8f9fa !important;
    border-radius: 6px !important;
    padding: 8px 12px !important;
    border: 1px solid #e1e1e1 !important;
    font-size: 12px !important;
    color: #000 !important;
    font-weight: 600 !important;
    }

    .product-default-style-2 .price-text {
    font-size: 14px !important;
    color: #666 !important;
    font-style: italic !important;
    }

    .product-default-style-2 .btn-icon {
    position: absolute !important;
    top: 12px !important;
    right: 12px !important;
    background: rgba(255, 255, 255, 0.9) !important;
    border: 1px solid #e1e1e1 !important;
    color: #666 !important;
    width: 32px !important;
    height: 32px !important;
    border-radius: 50% !important;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    transition: all 0.2s ease !important;
    text-decoration: none !important;
    }

    .product-default-style-2 .btn-icon:hover {
    background: #fff !important;
    color: #000 !important;
    transform: scale(1.1) !important;
    }

    .product-default-style-2 .btn-icon.active {
    background: #ff385c !important;
    border-color: #ff385c !important;
    color: #fff !important;
    }
  </style>
@endsection