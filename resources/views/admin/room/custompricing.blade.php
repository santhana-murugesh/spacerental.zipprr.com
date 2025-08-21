@extends('admin.layout')

@section('content')
<div class="page-header">
    <h4 class="page-title">{{ __('Add Custom Pricing') }}</h4>
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
        <a href="#">{{ __('Add Custom Pricing') }}</a>
      </li>
    </ul>
  </div>

  <div class="card">
    <div class="card-header">
      <div class="row">
        <div class="col-md-4 col-lg-4">
          <div class="card-title d-inline-block">{{ __('Custom Pricing') }}</div>
        </div>
        <div class="col-md-4 col-lg-4 mt-3 mt-lg-0">
          
        </div>
        <div class="col-md-3 col-lg-4 mt-3 mt-lg-0">
          <div class="btn-groups d-flex justify-content-md-end gap-10">
            <a class="btn btn-info btn-sm d-inline-block" href="#" data-toggle="modal"
              data-target="#createModal">
              <span class="btn-label">
                <i class="fas fa-plus"></i>
              </span>
              {{ __('Add Custom Pricing') }}
            </a>
            <button class="btn btn-danger btn-sm d-none bulk-delete"
              data-href="{{ route('admin.global.holiday.bluk-destroy') }}">
              <i class="flaticon-interface-5"></i> {{ __('Delete') }}
            </button>
          </div>
        </div>
      </div>
    </div>
    <div class="card-body">
      <div class="row">
        <div class="col-lg-12">
          @if (count($customPricings) == 0)
            <h3 class="text-center mt-2">{{ __('NO CUSTOM PRICING FOUND') . '!' }}</h3>
          @else
          <div class="table-responsive">
            <table class="table table-striped mt-3" id="basic-datatables">
              <thead>
                <tr>
                  <th scope="col">
                    <input type="checkbox" class="bulk-check" data-val="all">
                  </th>
                  <th scope="col">{{ __('Hotel') }}</th>
                  <th scope="col">{{ __('Room') }}</th>
                  <th scope="col">{{ __('Vendor') }}</th>
                  <th scope="col">{{ __('Date') }}</th>
                  <th scope="col">{{ __('Hours & Pricing') }}</th>
                  <th scope="col">{{ __('Actions') }}</th>
                </tr>
              </thead>
              <tbody>
                @php
                    $groupedPricings = $customPricings->groupBy(function($item) {
                    return $item->date . '-' . $item->hotel_id . '-' . $item->room_id;
                    });
                @endphp
                
                @foreach($groupedPricings as $group => $pricings)
                    @php
                    $firstPricing = $pricings->first();
                    @endphp
                    <tr>
                    <td>
                        <input type="checkbox" class="bulk-check" data-val="{{ $firstPricing->id }}">
                    </td>
                    <td>{{ $firstPricing->hotel_title }}</td>
                    <td>{{ $firstPricing->room_title }}</td>
                    <td>
                        @if($firstPricing->vendor_id == 0)
                            <span class="badge badge-primary">{{ __('Admin') }}</span>
                        @else
                            @php
                                $vendor = App\Models\Vendor::find($firstPricing->vendor_id);
                            @endphp
                            @if($vendor)
                                <span class="badge badge-info">{{ $vendor->username }}</span>
                            @else
                                <span class="badge badge-warning">{{ __('Unknown') }}</span>
                            @endif
                        @endif
                    </td>
                    <td>{{ \Carbon\Carbon::parse($firstPricing->date)->format('d-m-Y') }}</td>
                    <td>
                        @foreach($pricings as $pricing)
                            @if($pricing->bookingHour)
                                {{ $pricing->bookingHour->hour }}hr-{{ $pricing->price }}{{ !$loop->last ? ', ' : '' }}
                            @else
                            @endif
                        @endforeach
                    </td>
                    <div class="dropdown">
                        
                        <td>
                          <div class="dropdown">
                              <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" 
                                  id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" 
                                  aria-expanded="false">
                                  {{ __('Select') }}
                              </button>
                              <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                  @foreach($pricings as $pricing)
                                      @if($pricing->bookingHour) 
                                          <div class="dropdown-item d-flex justify-content-between align-items-center">
                                              <a href="{{ route('admin.custom.pricing.edit', $pricing->id) }}" class="text-dark">
                                                  Edit {{ $pricing->bookingHour->hour }}hr
                                              </a>
                                              <a href="{{ route('admin.custom.pricing.destroy.single', $pricing->id) }}" 
                                                class="text-danger delete-hour" 
                                                data-href=""
                                                title="{{ __('Delete') }}">
                                                  <i class="fas fa-trash"></i>
                                              </a>
                                          </div>
                                      @endif
                                  @endforeach
                              </div>
                          </div>
                      </td>
                    </td>
                    </tr>
                @endforeach
                </tbody>
            </table>
          </div>
          @endif
        </div>
      </div>
    </div>
  </div>
  
  <!-- Create Modal -->
  <div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">{{ __('Add Custom Pricing') }}</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <form action="{{ route('admin.custom.pricing.store') }}" method="POST">
          @csrf
          <div class="modal-body">
            <div class="row">
              <div class="col-md-6">
                <div class="form-group">
                  <label>{{ __('Select Room') }}</label>
                  <select class="form-control" name="hotel_id" id="hotel_id" required>
                    <option value="" selected disabled>{{ __('Select Room') }}</option>
                    @foreach($hotels as $hotel)
                      <option value="{{ $hotel->id }}">{{ $hotel->title }}</option>
                    @endforeach
                  </select>
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <label>{{ __('Select Room') }}</label>
                  <select class="form-control" name="room_id" id="room_id" required>
                    <option value="" selected disabled>{{ __('Select Room') }}</option>
                    @foreach($room_contents as $content)
                      @if($content->room)
                        <option value="{{ $content->room_id }}" data-hotel="{{ $content->room->room_id }}" class="room-option">
                          {{ $content->title }}
                        </option>
                      @endif
                    @endforeach
                  </select>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <div class="form-group">
                  <label>{{ __('Date') }}</label>
                  <input type="date" class="form-control" name="date" required>
                </div>
              </div>
            </div>
            
            <div class="row">
              <div class="col-md-12">
                <h5>{{ __('Set Pricing for Different Hours') }}</h5>
                <div class="row">
                  @foreach($hourlyPrices as $price)
                  <div class="col-md-4 col-sm-6">
                    <div class="form-group">
                      <label>Rent for {{ $price->hour }} {{ __('hours') }}</label>
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <span class="input-group-text"></span>
                        </div>
                        <input type="number" step="0.01" class="form-control" 
                               name="prices[{{ $price->id }}]" 
                               placeholder="{{ __('Enter price ') }}">
                      </div>
                    </div>
                  </div>
                  @endforeach
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ __('Close') }}</button>
            <button type="submit" class="btn btn-primary">{{ __('Save Changes') }}</button>
          </div>
        </form>
      </div>
    </div>
  </div>

 <!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">{{ __('Edit Custom Pricing') }}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form action="" method="put">
        @csrf
        <input type="hidden" name="id" id="edit_id">
        <div class="modal-body">
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label>{{ __('Select Room') }}</label>
                <select class="form-control" name="hotel_id" id="edit_hotel_id" required>
                  <option value="" disabled>{{ __('Select Room') }}</option>
                  @foreach($hotels as $hotel)
                    <option value="{{ $hotel->id }}">{{ $hotel->title }}</option>
                  @endforeach
                </select>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label>{{ __('Select Room') }}</label>
                <select class="form-control" name="room_id" id="edit_room_id" required>
                  <option value="" disabled>{{ __('Select Room') }}</option>
                  @foreach($room_contents as $content)
                    @if($content->room)
                      <option value="{{ $content->room_id }}" data-hotel="{{ $content->room->hotel_id }}" class="room-option">
                        {{ $content->title }}
                      </option>
                    @endif
                  @endforeach
                </select>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label>{{ __('Date') }}</label>
                <input type="date" class="form-control" name="date" id="edit_date" required>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label>{{ __('Hour') }}</label>
                <select class="form-control" name="booking_hours_id" id="edit_booking_hours_id" required>
                  @foreach($hourlyPrices as $price)
                    <option value="{{ $price->id }}">{{ $price->hour }} hours</option>
                  @endforeach
                </select>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label>{{ __('Price') }}</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"></span>
                  </div>
                  <input type="number" step="0.01" class="form-control" value="{{ $price }}" name="price" id="edit_price" required>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ __('Close') }}</button>
          <button type="submit" class="btn btn-primary">{{ __('Update') }}</button>
        </div>
      </form>
    </div>
  </div>
