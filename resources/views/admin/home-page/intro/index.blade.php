@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Intro Section') }}</h4>
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
        <a href="#">{{ __('Home Page') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Intro Section') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="card-title d-inline-block">{{ __('Intro Section') }}</div>
          <a href="{{ route('admin.pages.home_page.intro.create') }}" class="btn btn-primary float-right">
            <i class="fas fa-plus"></i> {{ __('Add New Intro') }}
          </a>
        </div>
        <div class="card-body">
          @if (count($intros) > 0)
            <div class="table-responsive">
              <table class="table table-striped mt-3">
                <thead>
                  <tr>
                    <th scope="col">{{ __('Image') }}</th>
                    <th scope="col">{{ __('Title') }}</th>
                    <th scope="col">{{ __('Status') }}</th>
                    <th scope="col">{{ __('Created At') }}</th>
                    <th scope="col">{{ __('Actions') }}</th>
                  </tr>
                </thead>
                <tbody>
                  @foreach ($intros as $intro)
                    <tr>
                      <td>
                        @if ($intro->image)
                          <img src="{{ asset('assets/img/intro-section/' . $intro->image) }}" 
                               alt="{{ $intro->title }}" 
                               class="img-thumbnail" 
                               style="max-width: 100px; max-height: 100px;">
                        @else
                          <span class="text-muted">{{ __('No Image') }}</span>
                        @endif
                      </td>
                      <td>{{ $intro->title }}</td>
                      <td>
                        @if ($intro->status == 1)
                          <span class="badge badge-success">{{ __('Active') }}</span>
                        @else
                          <span class="badge badge-danger">{{ __('Inactive') }}</span>
                        @endif
                      </td>
                      <td>{{ $intro->created_at->format('M d, Y') }}</td>
                      <td>
                        <a href="{{ route('admin.pages.home_page.intro.edit', $intro->id) }}" 
                           class="btn btn-sm btn-primary">
                          <i class="fas fa-edit"></i> {{ __('Edit') }}
                        </a>
                        <form action="{{ route('admin.pages.home_page.intro.delete', $intro->id) }}" 
                              method="POST" 
                              class="d-inline" 
                              onsubmit="return confirm('{{ __('Are you sure you want to delete this intro section?') }}')">
                          @csrf
                          <button type="submit" class="btn btn-sm btn-danger">
                            <i class="fas fa-trash"></i> {{ __('Delete') }}
                          </button>
                        </form>
                      </td>
                    </tr>
                  @endforeach
                </tbody>
              </table>
            </div>
          @else
            <div class="text-center py-4">
              <p class="text-muted">{{ __('No intro sections found.') }}</p>
              <a href="{{ route('admin.pages.home_page.intro.create') }}" class="btn btn-primary">
                <i class="fas fa-plus"></i> {{ __('Create First Intro Section') }}
              </a>
            </div>
          @endif
        </div>
      </div>
    </div>
  </div>
@endsection 