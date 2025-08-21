{{-- language modal start --}}
<div class="modal fade" id="addModaladmin" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
  aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">{{ __('Add Keyword for admin') }}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <form id="ajaxForm3" action="{{ route('admin.settings.language_management.add_keyword_admin') }}" method="POST">
          @csrf
          <div class="form-group">
            <label for="">{{ __('Keyword') . '*' }}</label>
            <input type="text" class="form-control" name="keyword" placeholder="{{ __('Enter Keyword') }}">
            <p id="err_keyword" class="mt-1 mb-0 text-danger em"></p>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">
          {{ __('Close') }}
        </button>
        <button id="submitBtn3" type="button" class="btn btn-primary btn-sm">
          {{ __('Submit') }}
        </button>
      </div>
    </div>
  </div>
</div>

{{-- language modal start end --}}
