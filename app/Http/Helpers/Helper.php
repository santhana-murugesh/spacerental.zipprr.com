<?php

use App\Http\Helpers\VendorPermissionHelper;
use App\Models\Advertisement;
use App\Models\BasicSettings\Basic;
use App\Models\Booking;
use App\Models\Hotel;
use App\Models\HotelWishlist;
use App\Models\HourlyRoomPrice;
use App\Models\Language;
use App\Models\Membership;
use App\Models\PaymentGateway\OnlineGateway;
use App\Models\Room;
use App\Models\RoomReview;
use App\Models\RoomWishlist;
use App\Models\Transaction;
use Illuminate\Support\Carbon;

if (!function_exists('createSlug')) {
  function createSlug($string)
  {
    $slug = preg_replace('/\s+/u', '-', trim($string));
    $slug = str_replace('/', '', $slug);
    $slug = str_replace('?', '', $slug);
    $slug = str_replace(',', '', $slug);

    return mb_strtolower($slug);
  }
}
if (!function_exists('make_input_name')) {
  function make_input_name($string)
  {
    return preg_replace('/\s+/u', '_', trim($string));
  }
}

if (!function_exists('replaceBaseUrl')) {
  function replaceBaseUrl($html, $type)
  {
    $startDelimiter = 'src=""';
    if ($type == 'summernote') {
      $endDelimiter = '/assets/img/summernote';
    } elseif ($type == 'pagebuilder') {
      $endDelimiter = '/assets/img';
    }

    $startDelimiterLength = strlen($startDelimiter);
    $endDelimiterLength = strlen($endDelimiter);
    $startFrom = $contentStart = $contentEnd = 0;

    while (false !== ($contentStart = strpos($html, $startDelimiter, $startFrom))) {
      $contentStart += $startDelimiterLength;
      $contentEnd = strpos($html, $endDelimiter, $contentStart);

      if (false === $contentEnd) {
        break;
      }

      $html = substr_replace($html, url('/'), $contentStart, $contentEnd - $contentStart);
      $startFrom = $contentEnd + $endDelimiterLength;
    }

    return $html;
  }
}

if (!function_exists('setEnvironmentValue')) {
  function setEnvironmentValue(array $values)
  {
    $envFile = app()->environmentFilePath();
    $str = file_get_contents($envFile);

    if (count($values) > 0) {
      foreach ($values as $envKey => $envValue) {
        $keyPosition = strpos($str, "{$envKey}=");
        $endOfLinePosition = strpos($str, "\n", $keyPosition);
        $oldLine = substr($str, $keyPosition, $endOfLinePosition - $keyPosition);

        // If key does not exist, add it
        if (!$keyPosition || !$endOfLinePosition || !$oldLine) {
          $str .= "{$envKey}={$envValue}\n";
        } else {
          $str = str_replace($oldLine, "{$envKey}={$envValue}", $str);
        }
      }
    }

    if (!file_put_contents($envFile, $str)) return false;

    return true;
  }
}

if (!function_exists('showAd')) {
  function showAd($resolutionType)
  {
    $ad = Advertisement::where('resolution_type', $resolutionType)->inRandomOrder()->first();
    $adsenseInfo = Basic::query()->select('google_adsense_publisher_id')->first();

    if (!is_null($ad)) {
      if ($resolutionType == 1) {
        $maxWidth = '300px';
        $maxHeight = '250px';
      } else if ($resolutionType == 2) {
        $maxWidth = '300px';
        $maxHeight = '600px';
      } else {
        $maxWidth = '728px';
        $maxHeight = '90px';
      }

      if ($ad->ad_type == 'banner') {
        $markUp = '<a href="' . url($ad->url) . '" target="_blank" onclick="adView(' . $ad->id . ')" class="ad-banner">
          <img data-src="' . asset('assets/img/advertisements/' . $ad->image) . '" alt="advertisement" style="width: ' . $maxWidth . '; height: ' . $maxHeight . ';" class="lazyload blur-up">
        </a>';
        return $markUp;
      } else {
        $markUp = '<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=' . $adsenseInfo->google_adsense_publisher_id . '" crossorigin="anonymous"></script>
        <ins class="adsbygoogle" style="display: block;" data-ad-client="' . $adsenseInfo->google_adsense_publisher_id . '" data-ad-slot="' . $ad->slot . '" data-ad-format="auto" data-full-width-responsive="true"></ins>
        <script>
          (adsbygoogle = window.adsbygoogle || []).push({});
        </script>';

        return $markUp;
      }
    } else {
      return;
    }
  }
}

