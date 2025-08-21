import React, { useEffect, useState, useCallback } from 'react';
import { useLocation } from 'react-router-dom';
import HeroSection from './Homepage-sections/HeroSection';
import { Header } from './Homepage-sections/Header';
import { Hotels } from './Homepage-sections/Hotels';
import { Partners } from './Homepage-sections/Partners';
import { FeaturedArea } from './Homepage-sections/FeaturedArea';
import { Cities } from './Homepage-sections/Cities';
import { Testimonials } from './Homepage-sections/Testimonials';
import { Blog } from './Homepage-sections/Blog';
import { CallToAction } from './Homepage-sections/callToAction.jsx';
import { Footer } from './Homepage-sections/Footer';
import { useLanguage } from '../contexts/LanguageContext';
import { useAuth } from './AuthContext';

function HomePage() {
    const { currentLanguage } = useLanguage();
    const { handleVendorVerification, checkVendorSession } = useAuth();
    const [contents, setSectionData] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [retryCount, setRetryCount] = useState(0);
    const [isRetrying, setIsRetrying] = useState(false);
    const location = useLocation();
    
    const API_BASE_URL =
        window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
            ? import.meta.env.VITE_API_BASE_URL_LOCAL
            : import.meta.env.VITE_API_BASE_URL;
    const getCachedData = () => {
        try {
            const cached = localStorage.getItem('homepage_sections_data');
            if (cached) {
                const { data, timestamp } = JSON.parse(cached);
                if (Date.now() - timestamp < 5 * 60 * 1000) {
                    return data;
                }
            }
        } catch (e) {
            console.warn('Failed to read cached data:', e);
        }
        return null;
    };
    const cacheData = (data) => {
        try {
            localStorage.setItem('homepage_sections_data', JSON.stringify({
                data,
                timestamp: Date.now()
            }));
        } catch (e) {
            console.warn('Failed to cache data:', e);
        }
    };
    const fetchData = useCallback(async (retryAttempt = 0) => {
        try {
            setIsRetrying(retryAttempt > 0);
            const controller = new AbortController();
            const timeoutId = setTimeout(() => controller.abort(), 10000);
            const response = await fetch(`${API_BASE_URL}/api/sections`, {
                signal: controller.signal,
                headers: {
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache'
                }
            });
            clearTimeout(timeoutId);
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            const data = await response.json();
            if (data && Array.isArray(data) && data.length > 0) {
                let filteredData = data;
                if (currentLanguage && currentLanguage.id) {
                    filteredData = data.filter(section =>
                        section.language_id === currentLanguage.id || section.Language_id === currentLanguage.id
                    );
                } else {
                    console.log('No current language, using all sections');
                }
                setSectionData(filteredData);
                setError(null);
                setRetryCount(0);
                cacheData(filteredData);
                return true;
            } else {
                throw new Error('Invalid data format received');
            }
        } catch (err) {
            console.error(`Fetch attempt ${retryAttempt + 1} failed:`, err);
            if (err.name === 'AbortError') {
                setError('Request timeout. Please check your connection.');
            } else if (err.message.includes('HTTP error! status: 429')) {
                setError('Too many requests. Please wait a moment and try again.');
            } else if (err.message.includes('HTTP error! status: 500')) {
                setError('Server error. Please try again later.');
            } else {
                setError('Failed to load content. Please check your connection.');
            }
            return false;
        }
    }, [API_BASE_URL, currentLanguage]);
    const retryWithBackoff = useCallback(async () => {
        if (retryCount >= 3) {
            setError('Unable to load content after multiple attempts. Please refresh the page.');
            return;
        }
        const delay = Math.min(1000 * Math.pow(2, retryCount), 10000); // Max 10 seconds
        setRetryCount(prev => prev + 1);
        setTimeout(async () => {
            const success = await fetchData(retryCount + 1);
            if (!success && retryCount < 2) {
                retryWithBackoff();
            }
        }, delay);
    }, [retryCount, fetchData]);
    useEffect(() => {
        const loadData = async () => {
            setLoading(true);
            setError(null);
            if (currentLanguage) {
                localStorage.removeItem('homepage_sections_data');
            }
            const cachedData = getCachedData();
            if (cachedData && !currentLanguage) {
                setSectionData(cachedData);
                setLoading(false);
                return;
            }
            const success = await fetchData();
            if (!success) {
                retryWithBackoff();
            }
            setLoading(false);
        };
        loadData();
    }, [fetchData, retryWithBackoff, currentLanguage]);
    useEffect(() => {
        const urlParams = new URLSearchParams(location.search);
        const logoutParam = urlParams.get('logout');
        if (logoutParam === 'vendor') {
            localStorage.removeItem('jwt_token');
            localStorage.removeItem('user');
            localStorage.removeItem('vendor_data');
            localStorage.removeItem('vendor_id');
            window.location.href = '/';
        }
    }, [location]);
    
    // Check for vendor authentication from URL parameters (from email verification)
    useEffect(() => {
        const urlParams = new URLSearchParams(location.search);
        const vendorId = urlParams.get('vendor_id');
        const verified = urlParams.get('verified');
        
        if (vendorId && verified === '1' && handleVendorVerification) {
            console.log('Vendor verification detected in HomePage:', vendorId);
            // Vendor just verified email, automatically authenticate them
            handleVendorVerification(vendorId);
        }
    }, [location, handleVendorVerification]);
    
    // Check for vendor authentication from session when component mounts
    useEffect(() => {
        if (checkVendorSession) {
            console.log('Checking vendor session in HomePage');
            checkVendorSession();
        }
    }, [checkVendorSession]);
    const fallbackContent = {
        hero_section_title: "Find Your Perfect Space",
        hero_section_subtitle: "Book amazing venues for your next event",
        featured_room_section_title: "Featured Venues",
        featured_section_title: "Why Choose Us",
        featured_section_text: "Discover unique spaces that make your events unforgettable",
        city_section_title: "Popular Cities",
        city_section_description: "Find amazing venues in cities around the world",
        testimonial_section_title: "What Our Users Say",
        testimonial_section_subtitle: "Real experiences from real people",
        testimonial_section_clients: "Join thousands of satisfied customers",
        blog_section_title: "Latest News & Tips",
        blog_section_button_text: "Read More",
        call_to_action_section_title: "Ready to Get Started?",
        call_to_action_section_btn: "Book Now",
        call_to_action_button_url: "#"
    };
    if (loading) {
        return (
            <div className="min-h-screen flex items-center justify-center bg-gray-50">
                <div className="text-center">
                    <div className="animate-spin rounded-full h-16 w-16 border-b-2 border-blue-600 mx-auto mb-4"></div>
                    <p className="text-gray-600 text-lg">Loading amazing content...</p>
                    {isRetrying && (
                        <p className="text-sm text-gray-500 mt-2">Retrying... (Attempt {retryCount + 1}/3)</p>
                    )}
                </div>
            </div>
        );
    }
    if (error && !contents) {
        return (
            <div className="min-h-screen flex items-center justify-center bg-gray-50 px-4">
                <div className="text-center max-w-md">
                    <div className="text-red-500 text-6xl mb-4">⚠️</div>
                    <h1 className="text-2xl font-bold text-gray-800 mb-4">Oops! Something went wrong</h1>
                    <p className="text-gray-600 mb-6">{error}</p>
                    <div className="space-y-3">
                        <button
                            onClick={() => {
                                setError(null);
                                setRetryCount(0);
                                setLoading(true);
                                fetchData();
                            }}
                            className="w-full bg-blue-600 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors"
                        >
                            Try Again
                        </button>
                        <button
                            onClick={() => window.location.reload()}
                            className="w-full bg-gray-600 text-white px-6 py-3 rounded-lg font-semibold hover:bg-gray-700 transition-colors"
                        >
                            Refresh Page
                        </button>
                    </div>
                </div>
            </div>
        );
    }
    const currentSectionData = contents && contents.length > 0 ? contents[0] : fallbackContent;
    const sectionData = [currentSectionData];
    return (
        <div className="App">
            <Header />
            <HeroSection
                title={sectionData[0]?.hero_section_title || fallbackContent.hero_section_title}
                subtitle={sectionData[0]?.hero_section_subtitle || fallbackContent.hero_section_subtitle}
            />
            <Hotels title={sectionData[0]?.featured_room_section_title || fallbackContent.featured_room_section_title} />
            <Partners />
            <FeaturedArea
                title={sectionData[0]?.featured_section_title || fallbackContent.featured_section_title}
                text={sectionData[0]?.featured_section_text || fallbackContent.featured_section_text}
            />
            <Cities
                title={sectionData[0]?.city_section_title || fallbackContent.city_section_title}
                description={sectionData[0]?.city_section_description || fallbackContent.city_section_description}
            />
            <Testimonials
                title={sectionData[0]?.testimonial_section_title || fallbackContent.testimonial_section_title}
                subtitle={sectionData[0]?.testimonial_section_subtitle || fallbackContent.testimonial_section_subtitle}
                description={sectionData[0]?.testimonial_section_clients || fallbackContent.testimonial_section_clients}
            />
            <Blog
                blog_title={sectionData[0]?.blog_section_title || fallbackContent.blog_section_title}
                buttonText={sectionData[0]?.blog_section_button_text || fallbackContent.blog_section_button_text}
            />
            <CallToAction
                link={sectionData[0]?.call_to_action_button_url || sectionData[0]?.call_to_action_url || fallbackContent.call_to_action_button_url}
                title={sectionData[0]?.call_to_action_section_title || fallbackContent.call_to_action_section_title}
                btn_name={sectionData[0]?.call_to_action_section_btn || fallbackContent.call_to_action_section_btn}
            />
            <Footer />
        </div>
    );
}
export default HomePage;
