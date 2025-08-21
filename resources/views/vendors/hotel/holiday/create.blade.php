<div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
  aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">{{ __('Add Holiday') }}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <form id="ajaxForm" class="modal-form create" action="{{ route('vendor.hotel_management.hotel.holiday.store') }}"
          method="post">
          <input type="hidden" name="staff_id" value="{{ request()->id }}">
          <input type="hidden" name="vendor_id" value="{{ request()->vendor_id }}">
          @csrf
          <div class="form-group">
            <label for="">{{ __('Room') . '*' }}</label>
            <select name="hotel_id" class="form-control js-example-basic-single2">
              <option selected disabled>{{ __('Select a Room') }}</option>
              @foreach ($hotels as $hotel)
                <option value="{{ $hotel->id }}">{{ $hotel->title }}</option>
              @endforeach
            </select>
            <p id="err_hotel_id" class="mt-1 mb-0 text-danger em"></p>
          </div>
          <div class="form-group">
            <label for="">{{ __('Room') . '*' }}</label>
            <select name="room_id" class="form-control js-example-basic-single2">
              <option selected disabled>{{ __('Select a Room') }}</option>
              @foreach ($rooms as $room)
                <option value="{{ $room->id }}">{{ $room->title }}</option>
              @endforeach
            </select>
            <p id="err_room_id" class="mt-1 mb-0 text-danger em"></p>
          </div>

          <div class="form-group">
            <label for="">{{ __('Date') . '*' }}</label>
            <input type="text" name="date" class="form-control datepicker" placeholder="{{ __('Choose date') }}"
              autocomplete="off">
            <p id="err_date" class="mt-1 mb-0 text-danger em"></p>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">
          {{ __('Close') }}
        </button>
        <button id="submitBtn" type="button" class="btn btn-primary btn-sm">
          {{ __('Save') }}
        </button>
      </div>
    </div>
  </div>
</div>