if (!function_exists('onlyDigitalItemsInCart')) {
  function onlyDigitalItemsInCart()
  {
    $cart = session()->get('productCart');
    if (!empty($cart)) {
      foreach ($cart as $key => $cartItem) {
        if ($cartItem['type'] != 'digital') {
          return false;
        }
      }
    }
    return true;
  }
}

if (!function_exists('onlyDigitalItems')) {
  function onlyDigitalItems($order)
  {

    $oitems = $order->orderitems;
    foreach ($oitems as $key => $oitem) {

      if ($oitem->item->type != 'digital') {
        return false;
      }
    }

    return true;
  }
}

if (!function_exists('get_href')) {
  function get_href($data)
  {
    $link_href = '';

    if ($data->type == 'home') {
      $link_href = route('index');
    } else if ($data->type == 'rooms') {
      $link_href = route('frontend.rooms');
    } else if ($data->type == 'pricing') {
      $link_href = route('frontend.pricing');
    } else if ($data->type == 'hotels') {
      $link_href = route('frontend.hotels');
    } else if ($data->type == 'blog') {
      $link_href = route('blog');
    } else if ($data->type == 'faq') {
      $link_href = route('faq');
    } else if ($data->type == 'contact') {
      $link_href = route('contact');
    } else if ($data->type == 'about-us') {
      $link_href = route('about_us');
    } else if ($data->type == 'custom') {
      /**
       * this menu has created using menu-builder from the admin panel.
       * this menu will be used as drop-down or to link any outside url to this system.
       */
      if ($data->href == '') {
        $link_href = '#';
      } else {
        $link_href = $data->href;
      }
    } else {
      // this menu is for the custom page which has been created from the admin panel.
      $link_href = route('dynamic_page', ['slug' => $data->type]);
    }

    return $link_href;
  }
}

if (!function_exists('format_price')) {
  function format_price($value): string
  {
    if (session()->has('lang')) {
      $currentLang = Language::where('code', session()
        ->get('lang'))
        ->first();
    } else {
      $currentLang = Language::where('is_default', 1)
        ->first();
    }
    $bs = Basic::first();
    if ($bs->base_currency_symbol_position == 'left') {
      return $bs->base_currency_symbol . $value;
    } else {
      return $value . $bs->base_currency_symbol;
    }
  }
}

if (!function_exists('symbolPrice')) {
  function symbolPrice($price)
  {
    $basic = Basic::where('uniqid', 12345)->select('base_currency_symbol_position', 'base_currency_symbol')->first();
    if ($basic->base_currency_symbol_position == 'left') {
      $data = $basic->base_currency_symbol . round($price, 2);
      return str_replace(' ', '', $data);
    } elseif ($basic->base_currency_symbol_position == 'right') {
      $data = round($price, 2) . $basic->base_currency_symbol;
      return str_replace(' ', '', $data);
    }
  }
}

if (!function_exists('checkHotelWishList')) {
  function checkHotelWishList($hotel_id, $user_id)
  {
    $check = HotelWishlist::where('hotel_id', $hotel_id)
      ->where('user_id', $user_id)
      ->first();
    if ($check) {
      return true;
    } else {
      return false;
    }
  }
}
if (!function_exists('checkroomWishList')) {
  function checkroomWishList($room_id, $user_id)
  {
    $check = RoomWishlist::where('room_id', $room_id)
      ->where('user_id', $user_id)
      ->first();
    if ($check) {
      return true;
    } else {
      return false;
    }
  }
}


