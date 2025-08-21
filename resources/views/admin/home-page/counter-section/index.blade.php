@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Counters') }}</h4>
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
        <a href="#">{{ __('Pages') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Common Sections') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Counters') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">

    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="row">
            <div class="col-lg-4">
              <div class="card-title">{{ __('Counters') }}</div>
            </div>

            <div class="col-lg-3">
            </div>

            <div class="col-lg-4 offset-lg-1 mt-2 mt-lg-0">
              <a href="#" data-toggle="modal" data-target="#createModal"
                class="btn btn-primary btn-sm float-lg-right float-left"><i class="fas fa-plus"></i>
                {{ __('Add') }}</a>

              <button class="btn btn-danger btn-sm float-right mr-2 d-none bulk-delete"
                data-href="{{ route('admin.pages.bulk_delete_counter') }}">
                <i class="flaticon-interface-5"></i> {{ __('Delete') }}
              </button>
            </div>
          </div>
        </div>

        <div class="card-body">
          <div class="row">
            <div class="col">
              @if (count($counters) == 0)
                <h3 class="text-center mt-2">{{ __('NO INFORMATION FOUND') . '!' }}</h3>
              @else
                <div class="table-responsive">
                  <table class="table table-striped mt-3" id="basic-datatables">
                    <thead>
                      <tr>
                        <th scope="col">
                          <input type="checkbox" class="bulk-check" data-val="all">
                        </th>
                        <th scope="col">{{ __('Image') }}</th>
                        <th scope="col">{{ __('Amount') }}</th>
                        <th scope="col">{{ __('Title') }}</th>
                        <th scope="col">{{ __('Description') }}</th>
                        <th scope="col">{{ __('Button Link') }}</th>
                        <th scope="col">{{ __('Serial Number') }}</th>
                        <th scope="col">{{ __('Actions') }}</th>
                      </tr>
                    </thead>
                    <tbody>
                      @foreach ($counters as $counter)
                        <tr>
                          <td>
                            <input type="checkbox" class="bulk-check" data-val="{{ $counter->id }}">
                          </td>
                          <td>
                            @if (is_null($counter->image))
                              -
                            @else
                              <img src="{{ asset('assets/img/counter/' . $counter->image) }}" alt="client image"
                                width="45">
                            @endif
                          </td>
                          <td>{{ $counter->amount }}</td>
                          <td>
                            {{ strlen($counter->title) > 20 ? mb_substr($counter->title, 0, 20, 'UTF-8') . '...' : $counter->title }}
                          </td>
                          <td>
                            @if($counter->description)
                              {{ strlen($counter->description) > 30 ? mb_substr($counter->description, 0, 30, 'UTF-8') . '...' : $counter->description }}
                            @else
                              <span class="text-muted">-</span>
                            @endif
                          </td>
                          <td>
                            @if($counter->button_link)
                              <a href="{{ $counter->button_link }}" target="_blank" class="text-primary">
                                {{ strlen($counter->button_link) > 25 ? mb_substr($counter->button_link, 0, 25, 'UTF-8') . '...' : $counter->button_link }}
                              </a>
                            @else
                              <span class="text-muted">-</span>
                            @endif
                          </td>
                          <td>
                            {{ $counter->serial_number }}
                          </td>
                          <td>
                            <a class="btn btn-secondary btn-sm mr-1  mt-1 editBtn" href="#" data-toggle="modal"
                              data-target="#editModal" data-id="{{ $counter->id }}"
                              data-image="{{ is_null($counter->image) ? asset('assets/img/noimage.jpg') : asset('assets/img/counter/' . $counter->image) }}"
                              data-serial_number="{{ $counter->serial_number }}" data-amount="{{ $counter->amount }}"
                              data-title="{{ $counter->title }}" data-description="{{ $counter->description }}" data-button_link="{{ $counter->button_link }}">
                              <span class="btn-label">
                                <i class="fas fa-edit"></i>
                              </span>
                            </a>

                            <form class="deleteForm d-inline-block"
                              action="{{ route('admin.pages.delete_counter', ['id' => $counter->id]) }}" method="post">
                              @csrf
                              <button type="submit" class="btn btn-danger btn-sm  mt-1 deleteBtn">
                                <span class="btn-label">
                                  <i class="fas fa-trash"></i>
                                </span>
                              </button>
                            </form>
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

        <div class="card-footer"></div>
      </div>
    </div>
  </div>

  {{-- create modal --}}
  @include('admin.home-page.counter-section.create')

  {{-- edit modal --}}
  @include('admin.home-page.counter-section.edit')
@endsection

@section('scripts')
<script>
  $(document).ready(function() {
    // Handle edit button click to populate edit modal
    $('.editBtn').on('click', function() {
      var id = $(this).data('id');
      var image = $(this).data('image');
      var serial_number = $(this).data('serial_number');
      var amount = $(this).data('amount');
      var title = $(this).data('title');
      var description = $(this).data('description');
      var button_link = $(this).data('button_link');
      
      $('#in_id').val(id);
      $('.in_image').attr('src', image);
      $('#in_serial_number').val(serial_number);
      $('#in_amount').val(amount);
      $('#in_title').val(title);
      $('#in_description').val(description);
      $('#in_button_link').val(button_link);
    });
  });
</script>
@endsection
