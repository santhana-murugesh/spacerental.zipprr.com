@extends('admin.layout')

@section('content')
<div class="page-header">
    <h4 class="page-title">{{ __('Edit Custom Pricing') }}</h4>
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
            <a href="">{{ __('Custom Pricing') }}</a>
        </li>
        <li class="separator">
            <i class="flaticon-right-arrow"></i>
        </li>
        <li class="nav-item">
            <a href="#">{{ __('Edit') }}</a>
        </li>
    </ul>
</div>

<div class="card">
    <div class="card-body">
        <form action="{{ route('vendor.custom.pricing.update', $customPricing->id) }}" method="POST">
            @csrf
            @method('PUT')
            <div class="row">
                <div class="col-md-6">
                <div class="form-group">
                <label>{{ __('Select Room') }}</label>
                <select class="form-control" name="hotel_id" required>
                    @foreach($hotels as $hotel)
                        <option value="{{ $hotel->id }}" {{ $hotel->id == $customPricing->hotel_id ? 'selected' : '' }}>
                            @if(isset($hotel->hotel_contents[0]->title))
                                {{ $hotel->hotel_contents[0]->title }}
                            @else
                                Untitled Hotel #{{ $hotel->id }}
                            @endif
                        </option>
                    @endforeach
                </select>
            </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>{{ __('Select Room') }}</label>
                        <select class="form-control" name="room_id" required>
                            @foreach($room_contents as $content)
                                <option value="{{ $content->room_id }}" 
                                    {{ $content->room_id == $customPricing->room_id ? 'selected' : '' }}>
                                    {{ $content->title }}
                                </option>
                            @endforeach
                        </select>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>{{ __('Date') }}</label>
                        <input type="date" class="form-control" name="date" value="{{ $customPricing->date }}" required>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>{{ __('Hour') }}</label>
                        <select class="form-control" name="booking_hours_id" required>
                            @foreach($hourlyPrices as $price)
                                <option value="{{ $price->id }}" {{ $price->id == $customPricing->booking_hours_id ? 'selected' : '' }}>
                                    {{ $price->hour }} hours
                                </option>
                            @endforeach
                        </select>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>{{ __('Price') }}</label>
                        <input type="number" step="0.01" class="form-control" name="price" value="{{ $customPricing->price }}" required>
                    </div>
                </div>
            </div>

            <div class="text-right">
                <a href="{{ route('admin.custom_pricing', ['language' => $defaultLang->code]) }}" class="btn btn-secondary">{{ __('Cancel') }}</a>
                <button type="submit" class="btn btn-primary">{{ __('Update') }}</button>
            </div>
        </form>
    </div>
</div>
@endsection
