import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { useAuth } from './AuthContext';

export const Signup = ({ setShowSignUp, setShowLogin, onAuthSuccess }) => {
    const location = useLocation();
    const navigate = useNavigate();
    const { user } = useAuth();

    const [formData, setFormData] = useState({
        name: '',
        email: '',
        username: '',
        password: '',
        password_confirmation: '',
        phone: ''
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
            navigate('/user/dashboard');
        }
        ensureFontAwesomeLoaded();
        checkSocialLoginStatus();
        
        const urlParams = new URLSearchParams(window.location.search);
        const code = urlParams.get('code');
        const state = urlParams.get('state');
        const error = urlParams.get('error');
        
        if (code && !error) {
            handleOAuthCallback(code, state);
        } else if (error) {
            setMessage(`OAuth error: ${error}`);
            window.history.replaceState({}, document.title, window.location.pathname);
        }
    }, [user, navigate]);

    const handleOAuthCallback = async (code, state) => {
        setLoading(true);
        setMessage('Completing social signup...');
        
        try {
            const isGoogle = window.location.pathname.includes('google') || state?.includes('google');
            const isFacebook = window.location.pathname.includes('facebook') || state?.includes('facebook');
            
            let endpoint = '';
            if (isGoogle) {
                endpoint = `${API_BASE_URL}/api/auth/google/callback`;
            } else if (isFacebook) {
                endpoint = `${API_BASE_URL}/api/auth/facebook/callback`;
            } else {
                if (window.location.pathname.includes('google')) {
                    endpoint = `${API_BASE_URL}/api/auth/google/callback`;
                } else if (window.location.pathname.includes('facebook')) {
                    endpoint = `${API_BASE_URL}/api/auth/facebook/callback`;
                } else {
                    throw new Error('Unable to determine OAuth provider');
                }
            }
            
            const response = await fetch(endpoint, {
                method: 'POST',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ code, state }),
            });
            
            const data = await response.json();
            
            if (response.ok && data.success) {
                localStorage.setItem('jwt_token', data.token);
                if (window.authContext && window.authContext.setUser) {
                    window.authContext.setUser(data.user);
                    window.authContext.setToken(data.token);
                }
                
                setMessage('Social signup successful! Redirecting...');
                window.history.replaceState({}, document.title, window.location.pathname);
                setTimeout(() => {
                    navigate('/user/dashboard');
                }, 1000);
            } else {
                setMessage(data.message || 'Social signup failed');
                window.history.replaceState({}, document.title, window.location.pathname);
            }
        } catch (error) {
            console.error('OAuth callback error:', error);
            setMessage('An error occurred during social signup');
            window.history.replaceState({}, document.title, window.location.pathname);
        } finally {
            setLoading(false);
        }
    };

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setFormData(prev => ({
            ...prev,
            [name]: value
        }));
        if (errors[name]) {
            setErrors(prev => ({
                ...prev,
                [name]: ''
            }));
        }
    };

    const validateForm = () => {
        const newErrors = {};
        if (!formData.name.trim()) {
            newErrors.name = 'Full name is required';
        }
        if (!formData.email.trim()) {
            newErrors.email = 'Email is required';
        } else if (!/\S+@\S+\.\S+/.test(formData.email)) {
            newErrors.email = 'Email is invalid';
        }
        if (!formData.username.trim()) {
            newErrors.username = 'Username is required';
        }
        if (!formData.password) {
            newErrors.password = 'Password is required';
        } else if (formData.password.length < 6) {
            newErrors.password = 'Password must be at least 6 characters';
        }
        if (formData.password !== formData.password_confirmation) {
            newErrors.password_confirmation = 'Passwords do not match';
        }
        if (!formData.phone.trim()) {
            newErrors.phone = 'Phone number is required';
        }
        setErrors(newErrors);
        return Object.keys(newErrors).length === 0;
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!validateForm()) return;

        setLoading(true);
        setErrors({});
        setMessage('');

        try {
            const response = await fetch(`${API_BASE_URL}/api/auth/register`, {
                method: 'POST',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData),
            });

            const data = await response.json();

            if (response.ok && data.success) {
                setMessage('Registration successful! Please log in.');
                // Call onAuthSuccess if provided (though user needs to login separately)
                if (onAuthSuccess && data.token && data.user) {
                    onAuthSuccess(data.token, data.user);
                }
                setTimeout(() => {
                    setShowSignUp(false);
                }, 2000);
            } else {
                setMessage(data.message || 'Registration failed');
            }
        } catch (error) {
            setMessage('An error occurred during registration');
        } finally {
            setLoading(false);
        }
    };

    const handleGoogleSignup = async () => {
        setSocialLoading(prev => ({ ...prev, google: true }));
        setMessage('');
        
        try {
            const response = await fetch(`${API_BASE_URL}/api/auth/google/url`, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
            });

            const data = await response.json();

            if (response.ok && data.success) {
                // Redirect to Google OAuth
                window.location.href = data.url;
            } else {
                setMessage(data.message || 'Failed to get Google signup URL');
            }
        } catch (error) {
            console.error('Google signup error:', error);
            setMessage('An error occurred during Google signup');
        } finally {
            setSocialLoading(prev => ({ ...prev, google: false }));
        }
    };

    const handleFacebookSignup = async () => {
        setSocialLoading(prev => ({ ...prev, facebook: true }));
        setMessage('');
        
        try {
            // Get Facebook signup URL from backend
            const response = await fetch(`${API_BASE_URL}/api/auth/facebook/url`, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
            });

            const data = await response.json();

            if (response.ok && data.success) {
                // Redirect to Facebook OAuth
                window.location.href = data.url;
            } else {
                setMessage(data.message || 'Failed to get Facebook signup URL');
            }
        } catch (error) {
            console.error('Facebook signup error:', error);
            setMessage('An error occurred during Facebook signup');
        } finally {
            setSocialLoading(prev => ({ ...prev, facebook: false }));
        }
    };

    return (
        <div className="flex items-center justify-center min-h-screen p-4">
            <div className="bg-white relative w-[35rem] rounded-lg shadow-xl p-6 md:p-8">
                <span className='right-3 absolute top-3 cursor-pointer' onClick={() => setShowSignUp(false)}>
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth="1.5" stroke="currentColor" className="size-6">
                        <path strokeLinecap="round" strokeLinejoin="round" d="M6 18 18 6M6 6l12 12" />
                    </svg>
                </span>
                <h2 className="text-center text-xl md:text-2xl font-bold text-gray-900">Create Account</h2>
                <p className="text-center text-sm text-gray-500 mb-6">Join us today</p>

                <div className="space-y-3">
                    {socialLoginEnabled.google && (
                        <button 
                            onClick={handleGoogleSignup}
                            disabled={socialLoading.google}
                            className="relative w-full flex items-center justify-center border border-gray-300 rounded-md py-3 px-4 hover:bg-gray-50 hover:border-gray-400 disabled:opacity-50 disabled:cursor-not-allowed transition-all duration-200 font-medium text-gray-700"
                        >
                            {socialLoading.google ? (
                                <div className="flex items-center">
                                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-gray-600 mr-2"></div>
                                    Connecting to Google...
                                </div>
                            ) : (
                                <>
                                    <i className="fab fa-google absolute left-4 text-red-500 text-lg"></i>
                                    Continue with Google
                                </>
                            )}
                        </button>
                    )}
                    
                    {socialLoginEnabled.facebook && (
                        <button 
                            onClick={handleFacebookSignup}
                            disabled={socialLoading.facebook}
                            className="relative w-full flex items-center justify-center border border-gray-300 rounded-md py-3 px-4 hover:bg-gray-50 hover:border-gray-400 disabled:opacity-50 disabled:cursor-not-allowed transition-all duration-200 font-medium text-gray-700"
                        >
                            {socialLoading.facebook ? (
                                <div className="flex items-center">
                                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-gray-600 mr-2"></div>
                                    Connecting to Facebook...
                                </div>
                            ) : (
                                <>
                                    <i className="fab fa-facebook absolute left-4 text-blue-600 text-lg"></i>
                                    Continue with Facebook
                                </>
                            )}
                        </button>
                    )}

                    {!socialLoginEnabled.google && !socialLoginEnabled.facebook && (
                        <div className="text-center text-sm text-gray-500 py-2">
                            Social signup is currently disabled
                        </div>
                    )}
                </div>

                {(socialLoginEnabled.google || socialLoginEnabled.facebook) && (
                    <div className="flex items-center my-6">
                        <hr className="flex-grow border-gray-300" />
                        <span className="px-2 text-gray-400 text-sm">or</span>
                        <hr className="flex-grow border-gray-300" />
                    </div>
                )}

                <form className="space-y-4" onSubmit={handleSubmit}>
                    <input
                        id="name"
                        name="name"
                        type="text"
                        autoComplete="name"
                        required
                        value={formData.name}
                        onChange={handleInputChange}
                        placeholder="Full Name"
                        className={`block w-full rounded-md border py-2 px-3 text-gray-900 shadow-sm ${errors.name
                            ? 'border-red-300 focus:border-red-500'
                            : 'border-gray-300 focus:border-indigo-500'
                            } focus:ring-1 focus:ring-indigo-500 sm:text-sm`}
                    />
                    {errors.name && (
                        <p className="text-sm text-red-600">{errors.name}</p>
                    )}

                    <input
                        id="email"
                        name="email"
                        type="email"
                        autoComplete="email"
                        required
                        value={formData.email}
                        onChange={handleInputChange}
                        placeholder="Email Address"
                        className={`block w-full rounded-md border py-2 px-3 text-gray-900 shadow-sm ${errors.email
                            ? 'border-red-300 focus:border-red-500'
                            : 'border-gray-300 focus:border-indigo-500'
                            } focus:ring-1 focus:ring-indigo-500 sm:text-sm`}
                    />
                    {errors.email && (
                        <p className="text-sm text-red-600">{errors.email}</p>
                    )}

                    <input
                        id="username"
                        name="username"
                        type="text"
                        autoComplete="username"
                        required
                        value={formData.username}
                        onChange={handleInputChange}
                        placeholder="Username"
                        className={`block w-full rounded-md border py-2 px-3 text-gray-900 shadow-sm ${errors.username
                            ? 'border-red-300 focus:border-red-500'
                            : 'border-gray-300 focus:border-indigo-500'
                            } focus:ring-1 focus:ring-indigo-500 sm:text-sm`}
                    />
                    {errors.username && (
                        <p className="text-sm text-red-600">{errors.username}</p>
                    )}

                    <input
                        id="phone"
                        name="phone"
                        type="tel"
                        autoComplete="tel"
                        required
                        value={formData.phone}
                        onChange={handleInputChange}
                        placeholder="Phone Number"
                        className={`block w-full rounded-md border py-2 px-3 text-gray-900 shadow-sm ${errors.phone
                            ? 'border-red-300 focus:border-red-500'
                            : 'border-gray-300 focus:border-indigo-500'
                            } focus:ring-1 focus:ring-indigo-500 sm:text-sm`}
                    />
                    {errors.phone && (
                        <p className="text-sm text-red-600">{errors.phone}</p>
                    )}

                    <input
                        id="password"
                        name="password"
                        type="password"
                        autoComplete="new-password"
                        required
                        value={formData.password}
                        onChange={handleInputChange}
                        placeholder="Password"
                        className={`block w-full rounded-md border py-2 px-3 text-gray-900 shadow-sm ${errors.password
                            ? 'border-red-300 focus:border-red-500'
                            : 'border-gray-300 focus:border-indigo-500'
                            } focus:ring-1 focus:ring-indigo-500 sm:text-sm`}
                    />
                    {errors.password && (
                        <p className="text-sm text-red-600">{errors.password}</p>
                    )}

                    <input
                        id="password_confirmation"
                        name="password_confirmation"
                        type="password"
                        autoComplete="new-password"
                        required
                        value={formData.password_confirmation}
                        onChange={handleInputChange}
                        placeholder="Confirm Password"
                        className={`block w-full rounded-md border py-2 px-3 text-gray-900 shadow-sm ${errors.password_confirmation
                            ? 'border-red-300 focus:border-red-500'
                            : 'border-gray-300 focus:border-indigo-500'
                            } focus:ring-1 focus:ring-indigo-500 sm:text-sm`}
                    />
                    {errors.password_confirmation && (
                        <p className="text-sm text-red-600">{errors.password_confirmation}</p>
                    )}

                    {message && (
                        <div
                            className={`p-3 rounded-md text-sm ${message.includes('successful')
                                ? 'bg-green-50 text-green-700 border border-green-200'
                                : 'bg-red-50 text-red-700 border border-red-200'
                                }`}
                        >
                            {message}
                        </div>
                    )}

                    <button
                        type="submit"
                        disabled={loading}
                        className="w-full rounded-md bg-purple-500 py-2 text-white font-semibold hover:bg-purple-600 focus:outline-none disabled:opacity-50"
                    >
                        {loading ? 'Creating Account...' : 'Sign Up'}
                    </button>
                </form>

                <p className="mt-4 text-center text-sm text-gray-500">
                    Already have an account?{' '}
                    <button 
                        onClick={() => {
                            setShowSignUp(false);
                            setShowLogin(true);
                        }}
                        
                        className="text-purple-500 hover:underline"
                    >
                        Log In
                    </button>
                </p>
            </div>
        </div>
    );
};
