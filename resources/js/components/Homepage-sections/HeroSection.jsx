import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { useLanguage } from '../../contexts/LanguageContext';
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

function HeroSection({ title, subtitle }) {
    const [isLoaded, setIsLoaded] = useState(false);
    const [activeFeature, setActiveFeature] = useState(0);
    const [searchData, setSearchData] = useState({
        category: '',
        location: '',
        date: ''
    });

  const handleDateChange = (date) => {
    setSearchData({ ...searchData, date });
  };
    const { t } = useTranslation();
    const { currentLanguage, languages, changeLanguage, isRTL, direction } = useLanguage();
    const [heroBg, setHeroBg] = useState(null);
    const [imageError, setImageError] = useState(false);
    const [categories, setCategories] = useState([]);
    const [filteredCategories, setFilteredCategories] = useState([]);
    const [showcategoryDropdown, setShowcategoryDropdown] = useState(false);
    const [cities, setCities] = useState([]);
    const [filteredCities, setFilteredCities] = useState([]);
    const [showCitiesDropdown, setShowCitiesDropdown] = useState(false);
    const navigate = useNavigate();
    const API_BASE_URL =
        window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
            ? import.meta.env.VITE_API_BASE_URL_LOCAL
            : import.meta.env.VITE_API_BASE_URL;
    useEffect(() => {
        const timer = setTimeout(() => {
            setIsLoaded(true);
        }, 500);
        return () => clearTimeout(timer);
    }, [title, subtitle]);
    useEffect(() => {
        const loadHeroImage = async () => {
            try {
                const routeResponse = await fetch(`${API_BASE_URL}/api/routes`);
                const routes = await routeResponse.json();
                const res = await fetch(routes.basicImages);
                const data = await res.json();
                if (data && data.hero_section_image) {
                    const possiblePaths = [
                        `${API_BASE_URL}/assets/img/homepage/${data.hero_section_image}`,
                        `${window.location.origin}/assets/img/homepage/${data.hero_section_image}`,
                        `/assets/img/homepage/${data.hero_section_image}`,
                        `${API_BASE_URL}/images/${data.hero_section_image}`,
                        `${window.location.origin}/images/${data.hero_section_image}`,
                        `/images/${data.hero_section_image}`,
                        `${data.hero_section_image}`
                    ];
                    const testImagePath = async (paths, index = 0) => {
                        if (index >= paths.length) {
                            setImageError(true);
                            setHeroBg(null);
                            return;
                        }
                        const img = new Image();
                        img.onload = () => {
                            setImageError(false);
                            setHeroBg(paths[index]);
                        };
                        img.onerror = () => {
                            testImagePath(paths, index + 1);
                        };
                        img.src = paths[index];
                    };
                    testImagePath(possiblePaths);
                } else {
                    setImageError(true);
                }
            } catch (e) {
                console.error('Error loading hero image:', e);
                setImageError(true);
            }
        };
        loadHeroImage();
    }, [API_BASE_URL]);
    useEffect(() => {
        const loadCategories = async () => {
            try {
                const routesResponse = await fetch(`${API_BASE_URL}/api/routes`);
                const routes = await routesResponse.json();
                const categoriesResponse = await fetch(routes.hotelsCategories);
                const categoriesData = await categoriesResponse.json();
                if (categoriesData && categoriesData.length > 0 && currentLanguage) {
                    let languageId = currentLanguage.id;
                    if (languageId) {
                        const filteredCategories = categoriesData.filter(
                            category => parseInt(category.language_id) === parseInt(languageId)
                        );
                        setCategories(filteredCategories);
                    } else {
                        setCategories(categoriesData);
                    }
                } else if (categoriesData && categoriesData.length > 0) {
                    setCategories(categoriesData);
                } else {
                    setCategories([]);
                }
            } catch (error) {
                console.error('Error loading categories:', error);
                setCategories([]);
            }
        };
        loadCategories();
    }, [API_BASE_URL, currentLanguage]);
    useEffect(() => {
        const loadCities = async () => {
            try {
                const routesResponse = await fetch(`${API_BASE_URL}/api/routes`);
                const routes = await routesResponse.json();
                const citiesResponse = await fetch(routes.cities);
                const citiesData = await citiesResponse.json();
                if (citiesData && Object.keys(citiesData).length > 0 && currentLanguage) {
                    let languageId = currentLanguage.id;
                    const citiesArray = Object.values(citiesData);
                    if (languageId) {
                        const filteredCities = citiesArray.filter(
                            city => parseInt(city.language_id) === parseInt(languageId)
                        );
                        setCities(filteredCities);
                    } else {
                        setCities(citiesArray);
                    }
                } else if (citiesData && Object.keys(citiesData).length > 0) {
                    const citiesArray = Object.values(citiesData);
                    setCities(citiesArray);
                } else {
                    setCities([]);
                }
            } catch (error) {
                setCities([]);
            }
        };
        loadCities();
    }, [API_BASE_URL, currentLanguage]);
    useEffect(() => {
        const handleClickOutside = (event) => {
            if (showcategoryDropdown && !event.target.closest('.category-input-container')) {
                setShowcategoryDropdown(false);
            }
            if (showCitiesDropdown && !event.target.closest('.location-input-container')) {
                setShowCitiesDropdown(false);
            }
        };
        document.addEventListener('mousedown', handleClickOutside);
        return () => {
            document.removeEventListener('mousedown', handleClickOutside);
        };
    }, [showcategoryDropdown, showCitiesDropdown]);
    const handleFeatureClick = (index) => {
        setActiveFeature(index);
    };
    const handleInputChange = (field, value) => {
        setSearchData(prev => ({
            ...prev,
            [field]: value
        }));
        if (field === 'category') {
            if (value.trim() === '') {
                setFilteredCategories([]);
                setShowcategoryDropdown(false);
            } else {
                const filtered = categories.filter(category =>
                    category.name && category.name.toLowerCase().includes(value.toLowerCase())
                );
                setFilteredCategories(filtered);
                setShowcategoryDropdown(true);
            }
        }
        if (field === 'location') {
            if (value.trim() === '') {
                setFilteredCities([]);
                setShowCitiesDropdown(false);
            } else {
                const filtered = cities.filter(city =>
                    city.name && city.name.toLowerCase().includes(value.toLowerCase())
                );
                setFilteredCities(filtered);
                setShowCitiesDropdown(true);
            }
        }
    };
    const handleCategorySelect = (categoryName) => {
        setSearchData(prev => ({
            ...prev,
            category: categoryName
        }));
        setShowcategoryDropdown(false);
        setFilteredCategories([]);
    };
    const handleCitySelect = (cityName) => {
        setSearchData(prev => ({
            ...prev,
            location: cityName
        }));
        setShowCitiesDropdown(false);
        setFilteredCities([]);
    };
    const handleSearchSubmit = (e) => {
        e.preventDefault();
        const params = new URLSearchParams();
        if (searchData.category) params.append('category', searchData.category);
        if (searchData.location) params.append('location', searchData.location);
        if (searchData.date) params.append('date', searchData.date);
        navigate(`/search?${params.toString()}`);
    };
    const getBackgroundStyle = () => {
        if (heroBg && !imageError) {
            return {
                backgroundImage: `url(${heroBg})`,
                backgroundSize: 'cover',
                backgroundPosition: 'center',
                width: '100%',
                height: '100vh',
                minHeight: '600px'
            };
        } else {
            return {
                background: '#000',
                width: '100%',
                height: '100vh',
                minHeight: '600px'
            };
        }
    };
    return (
        <div
            className="pt-16 md:pt-20 relative"
            style={getBackgroundStyle()}
        >
            <div className="absolute inset-0 bg-black bg-opacity-40 h-full z-0"></div>
            <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-[20px] sm:mt-[60px] md:mt-[120px] mb-4">
                <div className="text-center pt-6 sm:pt-10 md:pt-20">
                    <h1
                        data-aos="fade-up"
                        className={`text-center leading-tight sm:leading-none capitalize w-full font-bold text-white mb-4 sm:mb-6 drop-shadow-lg mx-auto px-2 sm:px-4 ${currentLanguage && currentLanguage.code === 'ar'
                                ? 'text-2xl sm:text-[35px] md:text-5xl lg:text-[80px] sm:w-[700px]' // Arabic: smaller font sizes
                                : 'text-3xl sm:text-[50px] md:text-6xl lg:text-[100px] sm:w-[614px]' // English: original font sizes
                            }`}
                    >
                        {title}
                    </h1>
                </div>
                <div>
                    <form
                        onSubmit={handleSearchSubmit} data-aos="zoom-in"
                        className="max-w-6xl mx-auto mb-8 p-5 sm:p-6 border-white rounded-[15px] bg-white/20 backdrop-blur-md shadow-2xl mt-[2rem] sm:mt-[4rem] md:mt-[7rem] flex flex-col lg:flex-row items-center justify-between gap-4 text-white"
                    >
                        <div className="flex items-start sm:items-center gap-3 flex-1 w-full lg:border-r lg:border-white/40 lg:pr-4 pb-4 lg:pb-0 relative">
                            <span className="text-[40px] sm:text-xl md:text-2xl">🎉</span>
                            <div className="w-full relative category-input-container">
                                <p className="font-semibold text-xs sm:text-sm md:text-base mb-2">{t('what_are_you_planning')}</p>
                                <input
                                    type="text"
                                    placeholder={t('enter_your_category')}
                                    value={searchData.category}
                                    onChange={(e) => handleInputChange('category', e.target.value)}
                                    onFocus={() => {
                                        if (searchData.category.trim() !== '') {
                                            const filtered = categories.filter(category =>
                                                category.name && category.name.toLowerCase().includes(searchData.category.toLowerCase())
                                            );
                                            setFilteredCategories(filtered);
                                            setShowcategoryDropdown(true);
                                        }
                                    }}
                                    className="bg-transparent placeholder-white/80 text-white focus:outline-none text-sm sm:text-base w-full border-b border-white/30 pb-2 focus:border-white/60 transition-colors lg:border-b-0"
                                />
                                {showcategoryDropdown && (
                                    <div className="absolute top-full left-0 right-0 bg-white/95 backdrop-blur-md rounded-lg shadow-lg border border-white/20 mt-1 max-h-48 overflow-y-auto z-[9999]">
                                        {filteredCategories.length > 0 ? (
                                            filteredCategories.map((category, index) => (
                                                <div
                                                    key={index}
                                                    onClick={() => handleCategorySelect(category.name)}
                                                    className="px-4 py-2 hover:bg-white/20 cursor-pointer text-gray-800 hover:text-white transition-colors border-b border-white/10 last:border-b-0"
                                                >
                                                    {category.name}
                                                </div>
                                            ))
                                        ) : (
                                            <div className="px-4 py-3 text-gray-500 text-center italic">
                                                {t('no_activities_found')}
                                            </div>
                                        )}
                                    </div>
                                )}
                            </div>
                        </div>
                        <div className="flex items-start sm:items-center gap-3 flex-1 w-full lg:border-r lg:border-white/40 lg:px-4 pb-4 lg:pb-0 relative">
                            <span className="text-[40px] sm:text-[50px] md:text-[60px]"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" className="size-6 sm:size-8 md:size-10">
                                <path fillRule="evenodd" d="m11.54 22.351.07.04.028.016a.76.76 0 0 0 .723 0l.028-.015.071-.041a16.975 16.975 0 0 0 1.144-.742 19.58 19.58 0 0 0 2.683-2.282c1.944-1.99 3.963-4.98 3.963-8.827a8.25 8.25 0 0 0-16.5 0c0 3.846 2.02 6.837 3.963 8.827a19.58 19.58 0 0 0 2.682 2.282 16.975 16.975 0 0 0 1.145.742ZM12 13.5a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z" clipRule="evenodd" />
                            </svg>
                            </span>
                            <div className="w-full relative location-input-container">
                                <p className="font-semibold text-xs sm:text-sm md:text-base mb-2">{t('where')}</p>
                                <input
                                    type="text"
                                    placeholder={t('enter_city_or_address')}
                                    value={searchData.location}
                                    onChange={(e) => handleInputChange('location', e.target.value)}
                                    onFocus={() => {
                                        if (searchData.location.trim() !== '') {
                                            const filtered = cities.filter(city =>
                                                city.name && city.name.toLowerCase().includes(searchData.location.toLowerCase())
                                            );
                                            setFilteredCities(filtered);
                                            setShowCitiesDropdown(true);
                                        }
                                    }}
                                    className="bg-transparent placeholder-white/80 text-white focus:outline-none text-sm sm:text-base w-full border-b border-white/30 pb-2 focus:border-white/60 transition-colors lg:border-b-0"
                                />
                                {showCitiesDropdown && (
                                    <div className="absolute top-full left-0 right-0 bg-white/95 backdrop-blur-md rounded-lg shadow-lg border border-white/20 mt-1 max-h-48 overflow-y-auto z-[9999]">
                                        {filteredCities.length > 0 ? (
                                            filteredCities.map((city, index) => (
                                                <div
                                                    key={index}
                                                    onClick={() => handleCitySelect(city.name)}
                                                    className="px-4 py-2 hover:bg-white/20 cursor-pointer text-gray-800 hover:text-white transition-colors border-b border-white/10 last:border-b-0"
                                                >
                                                    {city.name}
                                                </div>
                                            ))
                                        ) : (
                                            <div className="px-4 py-3 text-gray-500 text-center italic">
                                                {t('no_cities_found')}
                                            </div>
                                        )}
                                    </div>
                                )}
                            </div>
                        </div>
                        <div className="flex items-start sm:items-center gap-3 flex-1 w-full px-0 lg:px-4 pb-4 lg:pb-0">
                            <span className="text-[40px] sm:text-[50px] md:text-[60px]"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" className="size-6 sm:size-8 md:size-10">
                                <path d="M12.75 12.75a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM7.5 15.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5ZM8.25 17.25a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM9.75 15.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5ZM10.5 17.25a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM12 15.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5ZM12.75 17.25a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM14.25 15.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5ZM15 17.25a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM16.5 15.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5ZM15 12.75a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM16.5 13.5a.75.75 0 1 0 0-1.5.75.75 0 0 1 1.5 0Z" />
                                <path fillRule="evenodd" d="M6.75 2.25A.75.75 0 0 1 7.5 3v1.5h9V3A.75.75 0 0 1 18 3v1.5h.75a3 3 0 0 1 3 3v11.25a3 3 0 0 1-3 3H5.25a3 3 0 0 1-3-3V7.5a3 3 0 0 1 3-3H6V3a.75.75 0 0 1 .75-.75Zm13.5 9a1.5 1.5 0 0 0-1.5-1.5H5.25a1.5 1.5 0 0 0-1.5 1.5v7.5a1.5 1.5 0 0 0 1.5 1.5h13.5a1.5 1.5 0 0 0 1.5-1.5v-7.5Z" clipRule="evenodd" />
                            </svg>
                            </span>
                            <div className="w-full">
                                <p className="font-semibold text-xs sm:text-sm md:text-base mb-2">{t('when')}</p>
                                <DatePicker
          selected={searchData.date}
          onChange={handleDateChange}
          placeholderText={t('anytime')}
          dateFormat="dd/MM/yyyy"
          className="bg-transparent placeholder-white/80 text-white focus:outline-none text-sm sm:text-base w-full border-b border-white/30 pb-2 focus:border-white/60 transition-colors lg:border-b-0"
        />
                            </div>
                        </div>
                        <button
                            type="submit"
                            className="bg-white text-gray-800 px-4 sm:px-6 py-3 rounded-xl font-semibold hover:bg-gray-100 transition-colors flex items-center justify-center gap-2 shadow-md w-full lg:w-auto min-h-[44px] text-sm sm:text-base"
                        >
                            🔍 {t('search')}
                        </button>
                    </form>
                </div>
            </div>
        </div>
    );
}
export default HeroSection; 