import React, { useState, useEffect } from 'react';
import { Link } from "react-router-dom";
import { useTranslation } from 'react-i18next';
import { useAuth } from '../AuthContext';
import { useLanguage } from '../../contexts/LanguageContext';
import { Login } from '../Login';
import { Signup } from '../Signup';
import { VendorLogin } from '../VendorLogin';
import { VendorSignup } from '../VendorSignup';

export const Header = ({ bgColor }) => {
  const { t } = useTranslation();
  const { currentLanguage, languages, changeLanguage, isRTL, direction } = useLanguage();
  const [isScrolled, setIsScrolled] = useState(false);
  const [generalSettings, setGeneralSettings] = useState(null);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [showLoginDropdown, setShowLoginDropdown] = useState(false);
  const [showSignupDropdown, setShowSignupDropdown] = useState(false);
  const [showLanguageDropdown, setShowLanguageDropdown] = useState(false);
  const { user, logout } = useAuth();
  const [showLoginModal, setShowLogin] = useState(false);
  const [showSignUpModal, setShowSignUp] = useState(false);
  const [showVendorLoginModal, setShowVendorLogin] = useState(false);
  const [showVendorSignUpModal, setShowVendorSignUp] = useState(false);
  const API_BASE_URL =
    window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
      ? import.meta.env.VITE_API_BASE_URL_LOCAL
      : import.meta.env.VITE_API_BASE_URL;

  const fetchBasicImages = async () => {
    try {
      const response = await fetch(`${API_BASE_URL}/api/basic-images`);
      const data = await response.json();
      if (data && data.logo) {
        setGeneralSettings(data);
      }
    } catch (error) {
      console.error('Error fetching basic images:', error);
    }
  };

  useEffect(() => {
    fetchBasicImages();
    const handleScroll = () => {
      if (window.scrollY > 0) {
        setIsScrolled(true);
      } else {
        setIsScrolled(false);
      }
    };

    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);
  
  // Check for vendor authentication from URL parameters (from email verification)
  useEffect(() => {
    const urlParams = new URLSearchParams(window.location.search);
    const vendorId = urlParams.get('vendor_id');
    const verified = urlParams.get('verified');
    
    if (vendorId && verified === '1') {
      // Vendor just verified email, automatically authenticate them
      // This will be handled by the AuthContext, but we can also handle it here if needed
      console.log('Vendor verification detected in Header:', vendorId);
    }
  }, []);

  const toggleMobileMenu = () => {
    setIsMobileMenuOpen(!isMobileMenuOpen);
  };

  const closeMobileMenu = () => {
    setIsMobileMenuOpen(false);
  };

  const handleLogout = async () => {
    await logout();
  };

  const handleLanguageChange = async (language) => {
    setShowLanguageDropdown(false);
    const success = await changeLanguage(language);
    if (!success) {
      alert(t('error_occurred') + '. ' + t('please_refresh'));
    }
  };

  const getBackgroundClass = () => {
    if (bgColor) {
      return bgColor;
    }
    return isScrolled ? 'bg-black top-0' : 'bg-transparent top-5';
  };

  return (
    <>
      <header
        className={`fixed left-0 right-0 z-50 transition-colors duration-300 ${getBackgroundClass()}`}
        dir={direction}
      >
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center py-4">
            <div className="flex items-center">
              <Link to={"/"} className="flex items-center space-x-2">
                {generalSettings?.logo ? (
                  <img
                    src={`${window.location.origin}/assets/img/${generalSettings.logo}`}
                    alt="Website Logo"
                    className="h-8 sm:h-10 w-auto"
                  />
                ) : (
                  <h1 className="text-xl sm:text-2xl font-bold text-white">Spacerental</h1>
                )}
              </Link>

            </div>

            <nav className="hidden lg:flex space-x-8">
              <a href="/" className="text-white font-medium hover:text-indigo-300 transition-colors">{t('home')}</a>
              <Link to={"/about-us"} className="text-white font-medium hover:text-indigo-300 transition-colors">{t('about')}</Link>
              <a href="#" className="text-white font-medium hover:text-indigo-300 transition-colors">{t('list_your_service')}</a>
              <Link to={"/search"} className="text-white font-medium hover:text-indigo-300 transition-colors">{t('browse_spaces')}</Link>
            </nav>

            <div className="hidden lg:flex items-center space-x-4">
              <div className="relative">
                <button
                  onClick={() => setShowLanguageDropdown(!showLanguageDropdown)}
                  onBlur={() => setTimeout(() => setShowLanguageDropdown(false), 200)}
                  className="text-white hover:text-indigo-300 transition-colors font-medium flex items-center"
                >
                  <svg className="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 5h12M9 3v2m1.048 9.5A18.022 18.022 0 016.412 9m6.088 9h7M11 21l5-10 5 10M12.751 5C11.783 10.77 8.07 15.61 3 18.129" />
                  </svg>
                  {currentLanguage ? currentLanguage.name : (languages.length > 0 ? t('language') : t('loading'))}
                  <svg className="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                  </svg>
                </button>

                {showLanguageDropdown && (
                  <div className="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-50">
                    {languages.map((language) => (
                      <button
                        key={language.id}
                        onClick={() => handleLanguageChange(language)}
                        className={`block w-full text-left px-4 py-2 text-sm hover:bg-gray-100 ${currentLanguage?.id === language.id ? 'bg-indigo-50 text-indigo-700 font-medium' : 'text-gray-700'
                          }`}
                      >
                        {language.name}
                        {language.is_default === 1 && (
                          <span className="ml-2 text-xs text-gray-500">{t('default')}</span>
                        )}
                      </button>
                    ))}
                  </div>
                )}
              </div>

              {user ? (
                <>

                  {user.role === 'vendor' ? (
                    <a
                      href={`/vendor/dashboard?vendor_id=${localStorage.getItem('vendor_id')}`}
                      className="text-white hover:text-indigo-300 transition-colors font-medium cursor-pointer"
                    >
                      {t('vendor_dashboard')}
                    </a>
                  ) : (
                    <Link to="/user/dashboard" className="text-white hover:text-indigo-300 transition-colors font-medium">
                      {t('dashboard')}
                    </Link>
                  )}
                  <button
                    onClick={handleLogout}
                    className="bg-white text-black border px-4 py-2 rounded-lg hover:text-white hover:bg-indigo-600 transition-colors"
                  >
                    {t('logout')}
                  </button>
                </>
              ) : (
                <>
                  <div className="relative">
                    <button
                      onClick={() => setShowLoginDropdown(!showLoginDropdown)}
                      onBlur={() => setTimeout(() => setShowLoginDropdown(false), 200)}
                      className="text-white hover:text-indigo-300 transition-colors font-medium flex items-center"
                    >
                      {t('login')}
                      <svg className="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                      </svg>
                    </button>

                    {showLoginDropdown && (
                      <div className="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-50">
                        <button
                          onClick={() => {
                            setShowLogin(true);
                            setShowLoginDropdown(false);
                          }}
                          className="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                        >
                          {t('user_login')}
                        </button>
                        <button
                          onClick={() => {
                            setShowVendorLogin(true);
                            setShowLoginDropdown(false);
                          }}
                          className="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                        >
                          {t('vendor_login')}
                        </button>
                      </div>
                    )}
                  </div>

                  <div className="relative">
                    <button
                      onClick={() => setShowSignupDropdown(!showSignupDropdown)}
                      onBlur={() => setTimeout(() => setShowSignupDropdown(false), 200)}
                      className="bg-white text-black border px-4 py-2 rounded-lg hover:text-white hover:bg-indigo-600 transition-colors flex items-center"
                    >
                      {t('signup')}
                      <svg className="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                      </svg>
                    </button>

                    {showSignupDropdown && (
                      <div className="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-50">
                        <button
                          onClick={() => {
                            setShowSignUp(true);
                            setShowSignupDropdown(false);
                          }}
                          className="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                        >
                          {t('user_signup')}
                        </button>
                        <button
                          onClick={() => {
                            setShowVendorSignUp(true);
                            setShowSignupDropdown(false);
                          }}
                          className="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                        >
                          {t('vendor_signup')}
                        </button>
                      </div>
                    )}
                  </div>
                </>
              )}
            </div>
            {showLoginModal && (
              <div className="fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-50 p-4">
                <Login
                  setShowLogin={setShowLogin}
                  setShowSignUp={(show) => {
                    if (show) {
                      setShowSignUp(true);
                      setShowLogin(false);
                    }
                  }}
                />
              </div>
            )}
            {showSignUpModal && (
              <div className="fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-50 p-4">
                <Signup
                  setShowSignUp={setShowSignUp}
                  setShowLogin={(show) => {
                    if (show) {
                      setShowLogin(true);
                      setShowSignUp(false);
                    }
                  }}
                />
              </div>
            )}

            {showVendorLoginModal && (
              <div className="fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-50 p-4">
                <VendorLogin
                  setShowVendorLogin={setShowVendorLogin}
                  setShowVendorSignUp={(show) => {
                    if (show) {
                      setShowVendorSignUp(true);
                      setShowVendorLogin(false);
                    }
                  }}
                />
              </div>
            )}

            {showVendorSignUpModal && (
              <div className="fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-50 p-4">
                <VendorSignup
                  setShowVendorSignUp={setShowVendorSignUp}
                  setShowVendorLogin={(show) => {
                    if (show) {
                      setShowVendorLogin(true);
                      setShowVendorSignUp(false);
                    }
                  }}
                />
              </div>
            )}
            <button
              onClick={toggleMobileMenu}
              className="lg:hidden text-white p-2 focus:outline-none"
              aria-label="Toggle mobile menu"
            >
              <svg
                className="w-6 h-6"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                {isMobileMenuOpen ? (
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M6 18L18 6M6 6l12 12"
                  />
                ) : (
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M4 6h16M4 12h16M4 18h16"
                  />
                )}
              </svg>
            </button>
          </div>
        </div>

        <div className={`lg:hidden transition-all duration-300 ease-in-out ${isMobileMenuOpen
            ? 'max-h-screen opacity-100 visible'
            : 'max-h-0 opacity-0 invisible'
          }`}>
          <div className="bg-black bg-opacity-95 backdrop-blur-sm border-t border-gray-700">
            <nav className="px-4 py-6 space-y-4">
              <a
                href="/"
                className="block text-white font-medium py-3 px-4 rounded-lg hover:bg-white hover:text-black transition-colors"
                onClick={closeMobileMenu}
              >
                {t('home')}
              </a>
              <Link
                to={"/about-us"}
                href="#"
                className="block text-white font-medium py-3 px-4 rounded-lg hover:bg-white hover:text-black transition-colors"
                onClick={closeMobileMenu}
              >
                {t('about')}
              </Link>
              <a
                href="#"
                className="block text-white font-medium py-3 px-4 rounded-lg hover:bg-white hover:text-black transition-colors"
                onClick={closeMobileMenu}
              >
                {t('list_your_service')}
              </a>
              <Link
                to={"/search"}
                href="#"
                className="block text-white font-medium py-3 px-4 rounded-lg hover:bg-white hover:text-black transition-colors"
                onClick={closeMobileMenu}
              >
                {t('browse_spaces')}
              </Link>

              <div className="border-b border-gray-600 pb-2">
                <div className="text-white font-medium py-3 px-4 border-b border-gray-600 pb-2">
                  {t('language')}
                </div>
                {languages.length === 0 ? (
                  <div className="text-white text-sm py-3 px-4 opacity-75">
                    {t('loading')}
                  </div>
                ) : (
                  languages.map((language) => (
                    <button
                      key={language.id}
                      onClick={() => {
                        handleLanguageChange(language);
                        closeMobileMenu();
                      }}
                      className={`block w-full text-left px-4 py-2 text-sm rounded-lg transition-colors ${currentLanguage?.id === language.id
                          ? 'bg-indigo-600 text-white'
                          : 'text-white hover:bg-white hover:text-black'
                        }`}
                    >
                      {language.name}
                      {language.is_default === 1 && (
                        <span className="ml-2 text-xs opacity-75">{t('default')}</span>
                      )}
                    </button>
                  ))
                )}
              </div>

              <div className="pt-4 space-y-3">
                {user ? (
                  <>
                    <div className="text-white font-medium py-3 px-4">
                      {t('welcome')}, {user.role === 'vendor' ? 'Vendor' : 'User'} {user.name || user.username}
                    </div>
                    {user.role === 'vendor' ? (
                      <button
                        onClick={() => {
                          closeMobileMenu();
                          // Get vendor ID from user object
                          const vendorId = user?.id;
                          
                          if (vendorId) {
                            // Navigate to vendor dashboard with vendor_id
                            window.location.href = `/vendor/dashboard?vendor_id=${vendorId}`;
                          } else {
                            // If no vendor ID, redirect to login
                            window.location.href = '/vendor/login';
                          }
                        }}
                        className="block w-full text-center text-white font-medium py-3 px-4 rounded-lg hover:bg-white hover:text-black transition-colors border border-white"
                      >
                        {t('vendor_dashboard')}
                      </button>
                    ) : (
                      <Link
                        to="/user/dashboard"
                        className="block w-full text-center text-white font-medium py-3 px-4 rounded-lg hover:bg-white hover:text-black transition-colors border border-white"
                        onClick={closeMobileMenu}
                      >
                        {t('dashboard')}
                      </Link>
                    )}
                    <button
                      onClick={handleLogout}
                      className="w-full text-center bg-white text-black font-medium py-3 px-4 rounded-lg hover:bg-indigo-600 hover:text-white transition-colors"
                    >
                      {t('logout')}
                    </button>
                  </>
                ) : (
                  <>
                    <div className="text-white font-medium py-3 px-4 border-b border-gray-600 pb-2">
                      User Account
                    </div>
                    <Link
                      to="/user/login"
                      className="block w-full text-center text-white font-medium py-3 px-4 rounded-lg hover:bg-white hover:text-black transition-colors border border-white"
                      onClick={closeMobileMenu}
                    >
                      {t('user_login')}
                    </Link>
                    <Link
                      to="/user/signup"
                      className="block w-full text-center bg-white text-black font-medium py-3 px-4 rounded-lg hover:bg-indigo-600 hover:text-white transition-colors"
                      onClick={closeMobileMenu}
                    >
                      {t('user_signup')}
                    </Link>

                    <div className="text-white font-medium py-3 px-4 border-b border-gray-600 pb-2 pt-4">
                      Vendor Account
                    </div>
                    <Link
                      to="/vendor/login"
                      className="block w-full text-center text-white font-medium py-3 px-4 rounded-lg hover:bg-white hover:text-black transition-colors border border-white"
                      onClick={closeMobileMenu}
                    >
                      {t('vendor_login')}
                    </Link>
                    <Link
                      to="/vendor/signup"
                      className="block w-full text-center bg-white text-black font-medium py-3 px-4 rounded-lg hover:bg-indigo-600 hover:text-white transition-colors"
                      onClick={closeMobileMenu}
                    >
                      {t('vendor_signup')}
                    </Link>
                  </>
                )}
              </div>
            </nav>
          </div>
        </div>
      </header>
    </>
  );
};
