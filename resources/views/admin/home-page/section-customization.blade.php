@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Section Show') . '/' . __('Hide') }}</h4>
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
        <a href="#">{{ __('Section Show') . '/' . __('Hide') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <form action="{{ route('admin.pages.home_page.update_section_status') }}" method="POST">
          @csrf
          <div class="card-header">
            <div class="card-title d-inline-block">{{ __('Section Show') . '/' . __('Hide') }}</div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-6 offset-lg-3">

                <div class="form-group">
                  <label>{{ __('City Section Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="city_section_status" value="1" class="selectgroup-input"
                        {{ $sectionInfo->city_section_status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Enable') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="radio" name="city_section_status" value="0" class="selectgroup-input"
                        {{ $sectionInfo->city_section_status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Disable') }}</span>
                    </label>
                  </div>
                  @error('city_section_status')
                    <p class="mb-0 text-danger">{{ $message }}</p>
                  @enderror
                </div>

                <div class="form-group">
                  <label>{{ __('Featured Section Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="featured_section_status" value="1" class="selectgroup-input"
                        {{ $sectionInfo->featured_section_status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Enable') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="radio" name="featured_section_status" value="0" class="selectgroup-input"
                        {{ $sectionInfo->featured_section_status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Disable') }}</span>
                    </label>
                  </div>
                  @error('featured_section_status')
                    <p class="mb-0 text-danger">{{ $message }}</p>
                  @enderror
                </div>
                @if ($settings->theme_version == 3)
                  <div class="form-group">
                    <label>{{ __('Benifit Section Status') }}</label>
                    <div class="selectgroup w-100">
                      <label class="selectgroup-item">
                        <input type="radio" name="benifit_section_status" value="1" class="selectgroup-input"
                          {{ $sectionInfo->benifit_section_status == 1 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Enable') }}</span>
                      </label>

                      <label class="selectgroup-item">
                        <input type="radio" name="benifit_section_status" value="0" class="selectgroup-input"
                          {{ $sectionInfo->benifit_section_status == 0 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Disable') }}</span>
                      </label>
                    </div>
                    @error('benifit_section_status')
                      <p class="mb-0 text-danger">{{ $message }}</p>
                    @enderror
                  </div>
                @endif

                <div class="form-group">
                  <label>{{ __('Featured Room Section Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="featured_room_section_status" value="1" class="selectgroup-input"
                        {{ $sectionInfo->featured_room_section_status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Enable') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="radio" name="featured_room_section_status" value="0" class="selectgroup-input"
                        {{ $sectionInfo->featured_room_section_status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Disable') }}</span>
                    </label>
                  </div>
                  @error('featured_room_section_status')
                    <p class="mb-0 text-danger">{{ $message }}</p>
                  @enderror
                </div>
                @if ($settings->theme_version != 3)
                  <div class="form-group">
                    <label>{{ __('Counter Section Status') }}</label>
                    <div class="selectgroup w-100">
                      <label class="selectgroup-item">
                        <input type="radio" name="counter_section_status" value="1" class="selectgroup-input"
                          {{ $sectionInfo->counter_section_status == 1 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Enable') }}</span>
                      </label>

                      <label class="selectgroup-item">
                        <input type="radio" name="counter_section_status" value="0" class="selectgroup-input"
                          {{ $sectionInfo->counter_section_status == 0 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Disable') }}</span>
                      </label>
                    </div>
                    @error('counter_section_status')
                      <p class="mb-0 text-danger">{{ $message }}</p>
                    @enderror
                  </div>
                @endif

                <div class="form-group">
                  <label>{{ __('Testimonial Section Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="testimonial_section_status" value="1" class="selectgroup-input"
                        {{ $sectionInfo->testimonial_section_status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Enable') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="radio" name="testimonial_section_status" value="0" class="selectgroup-input"
                        {{ $sectionInfo->testimonial_section_status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Disable') }}</span>
                    </label>
                  </div>
                  @error('testimonial_section_status')
                    <p class="mb-0 text-danger">{{ $message }}</p>
                  @enderror
                </div>

                <div class="form-group">
                  <label>{{ __('Blog Section Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="blog_section_status" value="1" class="selectgroup-input"
                        {{ $sectionInfo->blog_section_status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Enable') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="radio" name="blog_section_status" value="0" class="selectgroup-input"
                        {{ $sectionInfo->blog_section_status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Disable') }}</span>
                    </label>
                  </div>
                  @error('blog_section_status')
                    <p class="mb-0 text-danger">{{ $message }}</p>
                  @enderror
                </div>

                <div class="form-group">
                  <label>{{ __('Call To Action Section Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="call_to_action_section_status" value="1"
                        class="selectgroup-input"
                        {{ $sectionInfo->call_to_action_section_status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Enable') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="radio" name="call_to_action_section_status" value="0"
                        class="selectgroup-input"
                        {{ $sectionInfo->call_to_action_section_status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Disable') }}</span>
                    </label>
                  </div>
                  @error('call_to_action_section_status')
                    <p class="mb-0 text-danger">{{ $message }}</p>
                  @enderror
                </div>

                 @if (count($customSectons) > 0)
                  @foreach ($customSectons as $customSecton)
                    @php
                      $content = App\Models\HomePage\CustomSectionContent::where(
                          'custom_section_id',
                          $customSecton->id,
                      )->first();
                      $customStatus = json_decode($sectionInfo->custom_section_status, true);
                      $sectionStatus = isset($customStatus[$customSecton->id]) ? $customStatus[$customSecton->id] : 0;
                    @endphp
                    <div class="form-group">
                      <label>{{ $content->section_name }} {{ __('Status') }}</label>
                      <div class="selectgroup w-100">
                        <label class="selectgroup-item">
                          <input type="radio" name="custom_section_status[{{ $customSecton->id }}]" value="1"
                            class="selectgroup-input" {{ $sectionStatus == 1 ? 'checked' : '' }}>
                          <span class="selectgroup-button">{{ __('Enable') }}</span>
                        </label>

                        <label class="selectgroup-item">
                          <input type="radio" name="custom_section_status[{{ $customSecton->id }}]" value="0"
                            class="selectgroup-input" {{ $sectionStatus == 0 ? 'checked' : '' }}>
                          <span class="selectgroup-button">{{ __('Disable') }}</span>
                        </label>
                      </div>
                      @error('custom_section_status')
                        <p class="mb-0 text-danger">{{ $message }}</p>
                      @enderror
                    </div>
                  @endforeach
                @endif


              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
@endsection
