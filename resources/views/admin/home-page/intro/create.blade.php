@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Create Intro Section') }}</h4>
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
        <a href="{{ route('admin.pages.home_page.intro.index') }}">{{ __('Intro Section') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Create') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="card-title d-inline-block">{{ __('Create Intro Section') }}</div>
          <a href="{{ route('admin.pages.home_page.intro.index') }}" class="btn btn-secondary float-right">
            <i class="fas fa-arrow-left"></i> {{ __('Back to List') }}
          </a>
        </div>
        <div class="card-body">
          <form action="{{ route('admin.pages.home_page.intro.store') }}" method="POST" enctype="multipart/form-data">
            @csrf
            <div class="form-group">
              <label for="title">{{ __('Title') }}</label>
              <input type="text" class="form-control" id="title" name="title"
              placeholder="{{ __('Enter title') }}" value="{{ old('title') }}">
              </div>
              <div class="form-group">
                <label for="description">{{ __('Image') }}</label>
                <input type="file" class="form-control-file" id="image" name="image">
                </div>
                <div class="form-group">
                  <label for="description">{{ __('status') }}</label>
                  <select class="form-control" id="status" name="status">
                    <option value="1" {{ old('status') == 1 ? 'selected' :
                    '' }}>{{ __('Active') }}</option>
                    <option value="0" {{ old('status') == 0 ? 'selected' :
                    '' }}>{{ __('Inactive') }}</option>
                    </select>
                    </div>

            
            <div class="form-group">
              <button type="submit" class="btn btn-primary">{{ __('Create') }}</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
@endsection 