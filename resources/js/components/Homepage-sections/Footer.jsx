import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useLanguage } from '../../contexts/LanguageContext';

export const Footer = () => {
  const navigate = useNavigate();
  const { currentLanguage } = useLanguage();
  const [categories, setCategories] = useState([]);
  const [countries, setCountries] = useState([]);
  const [socialMedia, setSocialMedia] = useState([]);
  const [loading, setLoading] = useState(true);
  const [fontAwesomeLoaded, setFontAwesomeLoaded] = useState(false);

  const API_BASE_URL =
    window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
      ? import.meta.env.VITE_API_BASE_URL_LOCAL
      : import.meta.env.VITE_API_BASE_URL;

  const checkFontAwesomeLoaded = () => {
    try {
      return document.querySelector('.fa') !== null || 
             document.querySelector('.fas') !== null || 
             document.querySelector('.fab') !== null ||
             document.querySelector('.far') !== null ||
             document.querySelector('.fal') !== null;
    } catch (e) {
      return false;
    }
  };

  const ensureFontAwesomeLoaded = () => {
    if (checkFontAwesomeLoaded()) {
      setFontAwesomeLoaded(true);
      return;
    }

    const link = document.createElement('link');
    link.rel = 'stylesheet';
    link.type = 'text/css';
    link.href = '/assets/front/fonts/fontawesome/css/all.min.css';
    document.head.appendChild(link);
    
    link.onload = () => setFontAwesomeLoaded(true);
    link.onerror = () => {
      console.warn('Failed to load FontAwesome CSS');
      setFontAwesomeLoaded(true); // Set to true anyway to avoid infinite loading
    };
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const routesResponse = await fetch(`${API_BASE_URL}/api/routes`);
        const routes = await routesResponse.json();

        // Fetch categories, countries, and social media in parallel
        const [categoriesResponse, countriesResponse, socialMediaResponse] = await Promise.all([
          fetch(routes.hotelsCategories),
          fetch(routes.countries),
          fetch(routes.socialMedia)
        ]);

        const categoriesData = await categoriesResponse.json();
        const countriesData = await countriesResponse.json();
        const socialMediaData = await socialMediaResponse.json();

        // Filter data based on current language ID
        if (currentLanguage && currentLanguage.id) {
          // Filter categories by language
          const filteredCategories = categoriesData.filter(
            category => parseInt(category.language_id) === parseInt(currentLanguage.id)
          );
          setCategories(filteredCategories);

          // Filter countries by language
          const filteredCountries = countriesData.filter(
            country => parseInt(country.language_id) === parseInt(currentLanguage.id)
          );
          setCountries(filteredCountries);

          // Social media doesn't need language filtering
          setSocialMedia(socialMediaData);
        } else {
          // Fallback to all data if no language context
          setCategories(categoriesData);
          setCountries(countriesData);
          setSocialMedia(socialMediaData);
        }
      } catch (err) {
        console.error('Error loading data:', err);
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, [currentLanguage]);

  useEffect(() => {
    ensureFontAwesomeLoaded();
  }, []);

  useEffect(() => {
    if (window.AOS) {
      window.AOS.refresh();
    }
  }, []);

  const handleCategoryClick = (category) => {
    navigate(`/search?category=${encodeURIComponent(category)}`);
  };

  const handleCountryClick = (country) => {
    navigate(`/search?country=${encodeURIComponent(country)}`);
  };

  const renderIcon = (iconClass) => {
    if (!iconClass) return null;
    
    // Check if it's a FontAwesome icon
    if (iconClass.startsWith('fa') || iconClass.startsWith('fab') || iconClass.startsWith('fas') || iconClass.startsWith('far') || iconClass.startsWith('fal')) {
      return <i className={iconClass}></i>;
    }
    
    // Check if it's an emoji
    if (iconClass.length <= 2) {
      return <span>{iconClass}</span>;
    }
    
    // Check if it's SVG code
    if (iconClass.includes('<svg') || iconClass.includes('<path')) {
      return <span dangerouslySetInnerHTML={{ __html: iconClass }} />;
    }
    
    // Fallback to text
    return <span className="text-xs">{iconClass.substring(0, 2)}</span>;
  };

  return (
    <footer 
      data-aos="fade-up" 
      data-aos-duration="1000"
      data-aos-delay="200"
      data-aos-once="false"
      data-aos-anchor-placement="top-bottom"
      className="bg-[#F0F0F0] mt-[60px] md:mt-[100px]"
    >
      <div className="max-w-7xl mx-auto px-4 md:px-6 py-8 md:py-12 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6 md:gap-8">
        <div className="text-center sm:text-left">
          <h4 className="font-semibold mb-3 md:mb-4 text-sm md:text-base">Company</h4>
          <ul className="space-y-1 md:space-y-2 text-gray-600 text-sm md:text-base">
            <li>About</li>
            <li>Blog</li>
            <li>Guides</li>
            <li>Careers</li>
          </ul>
        </div>

        <div className="text-center sm:text-left">
          <h4 className="font-semibold mb-3 md:mb-4 text-sm md:text-base">All Activities</h4>
          <ul className="space-y-1 md:space-y-2 text-gray-600 text-sm md:text-base">
            {loading ? (
              <li>Loading...</li>
            ) : (
              categories.map((category, index) => (
                <li 
                  key={index}
                  className="cursor-pointer hover:text-gray-800 transition-colors"
                  onClick={() => handleCategoryClick(category.name || category)}
                >
                  {category.name || category}
                </li>
              ))
            )}
          </ul>
        </div>

        <div className="text-center sm:text-left">
          <h4 className="font-semibold mb-3 md:mb-4 text-sm md:text-base">Countries</h4>
          <ul className="space-y-1 md:space-y-2 text-gray-600 text-sm md:text-base">
            {loading ? (
              <li>Loading...</li>
            ) : (
              countries.map((country, index) => (
                <li 
                  key={index}
                  className="cursor-pointer hover:text-gray-800 transition-colors"
                  onClick={() => handleCountryClick(country.name || country)}
                >
                  {country.name || country}
                </li>
              ))
            )}
          </ul>
        </div>

        <div className="text-center sm:text-left">
          <h4 className="font-semibold mb-3 md:mb-4 text-sm md:text-base">Support</h4>
          <ul className="space-y-1 md:space-y-2 text-gray-600 text-sm md:text-base">
            <li>List Your Space</li>
            <li>FAQ</li>
            <li>Help Center</li>
            <li>Trust & Safety</li>
          </ul>

          <div className="mt-4 md:mt-6">
            <h4 className="font-semibold mb-2 md:mb-3 text-sm md:text-base">Follow us</h4>
            <div className="flex justify-center sm:justify-start space-x-3 md:space-x-4 text-base md:text-lg text-white">
              {loading ? (
                <div className="text-gray-500">Loading...</div>
              ) : !fontAwesomeLoaded ? (
                <div className="text-gray-500">Loading icons...</div>
              ) : (
                socialMedia.map((media, index) => (
                  <a 
                    key={index}
                    href={media.url} 
                    target="_blank" 
                    rel="noopener noreferrer"
                    className=" p-2  text-black transition-colors"
                    title={media.icon}
                  >
                    {renderIcon(media.icon)}
                  </a>
                ))
              )}
            </div>
          </div>
        </div>

      </div>

      <div className="bg-[#d9d9d9] py-3 md:py-4">
        <div className="max-w-7xl mx-auto px-4 md:px-6 flex flex-col md:flex-row justify-between items-center text-gray-600 text-xs md:text-sm">
          <p>©2025 by peerspace</p>
          <div className="flex space-x-4 md:space-x-6 mt-2 md:mt-0">
            <a href="#" className="hover:text-gray-800 transition-colors">Terms</a>
            <a href="#" className="hover:text-gray-800 transition-colors">Privacy Policy</a>
          </div>
        </div>
      </div>
    </footer>
  );
};