</div>
@endsection

@push('scripts')
  <script>
    $(document).ready(function() {
      $('#hotel_id').change(function() {
        var hotelId = $(this).val();
        $('#room_id option').each(function() {
          if($(this).data('hotel') == hotelId || hotelId == '') {
            $(this).show();
          } else {
            $(this).hide();
          }
        });
        $('#room_id').val('');
      });

      $('#edit_hotel_id').change(function() {
        var hotelId = $(this).val();
        $('#edit_room_id option').each(function() {
          if($(this).data('hotel') == hotelId || hotelId == '') {
            $(this).show();
          } else {
            $(this).hide();
          }
        });
      });

      $('.editbtn').on('click', function() {
        const id = $(this).data('id');
        const hotel_id = $(this).data('hotel_id');
        const room_id = $(this).data('room_type_id');
        const date = $(this).data('date');
        const booking_hours_id = $(this).data('booking_hours_id');
        const price = $(this).data('price');
        
        $('#edit_id').val(id);
        $('#edit_hotel_id').val(hotel_id);
        $('#edit_room_id').val(room_id);
        $('#edit_date').val(date);
        $('#edit_booking_hours_id').val(booking_hours_id);
        $('#edit_price').val(price);
        
        $('#edit_hotel_id').trigger('change');
      });

      $('.dltbtn').click(function(e) {
        e.preventDefault();
        var href = $(this).data('href');
        swal({
          title: 'Are you sure?',
          text: "You won't be able to revert this!",
          type: 'warning',
          buttons: {
            cancel: {
              visible: true,
              text: 'No, cancel!',
              className: 'btn btn-danger'
            },
            confirm: {
              text: 'Yes, delete it!',
              className: 'btn btn-success'
            }
          }
        }).then((willDelete) => {
          if (willDelete) {
            window.location.href = href;
          }
        });
      });
    });
  </script>
@endpush