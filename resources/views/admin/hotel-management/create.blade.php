@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Add Room') }}</h4>
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
        <a href="#">{{ __('Rooms Management') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Manage Rooms') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Add Room') }}</a>
      </li>
    </ul>
  </div>

  @php
    $vendorId = $vendor_id;

    if ($vendorId == 0) {
        $numberoffImages = 99999999;
        $can_hotel_add = 1;
    } else {
        if ($vendorId) {
            $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);

            if ($current_package != '[]') {
                $numberoffImages = $current_package->number_of_images_per_hotel;
            } else {
                $numberoffImages = 0;
            }
        } else {
            $permissions = null;
            $numberoffImages = 0;
        }
    }

  @endphp


  <div class="row">
    <div class="col-md-12">
      @if ($vendorId != 0)
        @if ($current_package != '[]')
          @if (vendorTotalAddedHotel($vendorId) >= $current_package->number_of_hotel)
            <div class="alert alert-warning">
              {{ __("You can't add more Room. Please buy/extend a plan to add Room") }}
            </div>
            @php
              $can_hotel_add = 2;
            @endphp
          @else
            @php
              $can_hotel_add = 1;
            @endphp
          @endif
        @else
          @php
            $pendingMemb = \App\Models\Membership::query()
                ->where([['vendor_id', '=', Auth::id()], ['status', 0]])
                ->whereYear('start_date', '<>', '9999')
                ->orderBy('id', 'DESC')
                ->first();
            $pendingPackage = isset($pendingMemb)
                ? \App\Models\Package::query()->findOrFail($pendingMemb->package_id)
                : null;
          @endphp
          @if ($pendingPackage)
            <div class="alert alert-warning">
              {{ __('You have requested a package which needs an action (Approval / Rejection) by Admin. You will be notified via mail once an action is taken.') }}
            </div>
            <div class="alert alert-warning">
              <strong>{{ __('Pending Package') . ':' }} </strong> {{ $pendingPackage->title }}
              <span class="badge badge-secondary">{{ $pendingPackage->term }}</span>
              <span class="badge badge-warning">{{ __('Decision Pending') }}</span>
            </div>
          @else
            @php
              $newMemb = \App\Models\Membership::query()
                  ->where([['vendor_id', '=', Auth::id()], ['status', 0]])
                  ->first();
            @endphp
            @if ($newMemb)
              <div class="alert alert-warning">
                {{ __('Your membership is expired. Please purchase a new package / extend the current package.') }}
              </div>
            @endif
            <div class="alert alert-warning">
              {{ __('Please purchase a new package to add Room.') }}
            </div>
          @endif
          @php
            $can_hotel_add = 0;
          @endphp
        @endif
      @endif
      <div class="card">
        <div class="card-header">
          <div class="card-title d-inline-block">{{ __('Add Room') }}</div>
        </div>
        <div class="card-body">

          <div class="row">
            <div class="col-lg-10 offset-lg-1">


              <div class="alert alert-danger pb-1 dis-none" id="hotelErrors">
                <ul></ul>
              </div>
              <div class="col-lg-12">
                <label for="" class="mb-2"><strong>{{ __('Gallery Images') . '*' }}</strong></label>
                <form action="{{ route('admin.hotel_management.hotel.imagesstore') }}" id="my-dropzone"
                  enctype="multipart/formdata" class="dropzone create">
                  @csrf
                  <div class="fallback">
                    <input name="file" type="file" multiple />
                  </div>
                </form>
                <p class="em text-danger mb-0" id="errslider_images"></p>
                @if ($vendorId != 0)
                  @if ($current_package != '[]')
                    @if (vendorTotalAddedHotel($vendorId) <= $current_package->number_of_hotel)
                      <p class="text-warning">
                        {{ __('You can upload maximum') }}{{ __(' ') }}
                        {{ $current_package->number_of_images_per_hotel }}{{ __(' ') }}{{ __('images under one hotel') }}
                      </p>
                    @endif
                  @endif
                @endif
              </div>

              <form id="hotelForm" action="{{ route('admin.hotel_management.store_hotel') }}" method="POST"
                enctype="multipart/form-data">
                @csrf
                <div class="row">
                  <div class="col-lg-4">
                    <div class="form-group">
                      <label for="">{{ __('Room Logo') . '*' }}</label>
                      <br>
                      <div class="thumb-preview">
                        <img src="{{ asset('assets/img/noimage.jpg') }}" alt="..." class="uploaded-img2">
                      </div>

                      <div class="mt-3">
                        <div role="button" class="btn btn-primary btn-sm upload-btn">
                          {{ __('Choose Image') }}
                          <input type="file" class="img-input2" name="logo">
                        </div>
                      </div>
                      <p class="mt-2 mb-0 text-warning">{{ __('Image Size 300X300') }}</p>
                    </div>
                  </div>
                  <div class="col-lg-4">
                    <div class="form-group">
                      <label>{{ __('Status') . '*' }} </label>
                      <select name="status" id="status" class="form-control">
                        <option value="1">{{ __('Active') }}</option>
                        <option selected value="0">{{ __('Deactive') }} </option>
                      </select>
                    </div>
                  </div>
                  <div class="col-lg-4">
                    <div class="form-group">
                      <label>{{ __('Stars') . '*' }} </label>
                      <select name="stars" class="form-control">
                        <option selected disabled>{{ __('Select a star') }}</option>
                        <option value="1">{{ __('1 ★') }}</option>
                        <option value="2">{{ __('2 ★★') }}</option>
                        <option value="3">{{ __('3 ★★★') }}</option>
                        <option value="4">{{ __('4 ★★★★') }}</option>
                        <option value="5">{{ __('5 ★★★★★') }}</option>
                      </select>
                    </div>
                  </div>

                  @if ($settings->google_map_api_key_status == 0)
                    <div class="col-lg-4">
                      <div class="form-group">
                        <label>{{ __('Latitude' . '*') }}</label>
                        <input type="text" class="form-control" id="latitude" name="latitude"
                          placeholder="{{ __('Enter Latitude') }}">
                      </div>
                      <p class="text-warning pl-10">
                        {{ __('The Latitude must be between -90 to 90. Ex:49.43453') }}
                      </p>
                    </div>

                    <div class="col-lg-4">
                      <div class="form-group">
                        <label>{{ __('Longitude' . '*') }}</label>
                        <input type="text" id="longitude" class="form-control" name="longitude"
                          placeholder="{{ __('Enter Longitude') }}">
                      </div>
                      <p class="text-warning pl-10">
                        {{ __('The Longitude must be between -180 to 180. Ex:149.91553') }}
                      </p>
                    </div>
                  @endif
                  <input type="hidden" name="vendor_id" id=""value="{{ $vendorId }}">
                  <input type="hidden" name="can_hotel_add" value="{{ $can_hotel_add }}">
                </div>
                <div class="row">
                    <div class="col-lg-12">
                      <div class="form-group">
                        <label><strong>{{ __('Booking Time Slots') }}</strong></label>
                        <div class="table-responsive">
                          <table class="table table-bordered" id="time-slots-table">
                            <thead>
                              <tr>
                                <th width="15%">{{ __('Day') }}</th>
                                <th>{{ __('Time Slots') }}</th>
                                <th width="15%">{{ __('Actions') }}</th>
                              </tr>
                            </thead>
                            <tbody>
                              @php
                                $days = [
                                  'monday' => __('Monday'),
                                  'tuesday' => __('Tuesday'),
                                  'wednesday' => __('Wednesday'),
                                  'thursday' => __('Thursday'),
                                  'friday' => __('Friday'),
                                  'saturday' => __('Saturday'),
                                  'sunday' => __('Sunday')
                                ];
                              @endphp
                              
                              @foreach($days as $key => $day)
                              <tr data-day="{{ $key }}" class="day-row">
                                <td>
                                  {{ $day }}
                                  <span class="badge badge-danger closed-badge" style="display:none;">{{ __('Closed') }}</span>
                                </td>
                                <td class="time-slots-container">
                                  <div class="time-slot-row mb-2">
                                    <div class="row">
                                      <div class="col-md-5">
                                        <input type="time" class="form-control start-time" name="{{ $key }}_slots[0][start]" value="10:00">
                                      </div>
                                      <div class="col-md-1 text-center">-</div>
                                      <div class="col-md-5">
                                        <input type="time" class="form-control end-time" name="{{ $key }}_slots[0][end]" value="18:30">
                                      </div>
                                      <div class="col-md-1">
                                        <button type="button" class="btn btn-sm btn-danger remove-slot">
                                          <i class="fas fa-times"></i>
                                        </button>
                                      </div>
                                    </div>
                                  </div>
                                </td>
                                <td>
                                  <div class="btn-group btn-group-sm" role="group">
                                    <button type="button" class="btn btn-primary add-slot" data-day="{{ $key }}" title="{{ __('Add Time Slot') }}">
                                      <i class="fas fa-plus"></i>
                                    </button>
                                    <button type="button" class="btn btn-warning toggle-closed" data-day="{{ $key }}" title="{{ __('Mark as Closed') }}">
                                      <span class="bi bi-x-circle"></span>
                                    </button>
                                  </div>
                                  <input type="hidden" name="{{ $key }}_closed" value="0" class="closed-input">
                                </td>
                              </tr>
                              @endforeach
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                <div id="accordion" class="mt-3">
                  @foreach ($languages as $language)
                    <div class="version">
                      <div class="version-header" id="heading{{ $language->id }}">
                        <h5 class="mb-0">
                          <button type="button" class="btn btn-link" data-toggle="collapse"
                            data-target="#collapse{{ $language->id }}"
                            aria-expanded="{{ $language->is_default == 1 ? 'true' : 'false' }}"
                            aria-controls="collapse{{ $language->id }}">
                            {{ $language->name . __(' Language') }}
                            {{ $language->is_default == 1 ? '(Default)' : '' }}
                          </button>
                        </h5>
                      </div>

                      <div id="collapse{{ $language->id }}"
                        class="collapse {{ $language->is_default == 1 ? 'show' : '' }}"
                        aria-labelledby="heading{{ $language->id }}" data-parent="#accordion">
                        <div class="version-body {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                          <div class="row">
                            <div class="col-lg-6">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Title') . '*' }} </label>
                                <input type="text" class="form-control" name="{{ $language->code }}_title"
                                  placeholder="{{ __('Enter Title') }}">
                              </div>
                            </div>

                            <div class="col-lg-6">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                @php
                                  $categories = App\Models\HotelCategory::where('language_id', $language->id)
                                      ->where('status', 1)
                                      ->orderBy('serial_number', 'asc')
                                      ->get();
                                @endphp
                                <label>{{ __('Category') . '*' }}</label>
                                <select name="{{ $language->code }}_category_id"
                                  class="form-control js-example-basic-single2">
                                  <option selected disabled>{{ __('Select a Category') }}</option>

                                  @foreach ($categories as $category)
                                    <option value="{{ $category->id }}">{{ $category->name }}</option>
                                  @endforeach
                                </select>
                              </div>
                            </div>
                            @php
                              $Countries = App\Models\Location\Country::where('language_id', $language->id)->get();
                              $totalCountry = $Countries->count();
                            @endphp

                            @if ($totalCountry > 0)
                              <div class="col-lg-4">
                                <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">

                                  <label>{{ __('Country') . '*' }}</label>
                                  <select name="{{ $language->code }}_country_id"
                                    class="form-control js-example-basic-single3" data-code="{{ $language->code }}">
                                    <option selected disabled>{{ __('Select Country') }}</option>
                                    @foreach ($Countries as $Country)
                                      <option value="{{ $Country->id }}">{{ $Country->name }}</option>
                                    @endforeach
                                  </select>
                                </div>
                              </div>
                            @endif

                            @php
                              $States = App\Models\Location\State::where('language_id', $language->id)->get();
                              $totalState = $States->count();
                            @endphp

                            @if ($totalState > 0)
                              <div class="col-lg-4 {{ $language->code }}_hide_state">
                                <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">

                                  <label>{{ __('State') . '*' }}</label>
                                  <select name="{{ $language->code }}_state_id"
                                    class="form-control js-example-basic-single4 {{ $language->code }}_country_state_id"data-code="{{ $language->code }}">
                                    <option selected disabled>{{ __('Select State') }}</option>

                                    @foreach ($States as $State)
                                      <option value="{{ $State->id }}">{{ $State->name }}</option>
                                    @endforeach
                                  </select>
                                </div>
                              </div>
                            @endif

                            @php
                              $cities = App\Models\Location\City::where('language_id', $language->id)->get();
                            @endphp

                            <div class="col-lg-4">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">

                                <label>{{ __('City') . '*' }}</label>
                                <select name="{{ $language->code }}_city_id"
                                  class="form-control js-example-basic-single5 {{ $language->code }}_state_city_id">
                                  <option selected disabled>{{ __('Select a City') }}</option>

                                  @foreach ($cities as $City)
                                    <option value="{{ $City->id }}">{{ $City->name }}</option>
                                  @endforeach
                                </select>
                              </div>
                            </div>

                            <div class="col-lg-12">
                              <div class="form-group">
                                <label>{{ __('Address') . '*' }}</label>
                                <input type="text" class="form-control"
                                  value="{{ old($language->code . '_address') }}" name="{{ $language->code }}_address"
                                  placeholder="{{ __('Enter Address') }}" id="search-address">
                                @if ($language->is_default == 1 && $settings->google_map_api_key_status == 1)
                                  <a href="" class="btn btn-secondary mt-2 btn-sm" data-toggle="modal"
                                    data-target="#GoogleMapModal">
                                    <i class="fas fa-eye"></i> {{ __('Show Map') }}
                                  </a>
                                @endif
                              </div>
                            </div>

                            @if ($language->is_default == 1 && $settings->google_map_api_key_status == 1)
                              <div class="col-lg-6">
                                <div class="form-group">
                                  <label>{{ __('Latitude' . '*') }}</label>
                                  <input type="text" class="form-control" id="latitude" name="latitude"
                                    placeholder="{{ __('Enter Latitude') }}">
                                </div>
                                <p class="text-warning pl-10">
                                  {{ __('The Latitude must be between -90 to 90. Ex:49.43453') }}
                                </p>
                              </div>

                              <div class="col-lg-6">
                                <div class="form-group">
                                  <label>{{ __('Longitude' . '*') }}</label>
                                  <input type="text" id="longitude" class="form-control" name="longitude"
                                    placeholder="{{ __('Enter Longitude') }}">
                                </div>
                                <p class="text-warning pl-10">
                                  {{ __('The Longitude must be between -180 to 180. Ex:149.91553') }}
                                </p>
                              </div>
                            @endif

                            @php
                              $aminities = App\Models\Amenitie::where('language_id', $language->id)->get();
                            @endphp
                            @if (count($aminities) > 0)
                              <div class="col-lg-12">
                                <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">

                                  <label>{{ __('Select Amenities') . '*' }} </label>
                                  <div class="dropdown-content" id="checkboxes">
                                    @foreach ($aminities as $amenity)
                                      <input type="checkbox" id="{{ $amenity->id }}"
                                        name="{{ $language->code }}_aminities[]" value="{{ $amenity->id }}">
                                      <label
                                        class="amenities-label {{ $language->direction == 1 ? 'ml-2 mr-0' : 'mr-2' }}"
                                        for="{{ $amenity->id }}">{{ $amenity->title }}</label>
                                    @endforeach
                                  </div>
                                </div>
                              </div>
                            @endif

                          </div>

                          <div class="row">
                            <div class="col-lg-12">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Description') . '*' }}</label>
                                <textarea id="{{ $language->code }}_description" class="form-control summernote"
                                  name="{{ $language->code }}_description" data-height="300"></textarea>
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="col-lg-12">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Meta Keywords') }}</label>
                                <input class="form-control" name="{{ $language->code }}_meta_keyword"
                                  placeholder="{{ __('Enter Meta Keywords') }}" data-role="tagsinput">
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="col-lg-12">
                              <div class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                <label>{{ __('Meta Description') }}</label>
                                <textarea class="form-control" name="{{ $language->code }}_meta_description" rows="5"
                                  placeholder="{{ __('Enter Meta Description') }}"></textarea>
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="col">
                              @php $currLang = $language; @endphp

                              @foreach ($languages as $language)
                                @continue($language->id == $currLang->id)

                                <div class="form-check py-0">
                                  <label class="form-check-label">
                                    <input class="form-check-input" type="checkbox"
                                      onchange="cloneInput('collapse{{ $currLang->id }}', 'collapse{{ $language->id }}', event)">
                                    <span class="form-check-sign">{{ __('Clone for') }} <strong
                                        class="text-capitalize text-secondary">{{ $language->name }}</strong>
                                      {{ __('language') }}</span>
                                  </label>
                                </div>
                              @endforeach
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  @endforeach
                </div>
                <div id="sliders">
                </div>
              </form>
            </div>
          </div>
        </div>

        <div class="card-footer">
          <div class="row">
            <div class="col-12 text-center">
              <button type="submit" form="hotelForm" data-can_hotel_add="{{ $can_hotel_add }}"
                class="btn btn-success">
                {{ __('Save') }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  {{-- Google map modal --}}
  <!-- Modal -->
  <div class="modal fade" id="GoogleMapModal" tabindex="-1" role="dialog"
    aria-labelledby="GoogleMapModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="GoogleMapModalLongTitle">{{ __('Google Map') }}</h5>
          <div>
            <button type="button" class="btn btn-secondary btn-xs" data-dismiss="modal">{{ __('Choose') }}</button>
            <button type="button" class="btn btn-danger btn-xs" data-dismiss="modal">X</button>
          </div>
        </div>
        <div class="modal-body">
          <div id="map"></div>
        </div>
      </div>
    </div>
  </div>
@endsection
<style>
.time-slot-row {
  position: relative;
}
.remove-slot {
  position: absolute;
  right: 0;
  top: 0;
}
.day-closed {
  background-color: #fff8f8;
}
.day-closed .time-slot-row {
  opacity: 0.5;
}
.closed-badge {
  display: none;
  margin-left: 10px;
}
.day-closed .closed-badge {
  display: inline-block;
}
</style>
@section('script')
  @if ($settings->google_map_api_key_status == 1)
    <script src="{{ asset('assets/admin/js/map-init2.js') }}"></script>
    <script
      src="https://maps.googleapis.com/maps/api/js?key={{ $settings->google_map_api_key }}&libraries=places&callback=initMap"
      async defer></script>
  @endif
  <script>
    'use strict';
    var storeUrl = "{{ route('admin.hotel_management.hotel.imagesstore') }}";
    var removeUrl = "{{ route('admin.hotel_management.hotel.imagermv') }}";
    var getStateUrl = "{{ route('admin.hotel_management.get-state') }}";
    var getCityUrl = "{{ route('admin.hotel_management.get-city') }}";
    var galleryImages = {{ $numberoffImages }};
    var languages = {!! json_encode($languages) !!};
  </script>

  <script type="text/javascript" src="{{ asset('assets/admin/js/admin-hotel.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/admin/js/admin-dropzone.js') }}"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
  <script>
  $(document).ready(function() {
  $(document).on('click', '.add-slot', function(e) {
    e.preventDefault();
    var day = $(this).data('day');
    var row = $(this).closest('.day-row');
    
    if (row.hasClass('day-closed')) {
      row.removeClass('day-closed');
      row.find('.closed-input').val('0');
      row.find('.closed-badge').hide();
    }
    
    var container = row.find('.time-slots-container');
    var slotCount = container.find('.time-slot-row').length;
    
    var newSlot = `
      <div class="time-slot-row mb-2">
        <div class="row">
          <div class="col-md-5">
            <input type="time" class="form-control start-time" name="${day}_slots[${slotCount}][start]" value="10:00">
          </div>
          <div class="col-md-1 text-center">-</div>
          <div class="col-md-5">
            <input type="time" class="form-control end-time" name="${day}_slots[${slotCount}][end]" value="18:30">
          </div>
          <div class="col-md-1">
            <button type="button" class="btn btn-sm btn-danger remove-slot">
              <i class="fas fa-times"></i>
            </button>
          </div>
        </div>
      </div>
    `;
    
    container.append(newSlot);
  });

  // Remove time slot
  $(document).on('click', '.remove-slot', function(e) {
    e.preventDefault();
    var slotRow = $(this).closest('.time-slot-row');
    var day = slotRow.closest('.day-row').data('day');
    
    slotRow.remove();
    
    // If no slots left, mark as closed
    var container = slotRow.closest('.time-slots-container');
    if (container.find('.time-slot-row').length === 0) {
      var row = slotRow.closest('.day-row');
      row.addClass('day-closed');
      row.find('.closed-input').val('1');
      row.find('.closed-badge').show();
    } else {
      // Reindex remaining slots
      container.find('.time-slot-row').each(function(index) {
        $(this).find('.start-time').attr('name', `${day}_slots[${index}][start]`);
        $(this).find('.end-time').attr('name', `${day}_slots[${index}][end]`);
      });
    }
  });

  // Toggle closed state
  $(document).on('click', '.toggle-closed', function(e) {
    e.preventDefault();
    var row = $(this).closest('.day-row');
    var day = row.data('day');
    var container = row.find('.time-slots-container');
    var closedInput = row.find('.closed-input');
    var closedBadge = row.find('.closed-badge');
    
    if (row.hasClass('day-closed')) {
      // Unmark as closed
      row.removeClass('day-closed');
      closedInput.val('0');
      closedBadge.hide();
      
      // If no slots exist, add a default one
      if (container.find('.time-slot-row').length === 0) {
        container.html(`
          <div class="time-slot-row mb-2">
            <div class="row">
              <div class="col-md-5">
                <input type="time" class="form-control start-time" name="${day}_slots[0][start]" value="10:00">
              </div>
              <div class="col-md-1 text-center">-</div>
              <div class="col-md-5">
                <input type="time" class="form-control end-time" name="${day}_slots[0][end]" value="18:30">
              </div>
              <div class="col-md-1">
                <button type="button" class="btn btn-sm btn-danger remove-slot">
                  <i class="fas fa-times"></i>
                </button>
              </div>
            </div>
          </div>
        `);
      }
    } else {
      // Mark as closed
      row.addClass('day-closed');
      closedInput.val('1');
      closedBadge.show();
    }
  });
});
  </script>
@endsection
