<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use App\Http\Controllers\FrontEnd\MiscellaneousController;
use App\Http\Helpers\BasicMailer;
use App\Models\BasicSettings\Basic;
use App\Models\BasicSettings\MailTemplate;
use App\Models\Booking;
use App\Models\HotelWishlist;
use App\Models\RoomContent;
use App\Models\RoomWishlist;
use App\Models\SupportTicket;
use App\Models\User;
use App\Models\Vendor;
use App\Rules\ImageMimeTypeRule;
use App\Rules\MatchEmailRule;
use App\Rules\MatchOldPasswordRule;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Laravel\Socialite\Facades\Socialite;
use Illuminate\Support\Facades\URL;

class UserController extends Controller
{
  public function __construct()
  {
    $bs = DB::table('basic_settings')
      ->select('facebook_app_id', 'facebook_app_secret', 'google_client_id', 'google_client_secret')
      ->first();

    Config::set('services.facebook.client_id', $bs->facebook_app_id);
    Config::set('services.facebook.client_secret', $bs->facebook_app_secret);
    Config::set('services.facebook.redirect', url('user/login/facebook/callback'));

    Config::set('services.google.client_id', $bs->google_client_id);
    Config::set('services.google.client_secret', $bs->google_client_secret);
    Config::set('services.google.redirect', url('login/google/callback'));
  }

  public function login(Request $request)
  {
    $misc = new MiscellaneousController();

    $language = $misc->getLanguage();

    $information['seoInfo'] = $language->seoInfo()->select('meta_keyword_login', 'meta_description_login')->first();

    $information['pageHeading'] = $misc->getPageHeading($language);

    $information['bgImg'] = $misc->getBreadcrumb();

    // get the status of digital product (exist or not in the cart)
    if (!empty($request->input('digital_item'))) {
      $information['digitalProductStatus'] = $request->input('digital_item');
    }

    $information['bs'] = Basic::query()->select('google_recaptcha_status', 'facebook_login_status', 'google_login_status')->first();

    if ($request->redirectPath == 'hotelwishlist') {
      Session::put('redirectTo', URL::previous());
    }
    if ($request->redirectPath == 'roomwishlist') {
      Session::put('redirectTo', URL::previous());
    }
    if ($request->redirectPath == 'roomDetails') {
      Session::put('redirectTo', URL::previous());
    }
    return view('frontend.user.login', $information);
  }

  public function redirectToFacebook()
  {
    return Socialite::driver('facebook')->redirect();
  }

  public function handleFacebookCallback(Request $request)
  {
    if ($request->has('error_code')) {
      Session::flash('error', $request->error_message);
      return redirect()->route('user.login');
    }
    return $this->authenticationViaProvider('facebook');
  }

  public function redirectToGoogle()
  {
    return Socialite::driver('google')->redirect();
  }

  public function handleGoogleCallback()
  {
    return $this->authenticationViaProvider('google');
  }

  public function authenticationViaProvider($driver)
  {
    // get the url from session which will be redirect after login
    if (Session::has('redirectTo')) {
      $redirectURL = Session::get('redirectTo');
    } else {
      $redirectURL = route('user.dashboard');
    }

    $responseData = Socialite::driver($driver)->user();
    $userInfo = $responseData->user;

    $isUser = User::query()->where('email', '=', $userInfo['email'])->first();

    if (!empty($isUser)) {
      // log in
      if ($isUser->status == 1) {
        Auth::guard('web')->login($isUser);

        return redirect($redirectURL);
      } else {
        Session::flash('error', __('Sorry, your account has been deactivated.'));
        
        return redirect()->route('user.login');
      }
    } else {
      // get user avatar and save it
      $avatar = $responseData->getAvatar();
      $fileContents = file_get_contents($avatar);

      $avatarName = $responseData->getId() . '.jpg';
      $path = public_path('assets/img/users/');

      file_put_contents($path . $avatarName, $fileContents);

      // sign up
      $user = new User();

      if ($driver == 'facebook') {
        $user->name = $userInfo['name'];
      } else {
        $user->name = $userInfo['given_name'];
      }

      $user->image = $avatarName;
      $user->username = $userInfo['id'];
      $user->email = $userInfo['email'];
      $user->email_verified_at = date('Y-m-d H:i:s');
      $user->status = 1;
      $user->provider = ($driver == 'facebook') ? 'facebook' : 'google';
      $user->provider_id = $userInfo['id'];
      $user->save();

      Auth::guard('web')->login($user);

      return redirect($redirectURL);
    }
  }

  public function loginSubmit(Request $request)
  {
    // get the url from session which will be redirect after login
    if ($request->session()->has('redirectTo')) {
      $redirectURL = $request->session()->get('redirectTo');
    } else {
      $redirectURL = null;
    }

    $rules = [
      'username' => 'required',
      'password' => 'required'
    ];

    $info = Basic::select('google_recaptcha_status')->first();
    if ($info->google_recaptcha_status == 1) {
      $rules['g-recaptcha-response'] = 'required|captcha';
    }

    $messages = [];

    if ($info->google_recaptcha_status == 1) {
      $messages['g-recaptcha-response.required'] = 'Please verify that you are not a robot.';
      $messages['g-recaptcha-response.captcha'] = 'Captcha error! try again later or contact site admin.';
    }

    $validator = Validator::make($request->all(), $rules, $messages);

    if ($validator->fails()) {
      return redirect()->route('user.login')->withErrors($validator->errors())->withInput();
    }

    // get the email and password which has provided by the user
    $credentials = $request->only('username', 'password');

    // login attempt
    if (Auth::guard('web')->attempt($credentials)) {
      $authUser = Auth::guard('web')->user();
      // second, check whether the user's account is active or not
      if ($authUser->email_verified_at == null) {
        Session::flash('error', __('Please verify your email address'));

        // logout auth user as condition not satisfied
        Auth::guard('web')->logout();

        return redirect()->back();
      }
      if ($authUser->status == 0) {
        Session::flash('error', __('Sorry, your account has been deactivated'));

        // logout auth user as condition not satisfied
        Auth::guard('web')->logout();

        return redirect()->back();
      }

      // otherwise, redirect auth user to next url
      if (is_null($redirectURL)) {
        return redirect()->route('user.dashboard');
      } else {
        // before, redirect to next url forget the session value
        $request->session()->forget('redirectTo');

        return redirect($redirectURL);
      }
    } else {
      Session::flash('error', __('Incorrect username or password'));

      return redirect()->back();
    }
  }

  public function forgetPassword()
  {
    $misc = new MiscellaneousController();

    $language = $misc->getLanguage();

    $information['seoInfo'] = $language->seoInfo()->select('meta_keyword_forget_password', 'meta_description_forget_password')->first();

    $information['pageHeading'] = $misc->getPageHeading($language);

    $information['bgImg'] = $misc->getBreadcrumb();
    $information['bs'] = Basic::query()->select('google_recaptcha_status', 'facebook_login_status', 'google_login_status')->first();

    return view('frontend.user.forget-password', $information);
  }