if (!function_exists('vendorTotalAddedHotel')) {
  function vendorTotalAddedHotel($vendor_id)
  {
    if ($vendor_id != 0) {
      $total = Hotel::where('vendor_id', $vendor_id)->get()->count();
    } else {
      $total = 1;
    }
    return $total;
  }
}
if (!function_exists('vendorTotalAddedRoom')) {
  function vendorTotalAddedRoom($vendor_id)
  {
    if ($vendor_id != 0) {
      $total = Room::where('vendor_id', $vendor_id)->get()->count();
    } else {
      $total = 1;
    }
    return $total;
  }
}
if (!function_exists('vendorTotalAddedRoom')) {
  function vendorTotalAddedRoom($vendor_id)
  {
    if ($vendor_id != 0) {
      $total = Room::where('vendor_id', $vendor_id)->get()->count();
    } else {
      $total = 1;
    }
    return $total;
  }
}



if (!function_exists('packageTotalHotelAmenities')) {
  function packageTotalHotelAmenities($vendor_id)
  {
    $current_package = VendorPermissionHelper::packagePermission($vendor_id);
    $AmenitiesLimit = $current_package->number_of_amenities_per_hotel;

    return $AmenitiesLimit;
  }
}
if (!function_exists('packageTotalRoomAmenities')) {
  function packageTotalRoomAmenities($vendor_id)
  {
    $current_package = VendorPermissionHelper::packagePermission($vendor_id);
    $AmenitiesLimit = $current_package->number_of_amenities_per_room;

    return $AmenitiesLimit;
  }
}



if (!function_exists('vendorTotalBooking')) {
  function vendorTotalBooking($vendor_id)
  {
    if ($vendor_id != 0) {
      $currentPackage = Membership::query()->where([
        ['vendor_id', '=', $vendor_id],
        ['status', '=', 1],
        ['start_date', '<=', Carbon::now()->format('Y-m-d')],
        ['expire_date', '>=', Carbon::now()->format('Y-m-d')]
      ])->first();
      $membershipId = $vendor_id != 0 ? ($currentPackage ? $currentPackage->id : null) : 0;

      $vendorTotalBooking = Booking::where('vendor_id', $vendor_id)
        ->where('membership_id', $membershipId)
        ->where('payment_status', '!=', '2')
        ->count();
    } else {
      $vendorTotalBooking = 1;
    }
    return $vendorTotalBooking;
  }
}
if (!function_exists('vendorTotalBookingInPackage')) {
  function vendorTotalBookingInPackage($vendor_id)
  {
    if ($vendor_id != 0) {
      $current_package = VendorPermissionHelper::packagePermission($vendor_id);
      $totalBooking = $current_package->number_of_bookings;
    } else {
      $totalBooking = 999999;
    }
    return $totalBooking;
  }
}


if (!function_exists('currentPackageFeatures')) {
  function currentPackageFeatures($vendor_id)
  {
    $current_package = VendorPermissionHelper::packagePermission($vendor_id);
    $Features = $current_package->features;

    return $Features;
  }
}


if (!function_exists('packageTotalHotel')) {
  function packageTotalHotel($vendor_id)
  {
    $current_package = VendorPermissionHelper::packagePermission($vendor_id);
    $hotelCanAdd = $current_package->number_of_hotel;

    return $hotelCanAdd;
  }
}
if (!function_exists('packageTotalRoom')) {
  function packageTotalRoom($vendor_id)
  {
    $current_package = VendorPermissionHelper::packagePermission($vendor_id);
    $roomCanAdd = $current_package->number_of_room;

    return $roomCanAdd;
  }
}


