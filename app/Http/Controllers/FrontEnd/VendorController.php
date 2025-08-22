<?php
namespace App\Http\Controllers\FrontEnd;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Models\Vendor;
use App\Models\BasicSettings;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Mail;
class VendorController extends Controller
{
    public function apiLogin(Request $request)
    {
        try {
            \Log::info('Vendor API Login attempt');
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
            
            // Prepare credentials for authentication
            $credentials = [
                'password' => $request->password
            ];
            
            // Check if input is email or username
            if (filter_var($request->username, FILTER_VALIDATE_EMAIL)) {
                $credentials['email'] = $request->username;
            } else {
                $credentials['username'] = $request->username;
            }
            if (Auth::guard('vendor')->attempt($credentials)) {
                $authVendor = Auth::guard('vendor')->user();
                \Log::info('Vendor API Login successful - Vendor: ' . $authVendor->username);
                $setting = DB::table('basic_settings')->where('uniqid', 12345)->select('vendor_email_verification', 'vendor_admin_approval')->first();
                if ($setting && $setting->vendor_email_verification == 1 && $authVendor->email_verified_at == null) {
                    Auth::guard('vendor')->logout();
                    return response()->json([
                        'success' => false,
                        'message' => 'Please verify your email address'
                    ], 401);
                }
                if ($setting && $setting->vendor_admin_approval == 1 && $authVendor->status == 0) {
                    Auth::guard('vendor')->logout();
                    return response()->json([
                        'success' => false,
                        'message' => 'Your account is pending admin approval'
                    ], 401);
                }
                if ($authVendor->status == 0) {
                    Auth::guard('vendor')->logout();
                    return response()->json([
                        'success' => false,
                        'message' => 'Sorry, your account has been deactivated'
                    ], 401);
                }
                
                // Return vendor ID instead of JWT token
                \Log::info('Vendor login successful, returning vendor ID: ' . $authVendor->id);
                return response()->json([
                    'success' => true,
                    'message' => 'Login successful',
                    'user' => [
                        'id' => $authVendor->id,
                        'username' => $authVendor->username,
                        'email' => $authVendor->email,
                        'role' => 'vendor',
                        'status' => $authVendor->status
                    ],
                    'vendor_id' => $authVendor->id
                ]);
            } else {
                \Log::info('Vendor API Login failed - Invalid credentials');
                return response()->json([
                    'success' => false,
                    'message' => 'Incorrect username/email or password'
                ], 401);
            }
        } catch (\Exception $e) {
            \Log::error('Vendor API Login error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Login failed. Please try again.'
            ], 500);
        }
    }
    public function apiSignup(Request $request)
    {
        try {
            \Log::info('Vendor API Signup attempt');
            $rules = [
                'name' => 'required|string|max:255',
                'username' => 'required|string|max:255|unique:vendors,username',
                'email' => 'required|email|max:255|unique:vendors,email',
                'phone' => 'required|string|max:255',
                'address' => 'required|string',
                'password' => 'required|string|min:8|confirmed'
            ];
            $validator = Validator::make($request->all(), $rules);
            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }
            $setting = DB::table('basic_settings')->where('uniqid', 12345)->select('vendor_admin_approval', 'vendor_email_verification')->first();
            
            // Generate email verification token if email verification is enabled
            $emailVerificationToken = null;
            if ($setting && $setting->vendor_email_verification == 1) {
                $emailVerificationToken = Str::random(64);
            }
            
            $in = [
                'username' => $request->username,
                'email' => $request->email,
                'phone' => $request->phone,
                'password' => Hash::make($request->password),
                'to_mail' => $request->email,
                'status' => 0, 
                'email_verification_token' => $emailVerificationToken,
                'created_at' => now(),
                'updated_at' => now()
            ];
            
            if ($setting) {
                if ($setting->vendor_admin_approval == 1) {
                    $in['status'] = 0; 
                } else {
                    $in['status'] = 1; 
                }
            }
            
            $vendor = Vendor::create($in);
            \Log::info('Vendor created successfully: ' . $vendor->username);
            
            // Send verification email if email verification is enabled
            if ($setting && $setting->vendor_email_verification == 1 && $emailVerificationToken) {
                try {
                    $this->sendVerificationEmail($vendor, $emailVerificationToken);
                    \Log::info('Verification email sent to: ' . $vendor->email);
                } catch (\Exception $e) {
                    \Log::error('Failed to send verification email: ' . $e->getMessage());
                }
            }
            
            $message = 'Vendor account created successfully.';
            if ($setting) {
                if ($setting->vendor_admin_approval == 1) {
                    $message .= ' Please wait for admin approval.';
                }
                if ($setting->vendor_email_verification == 1) {
                    $message .= ' Please check your email and verify your account.';
                }
            }
            
            return response()->json([
                'success' => true,
                'message' => $message,
                'vendor' => [
                    'id' => $vendor->id,
                    'username' => $vendor->username,
                    'email' => $vendor->email,
                    'status' => $vendor->status,
                    'email_verification_required' => $setting && $setting->vendor_email_verification == 1
                ]
            ], 201);
        } catch (\Exception $e) {
            \Log::error('Vendor API Signup error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Registration failed. Please try again.'
            ], 500);
        }
    }
    public function getUser(Request $request)
    {
        try {
            \Log::info('Vendor getUser API called');
            
            // Get vendor ID from query parameters
            $vendorId = $request->get('vendor_id');
            
            if (!$vendorId) {
                return response()->json([
                    'success' => false,
                    'message' => 'Vendor ID is required'
                ], 400);
            }
            
            // Find vendor by ID
            $vendor = Vendor::find($vendorId);
            
            if (!$vendor) {
                return response()->json([
                    'success' => false,
                    'message' => 'Vendor not found'
                ], 404);
            }
            
            if ($vendor->status != 1) {
                return response()->json([
                    'success' => false,
                    'message' => 'Vendor account is inactive'
                ], 401);
            }
            
            \Log::info('Vendor found: ' . $vendor->username);
            return response()->json([
                'success' => true,
                'user' => [
                    'id' => $vendor->id,
                    'username' => $vendor->username,
                    'email' => $vendor->email,
                    'name' => $vendor->username, 
                    'role' => 'vendor',
                    'status' => $vendor->status
                ]
            ]);
        } catch (\Exception $e) {
            \Log::error('Vendor getUser API error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to get vendor information'
            ], 500);
        }
    }
    
    /**
     * Check vendor authentication status from session
     */
    public function checkAuthStatus(Request $request)
    {
        try {
            \Log::info('Vendor auth status check called');
            
            // Check if vendor is authenticated via session
            if (Auth::guard('vendor')->check()) {
                $vendor = Auth::guard('vendor')->user();
                \Log::info('Vendor authenticated via session: ' . $vendor->username);
                
                return response()->json([
                    'success' => true,
                    'authenticated' => true,
                    'user' => [
                        'id' => $vendor->id,
                        'username' => $vendor->username,
                        'email' => $vendor->email,
                        'name' => $vendor->username,
                        'role' => 'vendor',
                        'status' => $vendor->status
                    ]
                ]);
            } else {
                \Log::info('No vendor authenticated via session');
                return response()->json([
                    'success' => true,
                    'authenticated' => false,
                    'message' => 'No vendor authenticated'
                ]);
            }
        } catch (\Exception $e) {
            \Log::error('Vendor auth status check error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to check authentication status'
            ], 500);
        }
    }
    
    /**
     * Send verification email to vendor using dynamic template
     */
    private function sendVerificationEmail($vendor, $token)
    {
        try {
            // Get the email verification template from database
            $template = DB::table('mail_templates')->where('mail_type', 'verify_email')->first();
            
            if (!$template) {
                \Log::error('Email verification template not found');
                throw new \Exception('Email template not found');
            }
            
            $verificationUrl = url('/vendor/verify-email/' . $token);
            
            // Replace placeholders in the template
            $mailBody = $template->mail_body;
            $mailBody = str_replace('{username}', $vendor->username, $mailBody);
            $mailBody = str_replace('{verification_link}', '<a href="' . $verificationUrl . '">Click here to verify your email</a>', $mailBody);
            
            // Get SMTP settings from database
            $smtpSettings = DB::table('basic_settings')->where('uniqid', 12345)->first();
            
            if ($smtpSettings && $smtpSettings->smtp_status == 1) {
                // Configure SMTP dynamically from database
                $smtp = [
                    'transport' => 'smtp',
                    'host' => $smtpSettings->smtp_host,
                    'port' => $smtpSettings->smtp_port,
                    'encryption' => $smtpSettings->encryption,
                    'username' => $smtpSettings->smtp_username,
                    'password' => $smtpSettings->smtp_password,
                    'timeout' => null,
                    'auth_mode' => null,
                ];
                
                \Config::set('mail.mailers.smtp', $smtp);
                
                // Send email using dynamic template and SMTP settings
                Mail::send([], [], function($message) use ($vendor, $template, $mailBody, $smtpSettings) {
                    $message->to($vendor->email, $vendor->username)
                            ->subject($template->mail_subject)
                            ->from($smtpSettings->from_mail, $smtpSettings->from_name)
                            ->html($mailBody, 'text/html');
                });
                
                \Log::info('Verification email sent via SMTP to: ' . $vendor->email);
            } else {
                // Fallback to log driver if SMTP is disabled
                \Log::info('SMTP disabled, logging email instead');
                \Log::info('Verification email content for ' . $vendor->email . ': ' . $mailBody);
            }
            
        } catch (\Exception $e) {
            \Log::error('Failed to send verification email: ' . $e->getMessage());
            throw $e;
        }
    }
    
    /**
     * Resend verification email
     */
    public function resendVerificationEmail(Request $request)
    {
        try {
            $request->validate([
                'email' => 'required|email'
            ]);
            
            $vendor = Vendor::where('email', $request->email)->first();
            
            if (!$vendor) {
                return response()->json([
                    'success' => false,
                    'message' => 'Vendor not found with this email address'
                ], 404);
            }
            
            if ($vendor->email_verified_at) {
                return response()->json([
                    'success' => false,
                    'message' => 'Email is already verified'
                ], 400);
            }
            
            // Generate new verification token
            $newToken = Str::random(64);
            $vendor->update(['email_verification_token' => $newToken]);
            
            // Send new verification email
            $this->sendVerificationEmail($vendor, $newToken);
            
            return response()->json([
                'success' => true,
                'message' => 'Verification email sent successfully'
            ]);
            
        } catch (\Exception $e) {
            \Log::error('Resend verification email error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to send verification email'
            ], 500);
        }
    }

    /**
     * API Logout method for vendors
     */
    public function apiLogout(Request $request)
    {
        try {
            \Log::info('Vendor API Logout attempt');
            
            // Logout from vendor guard
            Auth::guard('vendor')->logout();
            
            // Clear any vendor-related sessions
            Session::forget('secret_login');
            Session::forget('vendor_id');
            Session::forget('vendor_data');
            
            // Clear vendor token cookie if it exists
            if ($request->hasCookie('vendor_token')) {
                Cookie::queue(Cookie::forget('vendor_token'));
            }
            
            \Log::info('Vendor API Logout successful');
            
            return response()->json([
                'success' => true,
                'message' => 'Logout successful'
            ]);
            
        } catch (\Exception $e) {
            \Log::error('Vendor API Logout error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Logout failed. Please try again.'
            ], 500);
        }
    }
}
