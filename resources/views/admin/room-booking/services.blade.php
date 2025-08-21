<!-- Modal -->
<div class="modal fade additionalServiceModal" id="additionalServiceModal" tabindex="-1" role="dialog"
  aria-labelledby="additionalServiceModal" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h2 class="modal-title">{{ __('Selected Services') }}</h2>
        <button type="button" class="close additionalServiceModalclose" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered">
          <thead>
            <tr>
              <th scope="col">{{ __('Service') }}</th>
              <th scope="col">{{ __('Price') }}</th>
            </tr>
          </thead>
          <tbody>
            @php
              $sl = 1;
            @endphp

            @foreach ($additional_services as $service)
              <tr>
                <td>
                  @if(is_array($service))
                    {{ $service['name'] ?? $service['title'] ?? 'Unknown Service' }}
                  @else
                    {{ $service->name ?? $service->title ?? $service->service_name ?? 'Unknown Service' }}
                  @endif
                </td>
                <td>
                  @if(is_array($service))
                    {{ $service['price'] ?? $service['charge'] ?? 0 }}
                  @else
                    {{ $service->price ?? $service->charge ?? 0 }}
                  @endif
                  {{ $details->currency_symbol }}
                </td>
              </tr>
            @endforeach
          </tbody>
        </table>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger px-3" data-dismiss="modal">{{ __('Close') }}</button>
      </div>
    </div>
  </div>
</div>