  public function forgetPasswordMail(Request $request)
  {
    $rules = [
      'email' => [
        'required',
        'email:rfc,dns',
        new MatchEmailRule('user')
      ]
    ];

    $info = Basic::select('google_recaptcha_status')->first();

    $messages = [];

    $validator = Validator::make($request->all(), $rules, $messages);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors())->withInput();
    }

    $user = User::query()->where('email', '=', $request->email)->first();

    // store user email in session to use it later
    $request->session()->put('userEmail', $user->email);

    // get the mail template information from db
    $mailTemplate = MailTemplate::query()->where('mail_type', '=', 'reset_password')->first();
    $mailData['subject'] = $mailTemplate->mail_subject;
    $mailBody = $mailTemplate->mail_body;

    // get the website title info from db
    $info = Basic::select('website_title')->first();

    $name = $user->username;

    $link = '<a href=' . url("user/reset-password") . '>Click Here</a>';

    $mailBody = str_replace('{customer_name}', $name, $mailBody);
    $mailBody = str_replace('{password_reset_link}', $link, $mailBody);
    $mailBody = str_replace('{website_title}', $info->website_title, $mailBody);

    $mailData['body'] = $mailBody;

    $mailData['recipient'] = $user->email;

    $mailData['sessionMessage'] = 'A mail has been sent to your email address';

    BasicMailer::sendMail($mailData);

    return redirect()->back();
  }

  public function resetPassword()
  {
    $misc = new MiscellaneousController();

    $bgImg = $misc->getBreadcrumb();

    return view('frontend.user.reset-password', compact('bgImg'));
  }

  public function resetPasswordSubmit(Request $request)
  {
    if ($request->session()->has('userEmail')) {
      // get the user email from session
      $emailAddress = $request->session()->get('userEmail');

      $rules = [
        'new_password' => 'required|confirmed',
        'new_password_confirmation' => 'required'
      ];

      $messages = [
        'new_password.confirmed' => __('Password confirmation failed.'),
        'new_password_confirmation.required' => __('The confirm new password field is required.')
      ];

      $validator = Validator::make($request->all(), $rules, $messages);

      if ($validator->fails()) {
        return redirect()->back()->withErrors($validator->errors());
      }

      $user = User::query()->where('email', '=', $emailAddress)->first();

      $user->update([
        'password' => Hash::make($request->new_password)
      ]);

      Session::flash('success', __('Password updated successfully.'));
    } else {
      Session::flash('error', __('Something went wrong') . '!');
    }

    return redirect()->route('user.login');
  }

  public function signup()
  {
    $misc = new MiscellaneousController();

    $language = $misc->getLanguage();

    $information['seoInfo'] = $language->seoInfo()->select('meta_keyword_signup', 'meta_description_signup')->first();

    $information['pageHeading'] = $misc->getPageHeading($language);

    $information['bgImg'] = $misc->getBreadcrumb();

    $information['recaptchaInfo'] = Basic::select('google_recaptcha_status')->first();

    return view('frontend.user.signup', $information);
  }

  public function signupSubmit(Request $request)
  {
    $info = Basic::select('google_recaptcha_status', 'website_title')->first();

    // validation start
    $rules = [
      'username' => 'required|string|unique:users|max:255',
      'email' => 'required|email|unique:users|max:255',
      'password' => 'required|string|min:6|confirmed',
      'password_confirmation' => 'required|string'
    ];

    if ($info->google_recaptcha_status == 1) {
      $rules['g-recaptcha-response'] = 'required|captcha';
    }

    $messages = [
      'username.required' => __('The username field is required.'),
      'username.unique' => __('This username is already taken.'),
      'username.max' => __('The username may not be greater than 255 characters.'),
      'email.required' => __('The email field is required.'),
      'email.email' => __('Please provide a valid email address.'),
      'email.unique' => __('This email is already registered.'),
      'email.max' => __('The email may not be greater than 255 characters.'),
      'password.required' => __('The password field is required.'),
      'password.confirmed' => __('The password confirmation does not match.'),
      'password_confirmation.required' => __('The password confirmation field is required.'),
    ];

    if ($info->google_recaptcha_status == 1) {
      $messages['g-recaptcha-response.required'] = __('Please verify that you are not a robot.');
      $messages['g-recaptcha-response.captcha'] = __('Captcha error! Try again later or contact site admin.');
    }

    $validator = Validator::make($request->all(), $rules, $messages);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors())->withInput();
    }
    // validation end

    $user = new User();
    $user->username = $request->username;
    $user->email = $request->email;
    $user->status = 1;
    $user->password = Hash::make($request->password);
    $user->save();

    // get the mail template information from db
    $mailTemplate = MailTemplate::query()->where('mail_type', '=', 'verify_email')->first();
    $mailData['subject'] = $mailTemplate->mail_subject;
    $mailBody = $mailTemplate->mail_body;

    $link = '<a href=' . url("user/signup-verify/" . $user->id) . '>Click Here</a>';

    $mailBody = str_replace('{username}', $user->username, $mailBody);
    $mailBody = str_replace('{verification_link}', $link, $mailBody);
    $mailBody = str_replace('{website_title}', $info->website_title, $mailBody);

    $mailData['body'] = $mailBody;

    $mailData['recipient'] = $user->email;

    $mailData['sessionMessage'] = __('A verification mail has been sent to your email address');

    BasicMailer::sendMail($mailData);

    $information['authUser'] = $user;
    return back();
  }

  public function signupVerify($id)
  {
    $user = User::where('id', $id)->firstOrFail();
    $user->email_verified_at = Carbon::now();
    $user->save();
    Auth::login($user);
    return redirect()->route('user.dashboard');
  }

  public function redirectToDashboard()
  {
    $misc = new MiscellaneousController();

    $language = $misc->getLanguage();

    $information['language'] = $language;

    $information['bgImg'] = $misc->getBreadcrumb();
    $information['pageHeading'] = $misc->getPageHeading($language);

    $user = Auth::guard('web')->user();

    $information['authUser'] = $user;
    $information['roomwishlists'] = RoomWishlist::where('user_id', $user->id)
      ->join('rooms', 'rooms.id', '=', 'room_wishlists.room_id')
      ->join('room_contents', 'room_contents.room_id', '=', 'room_wishlists.room_id')
      ->Join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
      ->Join('room_categories', 'room_contents.room_category', '=', 'room_categories.id')
      ->Join('hotel_contents', 'rooms.hotel_id', '=', 'hotel_contents.hotel_id')
      ->Join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
      ->where('room_contents.language_id', $language->id)
      ->where('hotel_contents.language_id', $language->id)
      ->where('rooms.status',  '=',    '1')
      ->where('hotels.status',  '=',    '1')
      ->where('room_categories.status', 1)
      ->where('hotel_categories.status', 1)

      ->when('rooms.vendor_id' != "0", function ($query) {
        return $query->leftJoin('memberships', 'rooms.vendor_id', '=', 'memberships.vendor_id')
          ->where(function ($query) {
            $query->where([
              ['memberships.status', '=', 1],
              ['memberships.start_date', '<=', now()->format('Y-m-d')],
              ['memberships.expire_date', '>=', now()->format('Y-m-d')],
            ])->orWhere('rooms.vendor_id', '=', 0);
          });
      })
      ->when('rooms.vendor_id' != "0", function ($query) {
        return $query->leftJoin('vendors', 'rooms.vendor_id', '=', 'vendors.id')
          ->where(function ($query) {
            $query->where([
              ['vendors.status', '=', 1],
            ])->orWhere('rooms.vendor_id', '=', 0);
          });
      })
      ->select(
        'room_contents.room_id as room_id',
        'room_contents.title as title',
        'room_contents.slug as slug'
      )
      ->get();

    $information['hotelwishlists'] = HotelWishlist::where('user_id', $user->id)
      ->join('hotels', 'hotels.id', '=', 'hotel_wishlists.hotel_id')
      ->join('hotel_contents', 'hotel_contents.hotel_id', '=', 'hotel_wishlists.hotel_id')
      ->Join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
      ->where('hotel_contents.language_id', $language->id)
      ->where('hotels.status',  '=',    '1')
      ->where('hotel_categories.status', 1)

      ->when('hotels.vendor_id' != "0", function ($query) {
        return $query->leftJoin('memberships', 'hotels.vendor_id', '=', 'memberships.vendor_id')
          ->where(function ($query) {
            $query->where([
              ['memberships.status', '=', 1],
              ['memberships.start_date', '<=', now()->format('Y-m-d')],
              ['memberships.expire_date', '>=', now()->format('Y-m-d')],
            ])->orWhere('hotels.vendor_id', '=', 0);
          });
      })
      ->when('hotels.vendor_id' != "0", function ($query) {
        return $query->leftJoin('vendors', 'hotels.vendor_id', '=', 'vendors.id')
          ->where(function ($query) {
            $query->where([
              ['vendors.status', '=', 1],
            ])->orWhere('hotels.vendor_id', '=', 0);
          });
      })
      ->select(
        'hotel_contents.hotel_id as hotel_id',
        'hotel_contents.title as title',
        'hotel_contents.slug as slug'
      )
      ->get();
    $information['bookings'] = Booking::where('user_id', '=', $user->id)
      ->orderBy('id', 'desc')
      ->get();

    $information['supportTickets'] = SupportTicket::where([['user_id', Auth::guard('web')->user()->id], ['user_type', 'user']])->orderBy('id', 'desc')->get();
    return view('frontend.user.dashboard', $information);
  }

  public function editProfile()
  {
    $misc = new MiscellaneousController();

    $information['bgImg'] = $misc->getBreadcrumb();
    $language = $misc->getLanguage();
    $information['pageHeading'] = $misc->getPageHeading($language);

    $information['authUser'] = Auth::guard('web')->user();


    return view('frontend.user.edit-profile', $information);
  }

  public function updateProfile(Request $request)
  {
    if ($request->image) {
      $image = true;
    } else {
      $image = false;
    }

    $request->validate([
      'image' => $image ? [
        'required',
        'dimensions:width=80,height=80',
        new ImageMimeTypeRule()
      ] : '',
      'name' => 'required',
      'username' => [
        'required',
        'alpha_dash',
        Rule::unique('users', 'username')->ignore(Auth::guard('web')->user()->id),
      ],
      'email' => [
        'required',
        'email',
        Rule::unique('users', 'email')->ignore(Auth::guard('web')->user()->id)
      ],
    ]);

    $authUser = Auth::guard('web')->user();
    $in = $request->all();
    $file = $request->file('image');
    if ($file) {
      $extension = $file->getClientOriginalExtension();
      $directory = public_path('assets/img/users/');
      $fileName = uniqid() . '.' . $extension;
      @mkdir($directory, 0775, true);
      $file->move($directory, $fileName);
      $in['image'] = $fileName;
      @unlink(public_path('assets/img/users/') . $authUser->image);
    }

    $authUser->update($in);
    Session::flash('success', __('Your profile has been updated successfully.'));
    return redirect()->back();
  }

  public function changePassword()
  {
    $misc = new MiscellaneousController();

    $bgImg = $misc->getBreadcrumb();
    $language = $misc->getLanguage();
    $pageHeading = $misc->getPageHeading($language);

    return view('frontend.user.change-password', compact('bgImg', 'pageHeading'));
  }

  public function updatePassword(Request $request)
  {
    $rules = [
      'current_password' => [
        'required',
        new MatchOldPasswordRule('user')
      ],
      'new_password' => 'required|confirmed',
      'new_password_confirmation' => 'required'
    ];

    $messages = [
      'new_password.confirmed' => __('Password confirmation failed.'),
      'new_password_confirmation.required' => __('The confirm new password field is required.')
    ];

    $validator = Validator::make($request->all(), $rules, $messages);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $user = Auth::guard('web')->user();

    $user->update([
      'password' => Hash::make($request->new_password)
    ]);

    Session::flash('success', __('Password updated successfully') . '!');

    return redirect()->back();
  }

  //wishlist
  public function roomWishlist()
  {
    $misc = new MiscellaneousController();
    $bgImg = $misc->getBreadcrumb();
    $language = $misc->getLanguage();
    $information['language'] = $language;
    $information['pageHeading'] = $misc->getPageHeading($language);

    $information['language'] = $language;
    $user_id = Auth::guard('web')->user()->id;
    $information['wishlists'] = RoomWishlist::where('user_id', $user_id)
      ->join('rooms', 'rooms.id', '=', 'room_wishlists.room_id')
      ->join('room_contents', 'room_contents.room_id', '=', 'room_wishlists.room_id')
      ->Join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
      ->Join('room_categories', 'room_contents.room_category', '=', 'room_categories.id')
      ->Join('hotel_contents', 'rooms.hotel_id', '=', 'hotel_contents.hotel_id')
      ->Join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
      ->where('room_contents.language_id', $language->id)
      ->where('hotel_contents.language_id', $language->id)
      ->where('rooms.status',  '=',    '1')
      ->where('hotels.status',  '=',    '1')
      ->where('room_categories.status', 1)
      ->where('hotel_categories.status', 1)

      ->when('rooms.vendor_id' != "0", function ($query) {
        return $query->leftJoin('memberships', 'rooms.vendor_id', '=', 'memberships.vendor_id')
          ->where(function ($query) {
            $query->where([
              ['memberships.status', '=', 1],
              ['memberships.start_date', '<=', now()->format('Y-m-d')],
              ['memberships.expire_date', '>=', now()->format('Y-m-d')],
            ])->orWhere('rooms.vendor_id', '=', 0);
          });
      })
      ->when('rooms.vendor_id' != "0", function ($query) {
        return $query->leftJoin('vendors', 'rooms.vendor_id', '=', 'vendors.id')
          ->where(function ($query) {
            $query->where([
              ['vendors.status', '=', 1],
            ])->orWhere('rooms.vendor_id', '=', 0);
          });
      })
      ->select(
        'room_contents.room_id as room_id',
        'room_contents.title as title',
        'room_contents.slug as slug'
      )
      ->get();

    $information['bgImg'] = $bgImg;
    return view('frontend.user.wishlist.room', $information);
  }
  public function hotelWishlist()
  {
    $misc = new MiscellaneousController();
    $bgImg = $misc->getBreadcrumb();
    $language = $misc->getLanguage();
    $information['language'] = $language;
    $information['pageHeading'] = $misc->getPageHeading($language);

    $information['language'] = $language;
    $user_id = Auth::guard('web')->user()->id;
    $information['wishlists'] = HotelWishlist::where('user_id', $user_id)
      ->join('hotels', 'hotels.id', '=', 'hotel_wishlists.hotel_id')
      ->join('hotel_contents', 'hotel_contents.hotel_id', '=', 'hotel_wishlists.hotel_id')
      ->Join('hotel_categories', 'hotel_contents.category_id', '=', 'hotel_categories.id')
      ->where('hotel_contents.language_id', $language->id)
      ->where('hotels.status',  '=',    '1')
      ->where('hotel_categories.status', 1)

      ->when('hotels.vendor_id' != "0", function ($query) {
        return $query->leftJoin('memberships', 'hotels.vendor_id', '=', 'memberships.vendor_id')
          ->where(function ($query) {
            $query->where([
              ['memberships.status', '=', 1],
              ['memberships.start_date', '<=', now()->format('Y-m-d')],
              ['memberships.expire_date', '>=', now()->format('Y-m-d')],
            ])->orWhere('hotels.vendor_id', '=', 0);
          });
      })
      ->when('hotels.vendor_id' != "0", function ($query) {
        return $query->leftJoin('vendors', 'hotels.vendor_id', '=', 'vendors.id')
          ->where(function ($query) {
            $query->where([
              ['vendors.status', '=', 1],
            ])->orWhere('hotels.vendor_id', '=', 0);
          });
      })
      ->select(
        'hotel_contents.hotel_id as hotel_id',
        'hotel_contents.title as title',
        'hotel_contents.slug as slug'
      )
      ->get();

    $information['bgImg'] = $bgImg;
    return view('frontend.user.wishlist.hotel', $information);
  }
  //room booking
  public function roomBooking()
  {
    $misc = new MiscellaneousController();
    $information['bgImg'] =  $misc->getBreadcrumb();
    $language = $misc->getLanguage();
    $information['pageHeading'] = $misc->getPageHeading($language);
    $user = Auth::guard('web')->user();

    $information['bookings'] = Booking::where('user_id', '=', $user->id)
      ->orderBy('id', 'desc')
      ->get();

    return view('frontend.user.booking.index', $information);
  }

  public function bookingDetails($id)
  {
    $misc = new MiscellaneousController();
    $information['bgImg'] =  $misc->getBreadcrumb();

    $language = $misc->getLanguage();
    $information['pageHeading'] = $misc->getPageHeading($language);
    $user = Auth::guard('web')->user();
    $information['user'] = $user;

    $booking =  Booking::where([['id', $id], ['user_id', $user->id]])->firstOrFail();

    $information['additional_services']   = json_decode($booking->service_details);
    $information['basic'] = Basic::select('base_currency_symbol', 'base_currency_symbol_position', 'base_currency_text', 'base_currency_text_position')->first();

    $information['roomContent'] = RoomContent::where([['language_id', $language->id], ['room_id', $booking->room_id]])->select('title', 'slug', 'room_id')->first();
    $information['bookingInfo'] = $booking;
    $information['seller'] = Vendor::where('id', $booking->vendor_id)->first();
    // dd($data['seller']);

    return view('frontend.user.booking.details', $information);
  }

  //add_to_wishlist hotel
  public function add_to_wishlist_hotel($id)
  {
    if (Auth::guard('web')->check()) {
      $user_id = Auth::guard('web')->user()->id;
      $check = HotelWishlist::where('hotel_id', $id)->where('user_id', $user_id)->first();

      if (!empty($check)) {
        return back()->with('success', __('Added to your wishlist successfully.'));
      } else {
        $add = new HotelWishlist;
        $add->hotel_id = $id;
        $add->user_id = $user_id;
        $add->save();
        return back()->with('success', __('Added to your wishlist successfully.'));
      }
    } else {
      return redirect()->route('user.login', ['redirectPath' => 'hotelwishlist']);
    }
  }
  //remove_wishlist hotel
  public function remove_wishlist_hotel($id)
  {
    if (Auth::guard('web')->check()) {
      $user_id = Auth::guard('web')->user()->id;
      $remove = HotelWishlist::where('hotel_id', $id)->where('user_id', $user_id)->first();
      if ($remove) {
        $remove->delete();
        return back()->with('success', __('Removed From wishlist successfully'));
      } else {
        return back()->with('warning', 'Something went wrong.');
      }
    } else {
      return redirect()->route('user.login', ['redirectPath' => 'hotelwishlist']);
    }
  }
  //add_to_wishlist room
  public function add_to_wishlist_room($id)
  {
    if (Auth::guard('web')->check()) {
      $user_id = Auth::guard('web')->user()->id;
      $check = RoomWishlist::where('room_id', $id)->where('user_id', $user_id)->first();

      if (!empty($check)) {
        return back()->with('success', __('Added to your wishlist successfully.'));
      } else {
        $add = new RoomWishlist;
        $add->room_id = $id;
        $add->user_id = $user_id;
        $add->save();
        return back()->with('success', __('Added to your wishlist successfully.'));
      }
    } else {
      return redirect()->route('user.login', ['redirectPath' => 'roomwishlist']);
    }
  }
  //remove_wishlist room
  public function remove_wishlist_room($id)
  {
    if (Auth::guard('web')->check()) {
      $user_id = Auth::guard('web')->user()->id;
      $remove = RoomWishlist::where('room_id', $id)->where('user_id', $user_id)->first();
      if ($remove) {
        $remove->delete();
        return back()->with('success', __('Removed From wishlist successfully'));
      } else {
        return back()->with('warning', 'Something went wrong.');
      }
    } else {
      return redirect()->route('user.login', ['redirectPath' => 'roomwishlist']);
    }
  }

  public function logoutSubmit(Request $request)
  {
    Auth::guard('web')->logout();
    Session::forget('secret_login');

    if ($request->session()->has('redirectTo')) {
      $request->session()->forget('redirectTo');
    }

    return redirect()->route('user.login');
  }

  // API Methods for React Frontend
  public function apiLogin(Request $request)
  {
    try {
      \Log::info('API Login attempt via JWT');

      $rules = [
        'username' => 'required',
        'password' => 'required'
      ];

      $validator = Validator::make($request->all(), $rules);

      if ($validator->fails()) {
        return response()->json([
          'success' => false,
          'message' => 'Validation failed',
          'errors' => $validator->errors()
        ], 422);
      }

      $credentials = $request->only('username', 'password');

      if (Auth::guard('web')->attempt($credentials)) {
        $authUser = Auth::guard('web')->user();
        
        \Log::info('API Login successful - User: ' . $authUser->name);
        
        if ($authUser->email_verified_at == null) {
          Auth::guard('web')->logout();
          return response()->json([
            'success' => false,
            'message' => 'Please verify your email address'
          ], 401);
        }
        
        if ($authUser->status == 0) {
          Auth::guard('web')->logout();
          return response()->json([
            'success' => false,
            'message' => 'Sorry, your account has been deactivated'
          ], 401);
        }

        // Generate JWT token
        $token = Auth::guard('api')->login($authUser);
        
        \Log::info('JWT token generated for user: ' . $authUser->name);

        return response()->json([
          'success' => true,
          'message' => 'Login successful',
          'user' => $authUser,
          'token' => $token,
          'token_type' => 'bearer',
          'expires_in' => auth('api')->factory()->getTTL() * 60
        ]);
      } else {
        \Log::info('API Login failed - Invalid credentials');
        return response()->json([
          'success' => false,
          'message' => 'Incorrect username or password'
        ], 401);
      }
    } catch (\Exception $e) {
      \Log::error('API Login error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred during login: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiLogout(Request $request)
  {
    try {
      \Log::info('API Logout via JWT');

      // Get the token from the request
      $token = $request->bearerToken();
      
      if ($token) {
        // Invalidate the token
        Auth::guard('api')->logout();
        \Log::info('JWT token invalidated');
      }

      return response()->json([
        'success' => true,
        'message' => 'Logout successful'
      ]);
    } catch (\Exception $e) {
      \Log::error('API Logout error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred during logout: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiUser(Request $request)
  {
    try {
      \Log::info('API User check via JWT');

      if (Auth::guard('api')->check()) {
        $user = Auth::guard('api')->user();
        \Log::info('JWT User check - User found: ' . $user->name);
        
        return response()->json([
          'success' => true,
          'user' => $user
        ]);
      } else {
        \Log::info('JWT User check - No authenticated user found');
        
        return response()->json([
          'success' => false,
          'message' => 'User not authenticated'
        ], 401);
      }
    } catch (\Exception $e) {
      \Log::error('JWT User check error: ' . $e->getMessage());
      
      return response()->json([
        'success' => false,
        'message' => 'An error occurred: ' . $e->getMessage()
      ], 500);
    }
  }

  public function refreshToken(Request $request)
  {
    try {
      \Log::info('JWT token refresh attempt');

      $token = Auth::guard('api')->refresh();
      
      \Log::info('JWT token refreshed successfully');

      return response()->json([
        'success' => true,
        'token' => $token,
        'token_type' => 'bearer',
        'expires_in' => auth('api')->factory()->getTTL() * 60
      ]);
    } catch (\Exception $e) {
      \Log::error('JWT token refresh error: ' . $e->getMessage());
      
      return response()->json([
        'success' => false,
        'message' => 'Token refresh failed: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiRegister(Request $request)
  {
    try {
      \Log::info('API Registration attempt');

      $rules = [
        'username' => 'required|string|unique:users|max:255',
        'email' => 'required|email|unique:users|max:255',
        'password' => 'required|string|min:6|confirmed',
        'password_confirmation' => 'required|string'
      ];

      $validator = Validator::make($request->all(), $rules);

      if ($validator->fails()) {
        return response()->json([
          'success' => false,
          'message' => 'Validation failed',
          'errors' => $validator->errors()
        ], 422);
      }

      // Create the user
      $user = new User();
      $user->username = $request->username;
      $user->email = $request->email;
      $user->status = 1;
      $user->password = Hash::make($request->password);
      
      // Add optional fields if they exist in the request
      if ($request->has('name')) {
        $user->name = $request->name;
      }
      if ($request->has('phone')) {
        $user->phone = $request->phone;
      }
      
      $user->save();

      \Log::info('API Registration successful - User: ' . $user->username);

      return response()->json([
        'success' => true,
        'message' => 'Registration successful! Please log in.',
        'user' => [
          'id' => $user->id,
          'username' => $user->username,
          'email' => $user->email,
          'name' => $user->name ?? null,
          'phone' => $user->phone ?? null
        ]
      ], 201);

    } catch (\Exception $e) {
      \Log::error('API Registration error: ' . $e->getMessage());
      
      return response()->json([
        'success' => false,
        'message' => 'An error occurred during registration: ' . $e->getMessage()
      ], 500);
    }
  }

  // Social Login API Methods for React Frontend
  public function getGoogleLoginUrl()
  {
    try {
      $url = Socialite::driver('google')->stateless()->redirect()->getTargetUrl();
      return response()->json([
        'success' => true,
        'url' => $url
      ]);
    } catch (\Exception $e) {
      \Log::error('Google login URL generation error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'Failed to generate Google login URL'
      ], 500);
    }
  }

  public function getFacebookLoginUrl()
  {
    try {
      $url = Socialite::driver('facebook')->stateless()->redirect()->getTargetUrl();
      return response()->json([
        'success' => true,
        'url' => $url
      ]);
    } catch (\Exception $e) {
      \Log::error('Facebook login URL generation error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'Failed to generate Facebook login URL'
      ], 500);
    }
  }

  public function handleGoogleApiCallback(Request $request)
  {
    try {
      \Log::info('Google API callback received');
      
      $rules = [
        'code' => 'required|string'
      ];

      $validator = Validator::make($request->all(), $rules);

      if ($validator->fails()) {
        return response()->json([
          'success' => false,
          'message' => 'Invalid request data',
          'errors' => $validator->errors()
        ], 422);
      }

      // Get user data from Google
      $responseData = Socialite::driver('google')->stateless()->user();
      $userInfo = $responseData->user;

      return $this->handleSocialLoginApi($userInfo, 'google', $responseData);
    } catch (\Exception $e) {
      \Log::error('Google API callback error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'Google login failed: ' . $e->getMessage()
      ], 500);
    }
  }

  public function handleFacebookApiCallback(Request $request)
  {
    try {
      \Log::info('Facebook API callback received');
      
      $rules = [
        'code' => 'required|string'
      ];

      $validator = Validator::make($request->all(), $rules);

      if ($validator->fails()) {
        return response()->json([
          'success' => false,
          'message' => 'Invalid request data',
          'errors' => $validator->errors()
        ], 422);
      }

      // Get user data from Facebook
      $responseData = Socialite::driver('facebook')->stateless()->user();
      $userInfo = $responseData->user;

      return $this->handleSocialLoginApi($userInfo, 'facebook', $responseData);
    } catch (\Exception $e) {
      \Log::error('Facebook API callback error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'Facebook login failed: ' . $e->getMessage()
      ], 500);
    }
  }

  private function handleSocialLoginApi($userInfo, $driver, $responseData)
  {
    try {
      $isUser = User::query()->where('email', '=', $userInfo['email'])->first();

      if (!empty($isUser)) {
        // User exists, check status and login
        if ($isUser->status == 1) {
          // Generate JWT token
          $token = Auth::guard('api')->login($isUser);
          
          \Log::info('Social login successful - Existing user: ' . $isUser->name);

          return response()->json([
            'success' => true,
            'message' => 'Login successful',
            'user' => $isUser,
            'token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth('api')->factory()->getTTL() * 60
          ]);
        } else {
          return response()->json([
            'success' => false,
            'message' => 'Sorry, your account has been deactivated.'
          ], 401);
        }
      } else {
        // User doesn't exist, create new account
        $avatar = $responseData->getAvatar();
        $fileContents = file_get_contents($avatar);

        $avatarName = $responseData->getId() . '.jpg';
        $path = public_path('assets/img/users/');

        file_put_contents($path . $avatarName, $fileContents);

        // Create new user
        $user = new User();

        if ($driver == 'facebook') {
          $user->name = $userInfo['name'];
        } else {
          $user->name = $userInfo['given_name'];
        }

        $user->image = $avatarName;
        $user->username = $userInfo['id'];
        $user->email = $userInfo['email'];
        $user->email_verified_at = date('Y-m-d H:i:s');
        $user->status = 1;
        $user->provider = $driver;
        $user->provider_id = $userInfo['id'];
        $user->save();

        // Generate JWT token
        $token = Auth::guard('api')->login($user);
        
        \Log::info('Social login successful - New user created: ' . $user->name);

        return response()->json([
          'success' => true,
          'message' => 'Account created and login successful',
          'user' => $user,
          'token' => $token,
          'token_type' => 'bearer',
          'expires_in' => auth('api')->factory()->getTTL() * 60
        ]);
      }
    } catch (\Exception $e) {
      \Log::error('Social login API error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'Social login failed: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiUpdateProfile(Request $request)
  {
    $apiUser = auth('api')->user();
    if (!$apiUser) {
      return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
    }

    $image = $request->hasFile('image');

    $validator = Validator::make($request->all(), [
      'image' => $image ? [
        'required',
        'dimensions:width=80,height=80',
        new ImageMimeTypeRule()
      ] : '',
      'name' => 'required',
      'username' => [
        'required',
        'alpha_dash',
        Rule::unique('users', 'username')->ignore($apiUser->id),
      ],
      'email' => [
        'required',
        'email',
        Rule::unique('users', 'email')->ignore($apiUser->id)
      ],
    ]);

    if ($validator->fails()) {
      return response()->json(['success' => false, 'errors' => $validator->errors()], 422);
    }

    $in = $request->all();
    if ($image) {
      $file = $request->file('image');
      $extension = $file->getClientOriginalExtension();
      $directory = public_path('assets/img/users/');
      $fileName = uniqid() . '.' . $extension;
      @mkdir($directory, 0775, true);
      $file->move($directory, $fileName);
      $in['image'] = $fileName;
      if (!empty($apiUser->image)) {
        @unlink(public_path('assets/img/users/') . $apiUser->image);
      }
    }

    $apiUser->update($in);

    return response()->json([
      'success' => true,
      'message' => 'Your profile has been updated successfully.',
      'user' => $apiUser->fresh()
    ]);
  }

  public function apiUpdatePassword(Request $request)
  {
    $apiUser = auth('api')->user();
    if (!$apiUser) {
      return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
    }

    // Basic validation first
    $validator = Validator::make($request->all(), [
      'current_password' => ['required'],
      'new_password' => 'required|confirmed',
      'new_password_confirmation' => 'required'
    ], [
      'new_password.confirmed' => __('Password confirmation failed.'),
      'new_password_confirmation.required' => __('The confirm new password field is required.')
    ]);

    if ($validator->fails()) {
      return response()->json(['success' => false, 'errors' => $validator->errors()], 422);
    }

    // Manually verify current password against the JWT-authenticated user
    if (!\Hash::check($request->current_password, $apiUser->password)) {
      return response()->json([
        'success' => false,
        'errors' => ['current_password' => ['Your provided current password does not match!']]
      ], 422);
    }

    $apiUser->update(['password' => \Hash::make($request->new_password)]);

    return response()->json([
      'success' => true,
      'message' => 'Password updated successfully.'
    ]);
  }

  // Wishlist API Methods for React Frontend
  public function apiAddHotelToWishlist(Request $request)
  {
    try {
      $apiUser = auth('api')->user();
      if (!$apiUser) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $validator = Validator::make($request->all(), [
        'hotel_id' => 'required|integer|exists:hotels,id'
      ]);

      if ($validator->fails()) {
        return response()->json(['success' => false, 'errors' => $validator->errors()], 422);
      }

      $hotelId = $request->hotel_id;
      $userId = $apiUser->id;

      // Check if already in wishlist
      $existingWishlist = \App\Models\HotelWishlist::where('hotel_id', $hotelId)
        ->where('user_id', $userId)
        ->first();

      if ($existingWishlist) {
        return response()->json([
          'success' => true,
          'message' => 'Hotel is already in your wishlist',
          'in_wishlist' => true
        ]);
      }

      // Add to wishlist
      $wishlist = new \App\Models\HotelWishlist();
      $wishlist->hotel_id = $hotelId;
      $wishlist->user_id = $userId;
      $wishlist->save();

      return response()->json([
        'success' => true,
        'message' => 'Hotel added to wishlist successfully',
        'in_wishlist' => true
      ]);

    } catch (\Exception $e) {
      \Log::error('API Add Hotel to Wishlist error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while adding hotel to wishlist: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiRemoveHotelFromWishlist(Request $request)
  {
    try {
      $apiUser = auth('api')->user();
      if (!$apiUser) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $validator = Validator::make($request->all(), [
        'hotel_id' => 'required|integer|exists:hotels,id'
      ]);

      if ($validator->fails()) {
        return response()->json(['success' => false, 'errors' => $validator->errors()], 422);
      }

      $hotelId = $request->hotel_id;
      $userId = $apiUser->id;

      // Remove from wishlist
      $wishlist = \App\Models\HotelWishlist::where('hotel_id', $hotelId)
        ->where('user_id', $userId)
        ->first();

      if (!$wishlist) {
        return response()->json([
          'success' => false,
          'message' => 'Hotel is not in your wishlist'
        ], 404);
      }

      $wishlist->delete();

      return response()->json([
        'success' => true,
        'message' => 'Hotel removed from wishlist successfully',
        'in_wishlist' => false
      ]);

    } catch (\Exception $e) {
      \Log::error('API Remove Hotel from Wishlist error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while removing hotel from wishlist: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiCheckHotelWishlist($hotelId)
  {
    try {
      $apiUser = auth('api')->user();
      if (!$apiUser) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $userId = $apiUser->id;

      $inWishlist = \App\Models\HotelWishlist::where('hotel_id', $hotelId)
        ->where('user_id', $userId)
        ->exists();

      return response()->json([
        'success' => true,
        'in_wishlist' => $inWishlist
      ]);

    } catch (\Exception $e) {
      \Log::error('API Check Hotel Wishlist error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while checking wishlist status: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiGetHotelWishlists()
  {
    try {
      $apiUser = auth('api')->user();
      if (!$apiUser) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $userId = $apiUser->id;

      $wishlists = \App\Models\HotelWishlist::where('user_id', $userId)
        ->with(['hotel' => function($query) {
          $query->select('id', 'name', 'image', 'price', 'stars', 'location');
        }])
        ->get();

      return response()->json([
        'success' => true,
        'wishlists' => $wishlists
      ]);

    } catch (\Exception $e) {
      \Log::error('API Get Hotel Wishlists error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while fetching wishlists: ' . $e->getMessage()
      ], 500);
    }
  }

  // User Dashboard API Methods for React Frontend
  public function apiGetDashboardStats()
  {
    try {
      $apiUser = auth('api')->user();
      if (!$apiUser) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $userId = $apiUser->id;

      // Get counts for dashboard statistics
      $totalBookings = \App\Models\Booking::where('user_id', $userId)->count();
      $upcomingBookings = \App\Models\Booking::where('user_id', $userId)
        ->where('check_in_date', '>=', now()->format('Y-m-d'))
        ->count();
      $totalReviews = \App\Models\Review::where('user_id', $userId)->count();
      $totalFavorites = \App\Models\HotelWishlist::where('user_id', $userId)->count() + 
                       \App\Models\RoomWishlist::where('user_id', $userId)->count();

      return response()->json([
        'success' => true,
        'stats' => [
          'total_bookings' => $totalBookings,
          'upcoming_bookings' => $upcomingBookings,
          'total_reviews' => $totalReviews,
          'total_favorites' => $totalFavorites
        ]
      ]);

    } catch (\Exception $e) {
      \Log::error('API Get Dashboard Stats error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while fetching dashboard stats: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiGetDashboardBookings()
  {
    try {
      $apiUser = auth('api')->user();
      if (!$apiUser) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $userId = $apiUser->id;

      // Get recent bookings with related data
      $bookings = \App\Models\Booking::where('user_id', $userId)
        ->with([
          'hotel' => function($query) {
            $query->select('id', 'name', 'city', 'state', 'country');
          },
          'hotelRoom' => function($query) {
            $query->select('id', 'room_number', 'room_type');
          }
        ])
        ->orderBy('created_at', 'desc')
        ->limit(5)
        ->get();

      return response()->json([
        'success' => true,
        'bookings' => $bookings
      ]);

    } catch (\Exception $e) {
      \Log::error('API Get Dashboard Bookings error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while fetching dashboard bookings: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiGetDashboardWishlists()
  {
    try {
      $apiUser = auth('api')->user();
      if (!$apiUser) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $userId = $apiUser->id;

      // Get hotel wishlists
      $hotelWishlists = \App\Models\HotelWishlist::where('user_id', $userId)
        ->with([
          'hotel' => function($query) {
            $query->select('id', 'name', 'logo', 'city', 'state', 'country');
          }
        ])
        ->limit(3)
        ->get();

      // Get room wishlists
      $roomWishlists = \App\Models\RoomWishlist::where('user_id', $userId)
        ->with([
          'room' => function($query) {
            $query->select('id', 'room_number', 'room_type');
          },
          'hotel' => function($query) {
            $query->select('id', 'name', 'city', 'state', 'country');
          }
        ])
        ->limit(3)
        ->get();

      return response()->json([
        'success' => true,
        'hotel_wishlists' => $hotelWishlists,
        'room_wishlists' => $roomWishlists
      ]);

    } catch (\Exception $e) {
      \Log::error('API Get Dashboard Wishlists error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while fetching dashboard wishlists: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiGetRecentActivity()
  {
    try {
      $apiUser = auth('api')->user();
      if (!$apiUser) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $userId = $apiUser->id;

      // Get recent activity from multiple sources
      $recentBookings = \App\Models\Booking::where('user_id', $userId)
        ->orderBy('created_at', 'desc')
        ->limit(3)
        ->get();

      $recentReviews = \App\Models\RoomReview::where('user_id', $userId)
        ->orderBy('created_at', 'desc')
        ->limit(3)
        ->get();

      $recentWishlists = \App\Models\HotelWishlist::where('user_id', $userId)
        ->orderBy('created_at', 'desc')
        ->limit(3)
        ->get();

      return response()->json([
        'success' => true,
        'recent_activity' => [
          'bookings' => $recentBookings,
          'reviews' => $recentReviews,
          'wishlists' => $recentWishlists
        ]
      ]);

    } catch (\Exception $e) {
      \Log::error('API Get Recent Activity error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred: ' . $e->getMessage()
      ], 500);
    }
  }

  // Check user authentication status for web-authenticated users
  public function checkUserAuthStatus()
  {
    try {
      if (Auth::guard('web')->check()) {
        $user = Auth::guard('web')->user();
        return response()->json([
          'success' => true,
          'authenticated' => true,
          'user' => $user
        ]);
      } else {
        return response()->json([
          'success' => true,
          'authenticated' => false,
          'user' => null
        ]);
      }
    } catch (\Exception $e) {
      \Log::error('User auth status check error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while checking authentication status'
      ], 500);
    }
  }

  // Simple dashboard data endpoint (no authentication required)
  public function getSimpleDashboardData()
  {
    try {
      // Try to get user from JWT token first, then web session
      $user = null;
      $userId = null;
      
      // Check JWT authentication first
      if (Auth::guard('api')->check()) {
        $user = Auth::guard('api')->user();
        $userId = $user->id;
        \Log::info('User authenticated via JWT: ' . $user->id);
      }
      // Fallback to web session
      elseif (Auth::guard('web')->check()) {
        $user = Auth::guard('web')->user();
        $userId = $user->id;
        \Log::info('User authenticated via web session: ' . $user->id);
      }
      // Try to get user from Authorization header manually
      else {
        $token = request()->bearerToken();
        if ($token) {
          try {
            \Log::info('Attempting to decode JWT token manually');
            // Try to decode the token without verification first
            $tokenParts = explode('.', $token);
            if (count($tokenParts) === 3) {
              $payload = json_decode(base64_decode($tokenParts[1]), true);
              if ($payload && isset($payload['sub'])) {
                $userId = $payload['sub'];
                $user = \App\Models\User::find($userId);
                if ($user) {
                  \Log::info('User found via manual JWT decode: ' . $user->id);
                }
              }
            }
          } catch (\Exception $e) {
            \Log::error('Manual JWT decode failed: ' . $e->getMessage());
          }
        }
      }
      
      if ($user && $userId) {
        
        // Get counts for dashboard statistics
        $totalBookings = \App\Models\Booking::where('user_id', $userId)->count();
        $upcomingBookings = \App\Models\Booking::where('user_id', $userId)
          ->where('check_in_date', '>=', now()->format('Y-m-d'))
          ->count();
        $totalReviews = \App\Models\RoomReview::where('user_id', $userId)->count();
        $totalFavorites = \App\Models\HotelWishlist::where('user_id', $userId)->count() + 
                         \App\Models\RoomWishlist::where('user_id', $userId)->count();

        // Get recent bookings
        $recentBookings = \App\Models\Booking::where('user_id', $userId)
          ->with([
            'hotelRoom.hotel.hotel_contents' => function($query) {
              $query->select('id', 'hotel_id', 'title', 'city_id', 'state_id', 'country_id');
            },
            'hotelRoom.room_content' => function($query) {
              $query->select('id', 'room_id', 'title', 'room_category');
            }
          ])
          ->orderBy('created_at', 'desc')
          ->limit(5)
          ->get();

        // Add location names to recent bookings
        foreach ($recentBookings as $booking) {
          if ($booking->hotelRoom && $booking->hotelRoom->hotel && $booking->hotelRoom->hotel->hotel_contents->first()) {
            $hotelContent = $booking->hotelRoom->hotel->hotel_contents->first();
            
            // Get city name
            if ($hotelContent->city_id) {
              $city = \DB::table('cities')->where('id', $hotelContent->city_id)->first();
              $booking->hotelRoom->hotel->city_name = $city ? $city->name : null;
            }
            
            // Get state name
            if ($hotelContent->state_id) {
              $state = \DB::table('states')->where('id', $hotelContent->state_id)->first();
              $booking->hotelRoom->hotel->state_name = $state ? $state->name : null;
            }
            
            // Get country name
            if ($hotelContent->country_id) {
              $country = \DB::table('countries')->where('id', $hotelContent->country_id)->first();
              $booking->hotelRoom->hotel->country_name = $country ? $country->name : null;
            }
            
            // Add hotel title
            $booking->hotelRoom->hotel->hotel_title = $hotelContent->title;
          }
        }

        // Get hotel wishlists
        $hotelWishlists = \App\Models\HotelWishlist::where('user_id', $userId)
          ->with([
            'hotel.hotel_contents' => function($query) {
              $query->select('id', 'hotel_id', 'title', 'city_id', 'state_id', 'country_id');
            }
          ])
          ->limit(3)
          ->get();

        // Add location names to hotel wishlists
        foreach ($hotelWishlists as $wishlist) {
          if ($wishlist->hotel && $wishlist->hotel->hotel_contents->first()) {
            $hotelContent = $wishlist->hotel->hotel_contents->first();
            
            // Get city name
            if ($hotelContent->city_id) {
              $city = \DB::table('cities')->where('id', $hotelContent->city_id)->first();
              $wishlist->hotel->city_name = $city ? $city->name : null;
            }
            
            // Get state name
            if ($hotelContent->state_id) {
              $state = \DB::table('states')->where('id', $hotelContent->state_id)->first();
              $wishlist->hotel->state_name = $state ? $state->name : null;
            }
            
            // Get country name
            if ($hotelContent->country_id) {
              $country = \DB::table('countries')->where('id', $hotelContent->country_id)->first();
              $wishlist->hotel->country_name = $country ? $country->name : null;
            }
            
            // Add hotel title
            $wishlist->hotel->hotel_title = $hotelContent->title;
          }
        }

        return response()->json([
          'success' => true,
          'user' => $user,
          'stats' => [
            'total_bookings' => $totalBookings,
            'upcoming_bookings' => $upcomingBookings,
            'total_reviews' => $totalReviews,
            'total_favorites' => $totalFavorites
          ],
          'recent_bookings' => $recentBookings,
          'hotel_wishlists' => $hotelWishlists
        ]);
      } else {
        // Return empty data for unauthenticated users (React app will handle this)
        return response()->json([
          'success' => true,
          'user' => null,
          'stats' => [
            'total_bookings' => 0,
            'upcoming_bookings' => 0,
            'total_reviews' => 0,
            'total_favorites' => 0
          ],
          'recent_bookings' => [],
          'hotel_wishlists' => []
        ]);
      }
    } catch (\Exception $e) {
      \Log::error('Simple Dashboard Data error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while fetching dashboard data: ' . $e->getMessage()
      ], 500);
    }
  }

  // Test authentication endpoint
  public function testAuth()
  {
    try {
      $webAuth = Auth::guard('web')->check();
      $webUser = Auth::guard('web')->user();
      $apiAuth = Auth::guard('api')->check();
      $apiUser = Auth::guard('api')->user();
      
      return response()->json([
        'success' => true,
        'web_authenticated' => $webAuth,
        'web_user' => $webUser ? $webUser->only(['id', 'name', 'email']) : null,
        'api_authenticated' => $apiAuth,
        'api_user' => $apiUser ? $apiUser->only(['id', 'name', 'email']) : null,
        'session_id' => session()->getId(),
        'session_started' => session()->isStarted(),
        'csrf_token' => csrf_token()
      ]);
    } catch (\Exception $e) {
      return response()->json([
        'success' => false,
        'error' => $e->getMessage()
      ], 500);
    }
  }

  // Session-based Dashboard API Methods for web-authenticated users
  public function apiGetDashboardStatsSession()
  {
    try {
      $user = Auth::guard('web')->user();
      if (!$user) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $userId = $user->id;

      // Get counts for dashboard statistics
      $totalBookings = \App\Models\Booking::where('user_id', $userId)->count();
      $upcomingBookings = \App\Models\Booking::where('user_id', $userId)
        ->where('check_in_date', '>=', now()->format('Y-m-d'))
        ->count();
      $totalReviews = \App\Models\RoomReview::where('user_id', $userId)->count();
      $totalFavorites = \App\Models\HotelWishlist::where('user_id', $userId)->count() + 
                       \App\Models\RoomWishlist::where('user_id', $userId)->count();

      return response()->json([
        'success' => true,
        'stats' => [
          'total_bookings' => $totalBookings,
          'upcoming_bookings' => $upcomingBookings,
          'total_reviews' => $totalReviews,
          'total_favorites' => $totalFavorites
        ]
      ]);

    } catch (\Exception $e) {
      \Log::error('Session Dashboard Stats error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while fetching dashboard stats: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiGetDashboardBookingsSession()
  {
    try {
      $user = Auth::guard('web')->user();
      if (!$user) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $userId = $user->id;

      // Get recent bookings with related data
      $bookings = \App\Models\Booking::where('user_id', $userId)
        ->with([
          'hotel' => function($query) {
            $query->select('id', 'name', 'city', 'state', 'country');
          },
          'hotelRoom' => function($query) {
            $query->select('id', 'room_number', 'room_type');
          }
        ])
        ->orderBy('created_at', 'desc')
        ->limit(5)
        ->get();

      return response()->json([
        'success' => true,
        'bookings' => $bookings
      ]);

    } catch (\Exception $e) {
      \Log::error('Session Dashboard Bookings error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while fetching dashboard bookings: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiGetDashboardWishlistsSession()
  {
    try {
      $user = Auth::guard('web')->user();
      if (!$user) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $userId = $user->id;

      // Get hotel wishlists
      $hotelWishlists = \App\Models\HotelWishlist::where('user_id', $userId)
        ->with([
          'hotel' => function($query) {
            $query->select('id', 'name', 'logo', 'city', 'state', 'country');
          }
        ])
        ->limit(3)
        ->get();

      // Get room wishlists
      $roomWishlists = \App\Models\RoomWishlist::where('user_id', $userId)
        ->with([
          'room' => function($query) {
            $query->select('id', 'room_number', 'room_type');
          },
          'hotel' => function($query) {
            $query->select('id', 'name', 'city', 'state', 'country');
          }
        ])
        ->limit(3)
        ->get();

      return response()->json([
        'success' => true,
        'hotel_wishlists' => $hotelWishlists,
        'room_wishlists' => $roomWishlists
      ]);

    } catch (\Exception $e) {
      \Log::error('Session Dashboard Wishlists error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while fetching dashboard wishlists: ' . $e->getMessage()
      ], 500);
    }
  }

  // Session-based wishlist methods
  public function apiAddHotelToWishlistSession(Request $request)
  {
    try {
      $user = Auth::guard('web')->user();
      if (!$user) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $validator = Validator::make($request->all(), [
        'hotel_id' => 'required|integer|exists:hotels,id'
      ]);

      if ($validator->fails()) {
        return response()->json(['success' => false, 'errors' => $validator->errors()], 422);
      }

      $hotelId = $request->hotel_id;
      $userId = $user->id;

      // Check if already in wishlist
      $existingWishlist = HotelWishlist::where('hotel_id', $hotelId)
        ->where('user_id', $userId)
        ->first();

      if ($existingWishlist) {
        return response()->json([
          'success' => true,
          'message' => 'Hotel is already in your wishlist',
          'in_wishlist' => true
        ]);
      }

      // Add to wishlist
      $wishlist = new HotelWishlist();
      $wishlist->hotel_id = $hotelId;
      $wishlist->user_id = $userId;
      $wishlist->save();

      return response()->json([
        'success' => true,
        'message' => 'Hotel added to wishlist successfully',
        'in_wishlist' => true
      ]);

    } catch (\Exception $e) {
      \Log::error('Session Add Hotel to Wishlist error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while adding hotel to wishlist: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiRemoveHotelFromWishlistSession(Request $request)
  {
    try {
      $user = Auth::guard('web')->user();
      if (!$user) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $validator = Validator::make($request->all(), [
        'hotel_id' => 'required|integer|exists:hotels,id'
      ]);

      if ($validator->fails()) {
        return response()->json(['success' => false, 'errors' => $validator->errors()], 422);
      }

      $hotelId = $request->hotel_id;
      $userId = $user->id;

      // Remove from wishlist
      $wishlist = HotelWishlist::where('hotel_id', $hotelId)
        ->where('user_id', $userId)
        ->first();

      if (!$wishlist) {
        return response()->json([
          'success' => false,
          'message' => 'Hotel is not in your wishlist'
        ], 404);
      }

      $wishlist->delete();

      return response()->json([
        'success' => true,
        'message' => 'Hotel removed from wishlist successfully',
        'in_wishlist' => false
      ]);

    } catch (\Exception $e) {
      \Log::error('Session Remove Hotel from Wishlist error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while removing hotel from wishlist: ' . $e->getMessage()
      ], 500);
    }
  }

  public function apiGetHotelWishlistsSession()
  {
    try {
      $user = Auth::guard('web')->user();
      if (!$user) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 401);
      }

      $userId = $user->id;

      $wishlists = HotelWishlist::where('user_id', $userId)
        ->with(['hotel' => function($query) {
          $query->select('id', 'name', 'image', 'price', 'stars', 'location');
        }])
        ->get();

      return response()->json([
        'success' => true,
        'wishlists' => $wishlists
      ]);

    } catch (\Exception $e) {
      \Log::error('Session Get Hotel Wishlists error: ' . $e->getMessage());
      return response()->json([
        'success' => false,
        'message' => 'An error occurred while fetching wishlists: ' . $e->getMessage()
      ], 500);
    }
  }
}
