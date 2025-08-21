<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use App\Models\Advertisement;
use App\Models\BasicSettings\Basic;
use App\Models\Language;
use App\Models\Subscriber;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Validation\Rule;

class MiscellaneousController extends Controller
{
  public function getLanguage()
  {
    // get the current locale of this system
    if (Session::has('currentLocaleCode')) {
      $locale = Session::get('currentLocaleCode');
    }

    if (empty($locale)) {
      $language = Language::where('is_default', 1)->first();
    } else {
      $language = Language::where('code', $locale)->first();
      if (empty($language)) {
        $language = Language::where('is_default', 1)->first();
      }
    }

    return $language;
  }

  public function storeSubscriber(Request $request)
  {
    $rules = [
      'email_id' => [
        'required',
        'email:rfc,dns',
        Rule::unique('subscribers', 'email_id')
      ]
    ];
    $messsage = [];
    $messsage = [
      'email_id.required' => __('Email address field is required.'),
      'email_id.unique' => __('The email address has already been taken.'),
      'email_id.email' => __('The email address is not valid.')
    ];

    $validator = Validator::make($request->all(), $rules, $messsage);
    if ($validator->fails()) {
      return Response::json([
        'error' => $validator->getMessageBag()
      ], 400);
    }

    Subscriber::create([
      'email_id' => $request->email_id
    ]);

    return response()->json(['message' => __('You have successfully subscribed to our newsletter.'), 'alert_type' => 'success']);
  }


  public function changeLanguage(Request $request)
  {
    $language = Language::where('code', $request->code)->first();
    if ($language) {
      Session::put('currentLocaleCode', $request->code);
    }
    return redirect()->back();
  }

  public function apiChangeLanguage(Request $request)
  {
    try {
      $request->validate([
        'code' => 'required|string|max:10'
      ]);

      $language = Language::where('code', $request->code)->first();
      
      if (!$language) {
        return response()->json([
          'success' => false,
          'message' => 'Language not found'
        ], 404);
      }

      // Store in session
      Session::put('currentLocaleCode', $request->code);
      
      // Also store in cookie for persistence across requests
      Cookie::queue('selected_language', $request->code, 60 * 24 * 365); // 1 year

      return response()->json([
        'success' => true,
        'message' => 'Language changed successfully',
        'data' => [
          'code' => $language->code,
          'name' => $language->name,
          'direction' => $language->direction
        ]
      ]);
    } catch (\Exception $e) {
      \Log::error('Error in apiChangeLanguage: ' . $e->getMessage());
      
      return response()->json([
        'success' => false,
        'message' => 'Error changing language',
        'error' => $e->getMessage()
      ], 500);
    }
  }

  public function getFrontendTranslations($languageCode)
  {
    try {
      $language = Language::where('code', $languageCode)->first();
      
      if (!$language) {
        return response()->json([
          'success' => false,
          'message' => 'Language not found'
        ], 404);
      }

      // Get translations from existing language JSON files (frontend keywords)
      $jsonFilePath = resource_path('lang/') . $language->code . '.json';
      
      if (!file_exists($jsonFilePath)) {
        // If language file doesn't exist, try default
        $jsonFilePath = resource_path('lang/') . 'default.json';
        
        if (!file_exists($jsonFilePath)) {
          return response()->json([
            'success' => true,
            'data' => (object)[]
          ]);
        }
      }

      // Read and parse the JSON file
      $jsonData = file_get_contents($jsonFilePath);
      $translations = json_decode($jsonData, true);

      if (!$translations) {
        return response()->json([
          'success' => true,
          'data' => (object)[]
        ]);
      }

      return response()->json([
        'success' => true,
        'data' => (object)$translations
      ]);
    } catch (\Exception $e) {
      \Log::error('Error in getFrontendTranslations: ' . $e->getMessage());
      
      return response()->json([
        'success' => false,
        'message' => 'Error fetching translations',
        'error' => $e->getMessage()
      ], 500);
    }
  }

  public function getLanguages()
  {
    try {
      $languages = Language::select('id', 'name', 'code', 'direction', 'is_default')
        ->orderBy('is_default', 'desc')
        ->orderBy('name', 'asc')
        ->get();

      return response()->json([
        'success' => true,
        'data' => $languages
      ]);
    } catch (\Exception $e) {
      \Log::error('Error in getLanguages: ' . $e->getMessage());
      
      return response()->json([
        'success' => false,
        'message' => 'Error fetching languages',
        'error' => $e->getMessage()
      ], 500);
    }
  }

