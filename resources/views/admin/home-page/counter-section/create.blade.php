<div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
  aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">{{ __('Add Counter Information') }}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <form id="ajaxForm" class="modal-form create"
          action="{{ route('admin.pages.store_counter', ['language' => request()->input('language')]) }}"
          method="post">
          @csrf
          <div class="form-group">
            <label for="">{{ __('Language') . '*' }}</label>
            <select name="language_id" class="form-control">
              <option selected disabled>{{ __('Select a Language') }}</option>
              @foreach ($langs as $lang)
                <option value="{{ $lang->id }}">{{ $lang->name }}</option>
              @endforeach
            </select>
            <p id="err_language_id" class="mt-2 mb-0 text-danger em"></p>
          </div>

          <div class="form-group">
            <label for="">{{ __('Client Image') . '*' }}</label>
            <br>
            <div class="thumb-preview">
              <img src="{{ asset('assets/img/noimage.jpg') }}" alt="..." class="uploaded-img">
            </div>

            <div class="mt-3">
              <div role="button" class="btn btn-primary btn-sm upload-btn">
                {{ __('Choose Image') }}
                <input type="file" class="img-input" name="image">
              </div>
            </div>
            <p id="err_image" class="mt-2 mb-0 text-danger em"></p>
          </div>

          <div class="form-group">
            <label for="">{{ __('Amount') . '*' }}</label>
            <input type="text" class="form-control ltr" name="amount" placeholder="{{ __('Enter Amount') }}">
            <p id="err_amount" class="mt-2 mb-0 text-danger em"></p>
          </div>

          <div class="form-group">
            <label for="">{{ __('Title') . '*' }}</label>
            <input type="text" class="form-control" name="title" placeholder="{{ __('Enter Feature Title') }}">
            <p id="err_title" class="mt-2 mb-0 text-danger em"></p>
          </div>
          
          <div class="form-group">
            <label for="">{{ __('Description') }}</label>
            <textarea class="form-control" name="description" rows="3" placeholder="{{ __('Enter Description (Optional)') }}"></textarea>
            <p id="err_description" class="mt-2 mb-0 text-danger em"></p>
          </div>
          
          <div class="form-group">
            <label for="">{{ __('Button Link') }}</label>
            <input type="url" class="form-control" name="button_link" placeholder="{{ __('Enter Button URL (Optional)') }}">
            <p id="err_button_link" class="mt-2 mb-0 text-danger em"></p>
          </div>
          
          <div class="form-group">
            <label for="">{{ __('Serial Number') . '*' }}</label>
            <input type="text" class="form-control" name="serial_number"
              placeholder="{{ __('Enter Serial Number') }}">
            <p id="err_serial_number" class="mt-2 mb-0 text-danger em"></p>
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
