@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Quick Links') }}</h4>
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
        <a href="#">{{ __('Footer') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Quick Links') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="d-flex gap-10 flex-wrap align-items-center justify-content-between">

            <div class="card-title d-inline-block">{{ __('Quick Links') }}</div>

            <div class="d-flex gap-10 flex-wrap align-items-center">
              <a href="#" class="btn btn-sm btn-primary float-lg-right float-left" data-toggle="modal"
                data-target="#createModal"><i class="fas fa-plus"></i> {{ __('Add') }}</a>
            </div>

          </div>
        </div>

        <div class="card-body">
          <div class="row">
            <div class="col-lg-12">
              @if (count($quickLinks) == 0)
                <h3 class="text-center mt-2">{{ __('NO QUICK LINK FOUND') . '!' }}</h3>
              @else
                <div class="table-responsive">
                  <table class="table table-striped mt-3" id="basic-datatables">
                    <thead>
                      <tr>
                        <th scope="col">#</th>
                        <th scope="col">{{ __('Title') }}</th>
                        <th scope="col">{{ __('URL') }}</th>
                        <th scope="col">{{ __('Serial Number') }}</th>
                        <th scope="col">{{ __('Actions') }}</th>
                      </tr>
                    </thead>
                    <tbody>
                      @foreach ($quickLinks as $quickLink)
                        <tr>
                          <td>{{ $loop->iteration }}</td>
                          <td>{{ $quickLink->title }}</td>
                          <td>{{ $quickLink->url }}</td>
                          <td>{{ $quickLink->serial_number }}</td>
                          <td>
                            <a class="editBtn btn btn-secondary mt-1 btn-sm mr-1" href="#" data-toggle="modal"
                              data-target="#editModal" data-id="{{ $quickLink->id }}"
                              data-title="{{ $quickLink->title }}" data-url="{{ $quickLink->url }}"
                              data-serial_number="{{ $quickLink->serial_number }}">
                              <span class="btn-label">
                                <i class="fas fa-edit"></i>
                              </span>
                            </a>

                            <form class="deleteForm d-inline-block"
                              action="{{ route('admin.pages.footer.delete_quick_link', ['id' => $quickLink->id]) }}"
                              method="post">
                              @csrf
                              <button type="submit" class="btn btn-danger mt-1 btn-sm deleteBtn">
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
      </div>
    </div>
  </div>

  {{-- create modal --}}
  @include('admin.footer.quick-link.create')

  {{-- edit modal --}}
  @include('admin.footer.quick-link.edit')
@endsection