  public function getBasicSettings()
  {
    try {
      // Check if table exists
      if (!\Schema::hasTable('basic_settings')) {
        \Log::error('basic_settings table does not exist');
        return response()->json([
          'success' => false,
          'message' => 'Database table missing',
          'error' => 'basic_settings table does not exist'
        ], 500);
      }

      $basicInfo = Basic::select(
        'google_map_api_key',
        'google_map_api_key_status',
        'radius',
        'google_login_status',
        'facebook_login_status'
      )->first();

      if (!$basicInfo) {
        \Log::warning('No basic settings found in database');
        return response()->json([
          'success' => false,
          'message' => 'No settings found',
          'error' => 'No basic settings data in database'
        ], 500);
      }

      return response()->json([
        'success' => true,
        'data' => $basicInfo
      ]);
    } catch (\Exception $e) {
      \Log::error('Error in getBasicSettings: ' . $e->getMessage());
      \Log::error('Stack trace: ' . $e->getTraceAsString());
      
      return response()->json([
        'success' => false,
        'message' => 'Error fetching basic settings',
        'error' => $e->getMessage(),
        'file' => $e->getFile(),
        'line' => $e->getLine()
      ], 500);
    }
  }

  public function getPageHeading($language)
  {
    if (Route::is('frontend.rooms')) {
      $pageHeading = $language->pageName()->select('rooms_page_title')->first();
    } elseif (Route::is('frontend.hotels')) {
      $pageHeading = $language->pageName()->select('hotel_page_title')->first();
    } elseif (Route::is('frontend.room.checkout')) {
      $pageHeading = $language->pageName()->select('room_checkout_page_title')->first();
    } elseif (Route::is('frontend.vendors')) {
      $pageHeading = $language->pageName()->select('vendor_page_title')->first();
    } elseif (Route::is('user.login')) {
      $pageHeading = $language->pageName()->select('login_page_title')->first();
    } elseif (Route::is('user.signup')) {
      $pageHeading = $language->pageName()->select('signup_page_title')->first();
    } elseif (Route::is('about_us')) {
      $pageHeading = $language->pageName()->select('about_us_title')->first();
    } elseif (Route::is('blog') || Route::is('blog_details')) {
      $pageHeading = $language->pageName()->select('blog_page_title')->first();
    } elseif (Route::is('frontend.pricing')) {
      $pageHeading = $language->pageName()->select('pricing_page_title')->first();
    } elseif (Route::is('faq')) {
      $pageHeading = $language->pageName()->select('faq_page_title')->first();
    } elseif (Route::is('contact')) {
      $pageHeading = $language->pageName()->select('contact_page_title')->first();
    } elseif (Route::is('vendor.login')) {
      $pageHeading = $language->pageName()->select('vendor_login_page_title')->first();
    } elseif (Route::is('vendor.signup')) {
      $pageHeading = $language->pageName()->select('vendor_signup_page_title')->first();
    } elseif (Route::is('user.forget_password')) {
      $pageHeading = $language->pageName()->select('forget_password_page_title')->first();
    } elseif (Route::is('vendor.forget.password')) {
      $pageHeading = $language->pageName()->select('vendor_forget_password_page_title')->first();
    } elseif (Route::is('user.wishlist.room')) {
      $pageHeading = $language->pageName()->select('room_wishlist_page_title')->first();
    } elseif (Route::is('user.wishlist.hotel')) {
      $pageHeading = $language->pageName()->select('hotel_wishlist_page_title')->first();
    } elseif (Route::is('user.dashboard')) {
      $pageHeading = $language->pageName()->select('dashboard_page_title')->first();
    } elseif (Route::is('user.room_bookings')) {
      $pageHeading = $language->pageName()->select('room_bookings_page_title')->first();
    } elseif (Route::is('user.room_booking_details')) {
      $pageHeading = $language->pageName()->select('room_booking_details_page_title')->first();
    } elseif (Route::is('user.support_ticket')) {
      $pageHeading = $language->pageName()->select('support_ticket_page_title')->first();
    } elseif (Route::is('user.support_ticket.create')) {
      $pageHeading = $language->pageName()->select('support_ticket_create_page_title')->first();
    } elseif (Route::is('user.change_password')) {
      $pageHeading = $language->pageName()->select('change_password_page_title')->first();
    } elseif (Route::is('user.edit_profile')) {
      $pageHeading = $language->pageName()->select('edit_profile_page_title')->first();
    } else {
      $pageHeading = null;
    }

    return $pageHeading;
  }


  public static function getBreadcrumb()
  {
    $breadcrumb = Basic::select('breadcrumb')->first();

    return $breadcrumb;
  }


  public function countAdView($id)
  {
    try {
      $ad = Advertisement::findOrFail($id);

      $ad->update([
        'views' => $ad->views + 1
      ]);

      return response()->json(['success' => 'Advertisement view counted successfully.']);
    } catch (ModelNotFoundException $e) {
      return response()->json(['error' => 'Sorry, something went wrong!']);
    }
  }


  public function serviceUnavailable()
  {
    $info = Basic::select('maintenance_img', 'maintenance_msg')->first();

    return view('errors.503', compact('info'));
  }
}
