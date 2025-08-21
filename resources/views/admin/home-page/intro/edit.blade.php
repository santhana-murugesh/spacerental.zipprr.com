@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Edit Intro Section') }}</h4>
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
        <a href="#">{{ __('Edit') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="card-title d-inline-block">{{ __('Edit Intro Section') }}</div>
          <a href="{{ route('admin.pages.home_page.intro.index') }}" class="btn btn-secondary float-right">
            <i class="fas fa-arrow-left"></i> {{ __('Back to List') }}
          </a>
        </div>
        <div class="card-body">
          <form action="{{ route('admin.pages.home_page.intro.update', $intro->id) }}" method="POST" enctype="multipart/form-data">
            @csrf
            @method('POST')
            
            <div class="form-group">
              <label for="title">{{ __('Title') }}</label>
              <input type="text" class="form-control" id="title" name="title"
                     placeholder="{{ __('Enter title') }}" value="{{ old('title', $intro->title) }}">
              @error('title')
                <p class="mb-0 text-danger">{{ $message }}</p>
              @enderror
            </div>
            
            <div class="form-group">
              <label for="image">{{ __('Image') }}</label>
              @if ($intro->image)
                <div class="mb-2">
                  <img src="{{ asset('assets/img/intro-section/' . $intro->image) }}" 
                       alt="{{ $intro->title }}" 
                       class="img-thumbnail" 
                       style="max-width: 200px; max-height: 200px;">
                  <p class="text-muted">{{ __('Current Image') }}</p>
                </div>
              @endif
              <input type="file" class="form-control-file" id="image" name="image">
              <small class="form-text text-muted">{{ __('Leave empty to keep current image. Supported formats: JPEG, PNG, JPG, GIF, SVG. Max size: 2MB') }}</small>
              @error('image')
                <p class="mb-0 text-danger">{{ $message }}</p>
              @enderror
            </div>
            
            <div class="form-group">
              <label for="status">{{ __('Status') }}</label>
              <select class="form-control" id="status" name="status">
                <option value="1" {{ old('status', $intro->status) == 1 ? 'selected' : '' }}>{{ __('Active') }}</option>
                <option value="0" {{ old('status', $intro->status) == 0 ? 'selected' : '' }}>{{ __('Inactive') }}</option>
              </select>
              @error('status')
                <p class="mb-0 text-danger">{{ $message }}</p>
              @enderror
            </div>
            
            <div class="form-group">
              <button type="submit" class="btn btn-primary">{{ __('Update') }}</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
@endsection 