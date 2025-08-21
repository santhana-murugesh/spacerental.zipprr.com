<?php
namespace App\Http\Middleware;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Vendor;

class JwtToVendorSession
{
    /**
     * Handle an incoming request.
     *
     * @param  Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        // Check if vendor is already authenticated via session
        if (Auth::guard('vendor')->check()) {
            \Log::info('Vendor already authenticated via session', [
                'vendor_id' => Auth::guard('vendor')->user()->id,
                'username' => Auth::guard('vendor')->user()->username
            ]);
            return $next($request);
        }

        // Check if there's a vendor ID in the query parameters
        $vendorId = $request->get('vendor_id');
        
        if ($vendorId) {
            \Log::info('Attempting vendor authentication via vendor_id', [
                'vendor_id' => $vendorId
            ]);
            
            try {
                // Find and verify vendor
                $vendor = Vendor::find($vendorId);
                if (!$vendor) {
                    \Log::warning('Vendor not found', ['vendor_id' => $vendorId]);
                    return redirect('/')->with('error', 'Vendor account not found.');
                }
                
                if ($vendor->status != 1) {
                    \Log::warning('Vendor account inactive', ['vendor_id' => $vendorId, 'status' => $vendor->status]);
                    return redirect('/')->with('error', 'Vendor account is inactive.');
                }
                
                // Check email verification if required
                $setting = \DB::table('basic_settings')->where('uniqid', 12345)->select('vendor_email_verification')->first();
                if ($setting && $setting->vendor_email_verification == 1 && $vendor->email_verified_at == null) {
                    \Log::warning('Vendor email not verified', ['vendor_id' => $vendorId]);
                    return redirect('/')->with('error', 'Please verify your email address before accessing the dashboard.');
                }
                
                // Log in the vendor
                Auth::guard('vendor')->login($vendor);
                session()->regenerate();
                
                \Log::info('Vendor authentication successful via vendor_id', [
                    'vendor_id' => $vendor->id,
                    'username' => $vendor->username
                ]);
                
                return $next($request);
                
            } catch (\Exception $e) {
                \Log::error('Vendor authentication failed', [
                    'error' => $e->getMessage(),
                    'vendor_id' => $vendorId
                ]);
                return redirect('/')->with('error', 'Authentication failed. Please login again.');
            }
        }

        // No authentication found
        \Log::info('No vendor authentication found');
        if ($request->expectsJson()) {
            return response()->json([
                'success' => false,
                'message' => 'Authentication required'
            ], 401);
        }
        
        return redirect('/')->with('error', 'Please login to access the vendor dashboard.');
    }
}