if (!function_exists('packageTotalHotelImage')) {
  function packageTotalHotelImage($vendor_id)
  {
    $current_package = VendorPermissionHelper::packagePermission($vendor_id);
    $hotelImageLimit = $current_package->number_of_images_per_hotel;

    return $hotelImageLimit;
  }
}
if (!function_exists('packageTotalRoomImage')) {
  function packageTotalRoomImage($vendor_id)
  {
    $current_package = VendorPermissionHelper::packagePermission($vendor_id);
    $hotelImageLimit = $current_package->number_of_images_per_room;

    return $hotelImageLimit;
  }
}

if (!function_exists('store_transaction')) {
  function store_transaction($data)
  {
    Transaction::create([
      'transcation_id' => time(),
      'booking_id' => $data['booking_id'],
      'transcation_type' => $data['transcation_type'],
      'user_id' => $data['user_id'],
      'vendor_id' => $data['vendor_id'],
      'payment_status' => $data['payment_status'],
      'payment_method' => $data['payment_method'],
      'grand_total' => $data['grand_total'],
      'commission' => $data['vendor_id'] != null ? $data['commission'] : $data['grand_total'],
      'pre_balance' => $data['pre_balance'],
      'after_balance' => $data['after_balance'],
      'gateway_type' => $data['gateway_type'],
      'currency_symbol' => $data['currency_symbol'],
      'currency_symbol_position' => $data['currency_symbol_position'],
    ]);
  }
}

