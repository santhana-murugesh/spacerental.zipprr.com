import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { useAuth } from './AuthContext';

export const VendorLogin = ({ setShowVendorLogin, setShowVendorSignUp }) => {
    const location = useLocation();
    const navigate = useNavigate();
    const { login, user } = useAuth();
    const [formData, setFormData] = useState({
        username: '',
        password: ''
    });
    const [errors, setErrors] = useState({});
    const [loading, setLoading] = useState(false);
    const [message, setMessage] = useState('');
    const [fontAwesomeLoaded, setFontAwesomeLoaded] = useState(false);
    const [socialLoading, setSocialLoading] = useState({ google: false, facebook: false });
    const [socialLoginEnabled, setSocialLoginEnabled] = useState({ google: false, facebook: false });
    
    const API_BASE_URL = window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
        ? import.meta.env.VITE_API_BASE_URL_LOCAL
        : import.meta.env.VITE_API_BASE_URL;

    const checkFontAwesomeLoaded = () => {
        const testIcon = document.createElement('i');
        testIcon.className = 'fas fa-check';
        testIcon.style.position = 'absolute';
        testIcon.style.left = '-9999px';
        document.body.appendChild(testIcon);
        const computedStyle = window.getComputedStyle(testIcon, '::before');
        const content = computedStyle.content;
        document.body.removeChild(testIcon);
        return content && content !== 'none' && content !== 'normal';
    };

    const ensureFontAwesomeLoaded = () => {
        if (checkFontAwesomeLoaded()) {
            setFontAwesomeLoaded(true);
            return;
        }
        const existingLink = document.querySelector('link[href*="font-awesome"]');
        if (!existingLink) {
            const link = document.createElement('link');
            link.rel = 'stylesheet';
            link.href = '/assets/front/fonts/fontawesome/css/all.min.css';
            link.onload = () => {
                setTimeout(() => {
                    setFontAwesomeLoaded(true);
                }, 100);
            };
            link.onerror = () => {
                const cdnLink = document.createElement('link');
                cdnLink.rel = 'stylesheet';
                cdnLink.href = 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css';
                cdnLink.onload = () => {
                    setTimeout(() => {
                        setFontAwesomeLoaded(true);
                    }, 100);
                };
                document.head.appendChild(cdnLink);
            };
            document.head.appendChild(link);
        } else {
            setTimeout(() => {
                if (checkFontAwesomeLoaded()) {
                    setFontAwesomeLoaded(true);
                } else {
                    existingLink.href = existingLink.href + '?v=' + Date.now();
                    setTimeout(() => setFontAwesomeLoaded(true), 200);
                }
            }, 100);
        }
    };

    const checkSocialLoginStatus = async () => {
        try {
            const response = await fetch(`${API_BASE_URL}/api/settings`, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
            });
            if (response.ok) {
                const data = await response.json();
                if (data.success && data.data) {
                    setSocialLoginEnabled({
                        google: data.data.google_login_status === 1,
                        facebook: data.data.facebook_login_status === 1
                    });
                } else {
                    setSocialLoginEnabled({ google: true, facebook: true });
                }
            } else {
                const errorText = await response.text();
                setSocialLoginEnabled({ google: true, facebook: true });
            }
        } catch (error) {
            setSocialLoginEnabled({ google: true, facebook: true });
        }
    };

    useEffect(() => {
        if (user) {
            // Redirect vendors to vendor dashboard
            if (user.role === 'vendor') {
                navigate('/vendor/dashboard');
            } else {
                navigate('/user/dashboard');
            }
        }
        ensureFontAwesomeLoaded();
        checkSocialLoginStatus();
    }, [user, navigate]);

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setFormData(prev => ({
            ...prev,
            [name]: value
        }));
        // Clear error for this field
        if (errors[name]) {
            setErrors(prev => ({
                ...prev,
                [name]: ''
            }));
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setMessage('');
        setErrors({});

        try {
            const response = await fetch(`${API_BASE_URL}/api/vendor/login`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
                },
                body: JSON.stringify(formData)
            });

            const data = await response.json();

            if (response.ok && data.success) {
                setMessage(data.message);
                // Store vendor ID and user data instead of JWT token
                localStorage.setItem('vendor_id', data.user.id);
                localStorage.setItem('user', JSON.stringify(data.user));
                
                // Close the login modal
                setShowVendorLogin(false);
                
                // Set a flag to indicate successful login
                localStorage.setItem('vendor_login_success', 'true');
                
                // Redirect to vendor dashboard after a short delay
                setTimeout(() => {
                    window.location.href = `/vendor/dashboard?vendor_id=${data.user.id}`;
                }, 500);
            } else {
                setMessage(data.message || 'Login failed');
                if (data.errors) {
                    setErrors(data.errors);
                }
            }
        } catch (error) {
            console.error('Login error:', error);
            setMessage('Network error. Please try again.');
        } finally {
            setLoading(false);
        }
    };

    const handleGoogleLogin = async () => {
        setSocialLoading(prev => ({ ...prev, google: true }));
        try {
            const response = await fetch(`${API_BASE_URL}/api/auth/google/url`);
            if (response.ok) {
                const data = await response.json();
                if (data.success && data.url) {
                    window.location.href = data.url;
                }
            }
        } catch (error) {
            console.error('Google login error:', error);
        } finally {
            setSocialLoading(prev => ({ ...prev, google: false }));
        }
    };

    const handleFacebookLogin = async () => {
        setSocialLoading(prev => ({ ...prev, facebook: true }));
        try {
            const response = await fetch(`${API_BASE_URL}/api/auth/facebook/url`);
            if (response.ok) {
                const data = await response.json();
                if (data.success && data.url) {
                    window.location.href = data.url;
                }
            }
        } catch (error) {
            console.error('Facebook login error:', error);
        } finally {
            setSocialLoading(prev => ({ ...prev, facebook: false }));
        }
    };

    return (
        <div className="bg-white rounded-lg shadow-xl max-w-md w-full mx-4">
            <div className="px-6 py-6">
                <div className="flex justify-between items-center mb-6">
                    <h2 className="text-2xl font-bold text-gray-900">Vendor Login</h2>
                    <button
                        onClick={() => setShowVendorLogin(false)}
                        className="text-gray-400 hover:text-gray-600 transition-colors p-1"
                    >
                        <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>

                {message && (
                    <div className={`mb-4 p-3 rounded-md text-sm ${
                        message.includes('successful') 
                            ? 'bg-green-100 text-green-700 border border-green-300' 
                            : 'bg-red-100 text-red-700 border border-red-300'
                    }`}>
                        {message}
                    </div>
                )}

                <form onSubmit={handleSubmit} className="space-y-4">
                    <div>
                        <label htmlFor="username" className="block text-sm font-medium text-gray-700 mb-1">
                            Username or Email <span className="text-red-500">*</span>
                        </label>
                        <input
                            type="text"
                            id="username"
                            name="username"
                            value={formData.username}
                            onChange={handleInputChange}
                            className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500 transition-colors ${
                                errors.username ? 'border-red-500 bg-red-50' : 'border-gray-300 hover:border-gray-400'
                            }`}
                            placeholder="Enter your username or email"
                        />
                        {errors.username && (
                            <p className="mt-1 text-sm text-red-600">{errors.username}</p>
                        )}
                    </div>

                    <div>
                        <label htmlFor="password" className="block text-sm font-medium text-gray-700 mb-1">
                            Password <span className="text-red-500">*</span>
                        </label>
                        <input
                            type="password"
                            id="password"
                            name="password"
                            value={formData.password}
                            onChange={handleInputChange}
                            className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500 transition-colors ${
                                errors.password ? 'border-red-500 bg-red-50' : 'border-gray-300 hover:border-gray-400'
                            }`}
                            placeholder="Enter your password"
                        />
                        {errors.password && (
                            <p className="mt-1 text-sm text-red-600">{errors.password}</p>
                        )}
                    </div>

                    <div className="pt-2">
                        <button
                            type="submit"
                            disabled={loading}
                            className={`w-full py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white transition-all duration-200 ${
                                loading 
                                    ? 'bg-indigo-400 cursor-not-allowed' 
                                    : 'bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 transform hover:scale-[1.02]'
                            }`}
                        >
                            {loading ? (
                                <div className="flex items-center justify-center">
                                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                                    Logging in...
                                </div>
                            ) : (
                                'Login as Vendor'
                            )}
                        </button>
                    </div>
                </form>

                {/* Social Login Buttons */}
                {(socialLoginEnabled.google || socialLoginEnabled.facebook) && (
                    <div className="mt-6">
                        <div className="relative">
                            <div className="absolute inset-0 flex items-center">
                                <div className="w-full border-t border-gray-300" />
                            </div>
                            <div className="relative flex justify-center text-sm">
                                <span className="px-2 bg-white text-gray-500">Or continue with</span>
                            </div>
                        </div>

                        <div className="mt-6 grid grid-cols-2 gap-3">
                            {socialLoginEnabled.google && (
                                <button
                                    onClick={handleGoogleLogin}
                                    disabled={socialLoading.google}
                                    className="w-full inline-flex justify-center py-2 px-4 border border-gray-300 rounded-md shadow-sm bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 transition-colors"
                                >
                                    {socialLoading.google ? (
                                        <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-gray-900"></div>
                                    ) : (
                                        <>
                                            {fontAwesomeLoaded && <i className="fab fa-google text-red-600 mr-2"></i>}
                                            Google
                                        </>
                                    )}
                                </button>
                            )}

                            {socialLoginEnabled.facebook && (
                                <button
                                    onClick={handleFacebookLogin}
                                    disabled={socialLoading.facebook}
                                    className="w-full inline-flex justify-center py-2 px-4 border border-gray-300 rounded-md shadow-sm bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 transition-colors"
                                >
                                    {socialLoading.facebook ? (
                                        <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-gray-900"></div>
                                    ) : (
                                        <>
                                            {fontAwesomeLoaded && <i className="fab fa-facebook text-blue-600 mr-2"></i>}
                                            Facebook
                                        </>
                                    )}
                                </button>
                            )}
                        </div>
                    </div>
                )}

                <div className="mt-6 text-center border-t border-gray-200 pt-4">
                    <p className="text-sm text-gray-600">
                        Don't have a vendor account?{' '}
                        <button
                            onClick={() => setShowVendorSignUp(true)}
                            className="font-medium text-indigo-600 hover:text-indigo-500 transition-colors"
                        >
                            Sign up here
                        </button>
                    </p>
                </div>
            </div>
        </div>
    );
};
