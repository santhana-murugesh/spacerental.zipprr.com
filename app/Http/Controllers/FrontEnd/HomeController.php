<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use App\Http\Controllers\FrontEnd\MiscellaneousController;
use App\Models\BasicSettings\AboutUs;
use App\Models\BasicSettings\Basic;
use App\Models\HomePage\Banner;
use App\Models\HomePage\CustomSection;
use App\Models\HomePage\Feature;
use App\Models\HomePage\Section;
use App\Models\HomePage\SectionContent;
use App\Models\Intro;
use App\Models\Journal\Blog;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Models\Location\City;
use App\Models\Package;
use App\Models\RoomContent;

class HomeController extends Controller
{
  public function index(Request $request)
  {
    // Return React app view for the root route
    return view('frontend.react-layout');
  }

  public function about()
  {
    $misc = new MiscellaneousController();

    $language = $misc->getLanguage();

    $information['themeVersion'] = Basic::query()->pluck('theme_version')->first();

    $information['seoInfo'] = $language->seoInfo()->select('meta_keywords_about_page', 'meta_description_about_page')->first();
    $information['pageHeading'] = $misc->getPageHeading($language);

    $information['about'] = AboutUs::where('language_id', $language->id)->first();

    $information['bgImg'] = $misc->getBreadcrumb();
    $secInfo = Section::query()->first();
    $information['secInfo'] = $secInfo;
    $information['sectionContent'] = SectionContent::where('language_id', $language->id)->first();
    $information['images']  = Basic::select(
      'about_section_image',
      'feature_section_image',
      'counter_section_image',
      'call_to_action_section_image',
      'call_to_action_section_inner_image',
      'testimonial_section_image'
    )->first();

    if ($secInfo->about_features_section_status == 1) {
      $information['features'] = Feature::where('language_id', $language->id)->get();
    }
    if ($secInfo->work_process_section_status == 1) {
      $information['workProcessSecInfo'] = $language->workProcessSection()->first();
      $information['processes'] = $language->workProcess()->orderBy('serial_number', 'asc')->get();
    }

    if ($secInfo->about_testimonial_section_status == 1) {
      $information['testimonials'] = $language->testimonial()->orderByDesc('id')->get();
      $information['testimonialSecImage'] = Basic::query()->pluck('testimonial_section_image')->first();
    }

    if ($secInfo->about_counter_section_status == 1) {
      $information['counterSectionImage'] = Basic::query()->pluck('counter_section_image')->first();
      $information['counters'] = $language->counterInfo()->orderByDesc('id')->get();
    }

    $sections = ['about_section', 'features_section', 'counter_section', 'testimonial_section'];

    foreach ($sections as $section) {

      $information["after_" . str_replace('_section', '', $section)] = CustomSection::where('order', $section)
        ->where('page_type', 'about')
        ->orderBy('serial_number', 'asc')
        ->get();
    }

    $sectionInfo = Section::select('about_custom_section_status')->first();
    if (!empty($sectionInfo->about_custom_section_status)) {
      $info = json_decode($sectionInfo->about_custom_section_status, true);
      $information['aboutSec'] = $info;
    }
    
    return view('frontend.about-us', $information);
  }
  public function pricing(Request $request)
  {
    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();
    $data['bgImg'] = $misc->getBreadcrumb();

    $data['seoInfo'] = $language->seoInfo()->select('meta_keyword_pricing', 'meta_description_pricing')->first();

    $terms = [];
    if (Package::query()->where('status', '1')->where('term', 'monthly')->count() > 0) {
      $terms[] = 'Monthly';
    }
    if (Package::query()->where('status', '1')->where('term', 'yearly')->count() > 0) {
      $terms[] = 'Yearly';
    }
    if (Package::query()->where('status', '1')->where('term', 'lifetime')->count() > 0) {
      $terms[] = 'Lifetime';
    }
    $data['terms'] = $terms;

    $data['pageHeading'] = $misc->getPageHeading($language);

    return view('frontend.pricing', $data);
  }

  //offline
  public function offline()
  {
    return view('frontend.offline');
  }

  public function apiAboutUs(Request $request)
  {
    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();

    $information['themeVersion'] = Basic::query()->pluck('theme_version')->first();
    $information['seoInfo'] = $language->seoInfo()->select('meta_keywords_about_page', 'meta_description_about_page')->first();
    $information['pageHeading'] = $misc->getPageHeading($language);
    $information['about'] = AboutUs::where('language_id', $language->id)->first();
    $information['bgImg'] = $misc->getBreadcrumb();
    
    $secInfo = Section::query()->first();
    $information['secInfo'] = $secInfo;
    $information['sectionContent'] = SectionContent::where('language_id', $language->id)->first();
    $information['images'] = Basic::select(
      'about_section_image',
      'feature_section_image',
      'counter_section_image',
      'call_to_action_section_image',
      'call_to_action_section_inner_image',
      'testimonial_section_image'
    )->first();

    if ($secInfo->about_features_section_status == 1) {
      $information['features'] = Feature::where('language_id', $language->id)->get();
    }
    
    if ($secInfo->about_testimonial_section_status == 1) {
      $information['testimonials'] = $language->testimonial()->orderByDesc('id')->get();
      $information['testimonialSecImage'] = Basic::query()->pluck('testimonial_section_image')->first();
    }

    if ($secInfo->about_counter_section_status == 1) {
      $information['counterSectionImage'] = Basic::query()->pluck('counter_section_image')->first();
      $information['counters'] = $language->counterInfo()->orderByDesc('id')->get();
    }

    $sections = ['about_section', 'features_section', 'counter_section', 'testimonial_section'];

    foreach ($sections as $section) {
      $information["after_" . str_replace('_section', '', $section)] = CustomSection::where('order', $section)
        ->where('page_type', 'about')
        ->orderBy('serial_number', 'asc')
        ->get();
    }

    $sectionInfo = Section::select('about_custom_section_status')->first();
    if (!empty($sectionInfo->about_custom_section_status)) {
      $info = json_decode($sectionInfo->about_custom_section_status, true);
      $information['aboutSec'] = $info;
    }
    
    return response()->json($information);
  }
}