if (!function_exists('editBookingPermission')) {
  function editBookingPermission($vendor_id)
  {
    if ($vendor_id != 0) {
      $current_package = VendorPermissionHelper::packagePermission($vendor_id);

      if ($current_package != '[]') {
        $permissions = $current_package->features;
        $permissions = json_decode($permissions, true);
      } else {
        return false;
      }

      if (is_array($permissions) && in_array('Edit Booking From Dashboard', $permissions)) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}
if (!function_exists('addBookingPermission')) {
  function addBookingPermission($vendor_id)
  {
    if ($vendor_id != 0) {
      $current_package = VendorPermissionHelper::packagePermission($vendor_id);

      if ($current_package != '[]') {
        $permissions = $current_package->features;
        $permissions = json_decode($permissions, true);
      } else {
        return false;
      }

      if (is_array($permissions) && in_array('Add Booking From Dashboard', $permissions)) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}
if (!function_exists('supportTicketsPermission')) {
  function supportTicketsPermission($vendor_id)
  {
    if ($vendor_id != 0) {
      $current_package = VendorPermissionHelper::packagePermission($vendor_id);

      if ($current_package != '[]') {
        $permissions = $current_package->features;
        $permissions = json_decode($permissions, true);
        if (is_array($permissions) && in_array('Support Tickets', $permissions)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}
if (!function_exists('paytabInfo')) {
  function paytabInfo()
  {
    // Could please connect me with a support.who can tell me about live api and test api's Payment url ? Now, I am using this https://secure-global.paytabs.com/payment/request url for testing puporse. Is it work for my live api ???
    // paytabs informations
    $paytabs = OnlineGateway::where('keyword', 'paytabs')->first();
    $paytabsInfo = json_decode($paytabs->information, true);
    if ($paytabsInfo['country'] == 'global') {
      $currency = 'USD';
    } elseif ($paytabsInfo['country'] == 'sa') {
      $currency = 'SAR';
    } elseif ($paytabsInfo['country'] == 'uae') {
      $currency = 'AED';
    } elseif ($paytabsInfo['country'] == 'egypt') {
      $currency = 'EGP';
    } elseif ($paytabsInfo['country'] == 'oman') {
      $currency = 'OMR';
    } elseif ($paytabsInfo['country'] == 'jordan') {
      $currency = 'JOD';
    } elseif ($paytabsInfo['country'] == 'iraq') {
      $currency = 'IQD';
    } else {
      $currency = 'USD';
    }
    return [
      'server_key' => $paytabsInfo['server_key'],
      'profile_id' => $paytabsInfo['profile_id'],
      'url'        => $paytabsInfo['api_endpoint'],
      'currency'   => $currency,
    ];
  }
}
if (!function_exists('totalHotelReview')) {
  function totalHotelReview($hotel_id)
  {
    $totalReview = RoomReview::Where('hotel_id', $hotel_id)->count();

    return $totalReview;
  }
}
if (!function_exists('totalHotelBooking')) {
  function totalHotelBooking($hotel_id)
  {
    $totalReview = Booking::where('hotel_id', $hotel_id)
      ->where('payment_status', '!=', 2)
      ->count();

    return $totalReview;
  }
}

if (!function_exists('totalHotelRoom')) {
  function totalHotelRoom($hotel_id)
  {
    $totalReview = Room::where('hotel_id', $hotel_id)
      ->where('status', 1)
      ->count();

    return $totalReview;
  }
}

if (!function_exists('totalRoomReview')) {
  function totalRoomReview($room_id)
  {
    $totalReview = RoomReview::Where('room_id', $room_id)->count();

    return $totalReview;
  }
}

if (!function_exists('hotelMaxPrice')) {
  function hotelMaxPrice($hotel_id)
  {
    $maxPrice = HourlyRoomPrice::Where('hotel_id', $hotel_id)->max('price');
    if ($maxPrice) {
      return $maxPrice;
    } else {
      return 1000;
    }
  }
}

if (!function_exists('hotelMinPrice')) {
  function hotelMinPrice($hotel_id)
  {
    $minPrice = HourlyRoomPrice::Where('hotel_id', $hotel_id)->min('price');
    if ($minPrice) {
      return $minPrice;
    } else {
      return 0;
    }
  }
}

if (!function_exists('roomMaxPrice')) {
  function roomMaxPrice($room_id)
  {
    $maxPrice = HourlyRoomPrice::Where('room_id', $room_id)->max('price');

    if ($maxPrice) {
      return $maxPrice;
    } else {
      return 1000;
    }
  }
}

if (!function_exists('checkInTimeFormate')) {
  function checkInTimeFormate($checkInTime)
  {
    $dateTime = DateTime::createFromFormat('h:i A', $checkInTime);
    if (!$dateTime) {
      $dateTime = DateTime::createFromFormat('H:i', $checkInTime);
    }
    $Time = $dateTime->format('H:i');
    return $Time;
  }
}


if (!function_exists('roomMinPrice')) {
  function roomMinPrice($room_id)
  {
    $minPrice = HourlyRoomPrice::Where('room_id', $room_id)->min('price');
    if ($minPrice) {
      return $minPrice;
    } else {
      return 0;
    }
  }
}
if (!function_exists('convertUtf8')) {
  function convertUtf8($value)
  {
    return mb_detect_encoding($value, mb_detect_order(), true) === 'UTF-8' ? $value : mb_convert_encoding($value, 'UTF-8');
  }
}
if (!function_exists('mapApiSatus')) {
  function mapApiSatus()
  {
    $bs = Basic::select('google_map_api_key_status')->first();
    return  $bs->google_map_api_key_status;
  }
}

if (!function_exists('options')) {
  function options()
  {
    $data = OnlineGateway::where('keyword', 'iyzico')->first();
    $information = json_decode($data->information, true);

    $options = new \Iyzipay\Options();
    $options->setApiKey($information['api_key']);
    $options->setSecretKey($information['secrect_key']);
    if ($information['iyzico_mode'] == 1) {
      $options->setBaseUrl("https://sandbox-api.iyzipay.com");
    } else {
      $options->setBaseUrl("https://api.iyzipay.com");
    }
    return $options;
  }
}
if (!function_exists('adminLanguage')) {
  function adminLanguage()
  {
    $code = Auth::guard('admin')->user()->code;

    $language = Language::where('code', $code)->first();


    return $language;
  }
}
