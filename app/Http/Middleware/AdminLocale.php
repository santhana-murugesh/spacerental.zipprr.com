<?php

namespace App\Http\Middleware;

use Closure;
use App\Models\Language;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Auth;

class AdminLocale
{
  /**
   * Handle an incoming request.
   *
   * @param  \Illuminate\Http\Request  $request
   * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
   * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
   */
  public function handle(Request $request, Closure $next)
  {
    try {
      if (Auth::guard('admin')->check()) {
        $admin = Auth::guard('admin')->user();
        if ($admin && isset($admin->lang_code)) {
          $locale = $admin->lang_code;
        }
      }

      if (empty($locale)) {
        // set the default language as system locale
        $code = Language::query()->where('is_default', '=', 1)
          ->pluck('code')
          ->first();
        $languageCode = 'admin_' . $code;

        App::setLocale($languageCode);
      } else {
        // set the selected language as system locale
        App::setLocale($locale);
      }
    } catch (\Exception $e) {
      // Log error but don't break the request
      \Log::warning('AdminLocale middleware error: ' . $e->getMessage());
      
      // Fallback to default language
      try {
        $code = Language::query()->where('is_default', '=', 1)
          ->pluck('code')
          ->first();
        $languageCode = 'admin_' . $code;
        App::setLocale($languageCode);
      } catch (\Exception $fallbackError) {
        // Ultimate fallback
        App::setLocale('admin_en');
      }
    }

    return $next($request);
  }
}
