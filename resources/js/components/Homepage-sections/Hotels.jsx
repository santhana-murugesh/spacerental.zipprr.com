import React, { useState, useRef, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { FaHeart, FaRegHeart } from 'react-icons/fa';
import { useAuth } from '../AuthContext';
import { useTranslation } from 'react-i18next';
import { useLanguage } from '../../contexts/LanguageContext';

export const Hotels = () => {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const { currentLanguage, languages, changeLanguage, isRTL, direction } = useLanguage();
  
  // Force English language for wishlist display
  const forceEnglishLanguage = () => {
    if (currentLanguage && currentLanguage.id !== 1) {
      // Temporarily change to English (language_id = 1)
      const englishLanguage = languages.find(lang => lang.id === 1);
      if (englishLanguage) {
        changeLanguage(englishLanguage);
      }
    }
  };

  // Override language to English for wishlist content
  const getWishlistLanguage = () => {
    return 1; // Force English (language_id = 1)
  };
  const { user, loading: authLoading } = useAuth();
  const [activeCategory, setActiveCategory] = useState('All');
  const [hotels, setHotels] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [whitelistedHotels, setWhitelistedHotels] = useState(new Set());
  const [isMobile, setIsMobile] = useState(false);
  const [activeCardIndex, setActiveCardIndex] = useState(0);
  const [touchStart, setTouchStart] = useState(null);
  const [touchEnd, setTouchEnd] = useState(null);
  const scrollRef = useRef(null);

  const API_BASE_URL =
    window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
      ? import.meta.env.VITE_API_BASE_URL_LOCAL
      : import.meta.env.VITE_API_BASE_URL;

  const CARD_WIDTH = 220; 
  const GAP_PX = 16; 

  useEffect(() => {
    const checkMobile = () => {
      setIsMobile(window.innerWidth < 768);
    };
    
    checkMobile();
    window.addEventListener('resize', checkMobile);
    return () => window.removeEventListener('resize', checkMobile);
  }, []);

  // Force English language when component mounts to ensure English content
  useEffect(() => {
    forceEnglishLanguage();
  }, []);



  const fetchHotelContentForWishlist = async (hotelIds) => {
    try {
      // Fetch hotel content to ensure we have English content
      const routesResponse = await fetch(`${API_BASE_URL}/api/routes`);
      const routes = await routesResponse.json();
      
      const hotelsResponse = await fetch(routes.hotelsFilterByBounds);
      const hotelsData = await hotelsResponse.json();
      
      if (hotelsData.success && hotelsData.hotels) {
        // Filter for English hotels (language_id = 1) or fallback to any available
        const englishHotels = hotelsData.hotels.filter(hotel => 
          hotelIds.includes(hotel.id) && 
          (parseInt(hotel.language_id) === 1 || !hotel.language_id)
        );
        
        if (englishHotels.length > 0) {
          // Update the hotels state with English content
          setHotels(prevHotels => {
            const updatedHotels = [...prevHotels];
            englishHotels.forEach(englishHotel => {
              const existingIndex = updatedHotels.findIndex(h => h.id === englishHotel.id);
              if (existingIndex >= 0) {
                updatedHotels[existingIndex] = englishHotel;
              }
            });
            return updatedHotels;
          });
        }
      }
    } catch (error) {
      console.error('Error fetching hotel content for wishlist:', error);
    }
  };

  const fetchWhitelistedHotels = async () => {
    try {
      if (user) {
        const token = localStorage.getItem('jwt_token');
        if (!token) {
          console.log('No JWT token found, falling back to localStorage');
          const stored = localStorage.getItem(`whitelisted_hotels_${user.id}`);
          if (stored) {
            const whitelistArray = JSON.parse(stored);
            setWhitelistedHotels(new Set(whitelistArray));
          }
          return;
        }

        // Try to get from JWT-based API
        try {
          const response = await fetch(`${API_BASE_URL}/api/wishlist/hotels`, {
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${token}`,
            },
          });

          if (response.ok) {
            const data = await response.json();
            if (data.success && data.wishlists) {
              const hotelIds = data.wishlists.map(item => item.hotel_id);
              setWhitelistedHotels(new Set(hotelIds));
              localStorage.setItem(`whitelisted_hotels_${user.id}`, JSON.stringify(hotelIds));
              
              // Also fetch hotel content to ensure we have English content
              await fetchHotelContentForWishlist(hotelIds);
              return;
            }
          }
        } catch (apiError) {
          console.log('JWT API fetch failed, falling back to localStorage:', apiError);
        }

        // Fallback to localStorage if API fails
        const stored = localStorage.getItem(`whitelisted_hotels_${user.id}`);
        if (stored) {
          const whitelistArray = JSON.parse(stored);
          setWhitelistedHotels(new Set(whitelistArray));
        }
      }
    } catch (error) {
      console.error('Error fetching whitelisted hotels:', error);
    }
  };

  const toggleWhitelist = async (hotelId, event) => {
    event.stopPropagation();
    console.log('toggleWhitelist called for hotel:', hotelId);
    console.log('Current user:', user);
    console.log('Auth loading:', authLoading);
    
    if (authLoading) {
      console.log('Auth is loading, returning early');
      return;
    }

    if (!user) {
      console.log('No user found, navigating to login');
      navigate('/user/login');
      return;
    }

    const token = localStorage.getItem('jwt_token');
    console.log('JWT token found:', token ? 'Yes' : 'No');
    if (!token) {
      console.error('No JWT token found');
      return;
    }

    try {
      const isCurrentlyWhitelisted = whitelistedHotels.has(hotelId);
      const endpoint = isCurrentlyWhitelisted ? '/api/wishlist/hotel/remove' : '/api/wishlist/hotel/add';

      const response = await fetch(`${API_BASE_URL}${endpoint}`, {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify({
          hotel_id: hotelId
        })
      });

      if (response.ok) {
        const data = await response.json();
        if (data.success) {
          const newWhitelistedHotels = new Set(whitelistedHotels);
          if (isCurrentlyWhitelisted) {
            newWhitelistedHotels.delete(hotelId);
          } else {
            newWhitelistedHotels.add(hotelId);
          }
          setWhitelistedHotels(newWhitelistedHotels);
          localStorage.setItem(`whitelisted_hotels_${user.id}`, JSON.stringify([...newWhitelistedHotels]));
        } else {
          console.error('API Error:', data.message);
        }
      } else {
        console.error('Failed to update wishlist:', response.status);
      }
    } catch (error) {
      console.error('Error toggling whitelist:', error);
    }
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const routesResponse = await fetch(`${API_BASE_URL}/api/routes`);
        const routes = await routesResponse.json();

        const categoriesResponse = await fetch(routes.hotelsCategories);
        const categoriesData = await categoriesResponse.json();
        
        // Filter categories based on current language ID
        if (categoriesData && currentLanguage) {
          // Use the language ID directly from currentLanguage
          let languageId = currentLanguage.id;

          if (languageId) {
            const filteredCategories = categoriesData.filter(
              category => parseInt(category.language_id) === parseInt(languageId)
            );
            setCategories(filteredCategories);
          } else {
            setCategories(categoriesData);
          }
        } else {
          setCategories(categoriesData);
        }

        const hotelsResponse = await fetch(routes.hotelsFilterByBounds);
        const hotelsData = await hotelsResponse.json();
        if (hotelsData.success) {
          // For wishlist display, always prioritize English content
          let allHotels = hotelsData.hotels || [];
          
          // First try to get English hotels (language_id = 1)
          const englishHotels = allHotels.filter(
            hotel => parseInt(hotel.language_id) === 1
          );
          
          if (englishHotels.length > 0) {
            setHotels(englishHotels);
          } else {
            // Fallback to current language or all hotels
            if (currentLanguage && currentLanguage.id) {
              const languageSpecificHotels = allHotels.filter(
                hotel => parseInt(hotel.language_id) === parseInt(currentLanguage.id)
              );
              setHotels(languageSpecificHotels.length > 0 ? languageSpecificHotels : allHotels);
            } else {
              setHotels(allHotels);
            }
          }
        } else {
          setError('Failed to fetch hotels');
        }
      } catch (err) {
        setError('Error loading data. Please check if the server is running.');
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, [currentLanguage]);

  useEffect(() => {
    console.log('Hotels component useEffect - user:', user, 'authLoading:', authLoading);
    if (user && !authLoading) {
      console.log('Fetching whitelisted hotels for user:', user.id);
      fetchWhitelistedHotels();
    } else {
      console.log('Not fetching whitelisted hotels - user:', user ? 'exists' : 'null', 'authLoading:', authLoading);
    }
  }, [user, authLoading]);

  const scroll = (direction) => {
    if (direction === 'left') {
      setCurrentIndex(prev => Math.max(0, prev - 4));
    } else {
      setCurrentIndex(prev => Math.min(filteredHotels.length - 4, prev + 4));
    }
  };
  useEffect(() => {
    if (scrollRef.current) {
      const scrollPosition = currentIndex * (CARD_WIDTH + GAP_PX);
      scrollRef.current.scrollTo({
        left: scrollPosition,
        behavior: 'smooth',
      });
    }
  }, [currentIndex]);

  useEffect(() => {
    setCurrentIndex(0);
    setActiveCardIndex(0);
  }, [activeCategory]);
  const onTouchStart = (e) => {
    if (!isMobile) return;
    setTouchEnd(null);
    setTouchStart(e.targetTouches[0].clientX);
  };

  const onTouchMove = (e) => {
    if (!isMobile) return;
    setTouchEnd(e.targetTouches[0].clientX);
  };

  const onTouchEnd = () => {
    if (!isMobile || !touchStart || !touchEnd) return;
    
    const distance = touchStart - touchEnd;
    const isLeftSwipe = distance > 50;
    const isRightSwipe = distance < -50;
    
    if (scrollRef.current) {
      const scrollAmount = 300; 
      
      if (isLeftSwipe) {
        scrollRef.current.scrollBy({
          left: scrollAmount,
          behavior: 'smooth'
        });
      } else if (isRightSwipe) {
        scrollRef.current.scrollBy({
          left: -scrollAmount,
          behavior: 'smooth'
        });
      }
    }
  };

  const getHotelImage = (hotel) => {
    if (hotel.hotel_galleries && hotel.hotel_galleries.length > 0) {
      return `${API_BASE_URL}/assets/img/hotel/hotel-gallery/${hotel.hotel_galleries[0].image}`;
    }
    if (hotel.logo) {
      return `${API_BASE_URL}/assets/img/hotel/logo/${hotel.logo}`;
    }
    return `${API_BASE_URL}/assets/img/room1.jpg`;
  };

  const formatPrice = (hotel) => {
    if (hotel.min_price && hotel.max_price) {
      return `$${hotel.min_price} - $${hotel.max_price}`;
    } else if (hotel.min_price) {
      return `$${hotel.min_price}`;
    } else if (hotel.max_price) {
      return `$${hotel.max_price}`;
    }
    return 'Price on request';
  };

  const getHotelTitle = (hotel) => hotel.title || hotel.name || 'Meeting Space Hire';

  const filteredHotels = activeCategory === 'All'
    ? hotels
    : hotels.filter(hotel => hotel.categoryName === activeCategory);

  if (loading) {
    return (
      <div className="bg-[#f6f9fe] py-8 px-4">
        <div className="flex justify-center items-center h-64">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="bg-[#f6f9fe] py-8 px-4">
        <div className="flex justify-center items-center h-64">
          <div className="text-red-600 text-center">
            <p className="text-lg font-semibold">{error}</p>
            <p className="text-sm">Please try again later</p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="bg-[#F3F9FF] py-6 md:py-10 px-4 overflow-hidden">
      <div 
        data-aos="fade-left"
        data-aos-duration="800"
        data-aos-delay="100"
        className="flex justify-center gap-2 md:gap-4 lg:gap-[3.5rem] overflow-x-auto scrollbar-hide mb-6 md:mb-8 px-2"
      >
        <button
          key="all"
          onClick={() => setActiveCategory('All')}
          className={`flex flex-col items-center gap-1 text-xs md:text-sm transition duration-200 flex-shrink-0 ${
            activeCategory === 'All'
              ? 'font-semibold text-black'
              : 'text-gray-500'
          }`}
        >
          <span className="text-2xl md:text-3xl lg:text-4xl">
            <svg 
              className="w-[15px] h-[15px] md:w-8 md:h-8 lg:w-9 lg:h-9 flex items-center justify-center" 
              fill="currentColor" 
              viewBox="0 0 24 24"
            >
              <path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/>
            </svg>
          </span>
          <span className="text-xs md:text-sm">
            {t('all')}
          </span>
        </button>
        {categories.map((category, index) => (
          <button
            key={category.id}
            onClick={() => setActiveCategory(category.name)}
            className={`flex flex-col items-center gap-1 text-xs md:text-sm transition duration-200 flex-shrink-0 ${
              activeCategory === category.name
                ? 'font-semibold text-black'
                : 'text-gray-500'
            }`}
          >
            <span className="text-2xl md:text-3xl lg:text-4xl">
              {category.icon ? (
                category.icon.includes('<svg') || category.icon.includes('<SVG') ? (
                  <div 
                    className="w-[15px] h-[15px] md:w-8 md:h-8 lg:w-9 lg:h-9 flex items-center justify-center"
                    dangerouslySetInnerHTML={{ __html: category.icon }}
                  />
                ) : category.icon.includes('fas ') || category.icon.includes('fa ') || category.icon.includes('fab ') || category.icon.includes('far ') ? (
                  <i className={category.icon}></i>
                ) : (
                  category.icon
                )
              ) : (
                ''
              )}
            </span>
            <span className="text-xs md:text-sm">
              {category.name.length > 8 ? `${category.name.substring(0, 8)}...` : category.name}
            </span>
          </button>
        ))}
      </div>

      <div className="relative max-w-6xl mx-auto">
        {/* Navigation Buttons - Hidden on mobile */}
        {filteredHotels.length > 4 && (
          <button
            data-aos="fade-left"
            data-aos-duration="800"
            data-aos-delay="300"
            onClick={() => scroll('left')}
            className="hidden md:block absolute left-0 top-1/2 transform -translate-y-1/2 z-10 rounded-[50%] p-3 transition-colors bg-black h-[48px] w-[48px] text-white"
            style={{ marginLeft: '-24px' }}
          >
            ←
          </button>
        )}
        
        <div
          ref={scrollRef}
          className={`flex gap-3 md:gap-4 lg:gap-6 transition-all duration-500 ease-in-out ${
            isMobile 
              ? 'overflow-x-auto overflow-y-hidden snap-x snap-mandatory scrollbar-hide' 
              : 'overflow-x-auto md:overflow-hidden justify-center'
          } px-2 md:px-4 lg:px-8`}
          style={{ 
            padding: "16px 8px",
            scrollBehavior: isMobile ? 'smooth' : 'auto'
          }}
          onTouchStart={onTouchStart}
          onTouchMove={onTouchMove}
          onTouchEnd={onTouchEnd}
        >
          {filteredHotels.length > 0 ? (
            (isMobile ? filteredHotels : filteredHotels.slice(currentIndex, currentIndex + 4)).map((hotel, index) => (
              <div
                key={`${hotel.id || index}-${currentIndex}`}
                data-aos="fade-left"
                data-aos-duration="800"
                data-aos-delay={400 + (index * 150)}
                className="w-[220px] sm:w-[240px] md:w-[230px] h-[264px] md:h-[286px] rounded-xl shadow-xl bg-white overflow-hidden hover:shadow-2xl transition-shadow duration-300 flex-shrink-0 cursor-pointer"
                onClick={() => {
                  if (hotel.id) {
                    navigate(`/hotels/${hotel.id}`);
                  }
                }}
              >
                <div className="relative">
                  <img
                    src={getHotelImage(hotel)}
                    alt={getHotelTitle(hotel)}
                    className="w-full h-[110px] md:h-[120px] object-cover"
                    onError={(e) => {
                      e.target.src = `${API_BASE_URL}/assets/img/room1.jpg`;
                    }}
                  />
                    
                    <button
                      onClick={(e) => {
                        e.preventDefault();
                        e.stopPropagation();
                        console.log('Heart button clicked for hotel:', hotel.id);
                        toggleWhitelist(hotel.id, e);
                      }}
                      onMouseDown={(e) => e.stopPropagation()}
                      onMouseUp={(e) => e.stopPropagation()}
                      disabled={authLoading}
                      className={`absolute top-2 right-2 bg-white p-2 rounded-full shadow-md transition-all duration-200 z-50 ${
                        authLoading 
                          ? 'opacity-50 cursor-not-allowed' 
                          : 'hover:shadow-lg cursor-pointer'
                      }`}
                      title={
                        authLoading 
                          ? "Loading..." 
                          : whitelistedHotels.has(hotel.id) 
                            ? "Remove from favorites" 
                            : "Add to favorites"
                      }
                    >
                      {whitelistedHotels.has(hotel.id) ? (
                        <FaHeart className="w-4 h-4 md:w-5 md:h-5 text-red-500" />
                      ) : (
                        <FaRegHeart className="w-4 h-4 md:w-5 md:h-5 text-gray-600 hover:text-red-500 transition-colors duration-200" />
                      )}
                    </button>
                    
                    <div className="absolute bottom-0 right-0 bg-yellow-400 px-2 py-1 text-xs md:text-sm font-bold">
                      {formatPrice(hotel)}
                    </div>
                </div>
                <div className="p-3 md:p-4 h-[120px] md:h-[132px] flex flex-col justify-between">
                  <div>
                    <h3 className="font-semibold text-base md:text-lg mb-1">
                      {getHotelTitle(hotel)}
                    </h3>
                    <p className="text-gray-500 text-xs md:text-sm mb-2">
                      {hotel.categoryName || 'East Victoria Park'}
                    </p>
                    <div className="flex justify-between items-center text-xs text-gray-600 mb-2">
                      {hotel.total_rooms && (
                        <span className="mr-2">{t('rooms')}: {hotel.total_rooms}</span>
                      )}
                      {hotel.stars && (
                        <div className="flex items-center space-x-1">
                          <h1 className="text-xs md:text-sm text-gray-600">{hotel.stars}</h1>
                          <div className="flex items-center">
                            {[...Array(Number(hotel.stars))].map((_, i) => (
                              <svg
                                key={i}
                                className="w-3 h-3 md:w-4 md:h-4 text-yellow-400"
                                fill="currentColor"
                                viewBox="0 0 20 20"
                              >
                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.286 3.957a1 1 0 00.95.69h4.164c.969 0 1.371 1.24.588 1.81l-3.37 2.448a1 1 0 00-.364 1.118l1.286 3.957c.3.921-.755 1.688-1.538 1.118l-3.37-2.448a1 1 0 00-1.175 0l-3.37 2.448c-.783.57-1.838-.197-1.538-1.118l1.286-3.957a1 1 0 00-.364-1.118L2.07 9.384c-.783-.57-.38-1.81.588-1.81h4.165a1 1 0 00.95-.69l1.286-3.957z" />
                              </svg>
                            ))}
                          </div>
                        </div>
                      )}
                    </div>
                    <div className="flex items-center text-xs text-gray-600 mb-2">
                      {hotel.city_name && (
                        <span className="">📍 {hotel.city_name},</span>
                      )}
                      {hotel.state_name && (
                        <span className="">{hotel.state_name},</span>
                      )}
                      {hotel.country_name && (
                        <span className="">{hotel.country_name}</span>
                      )}
                    </div>
                  </div>
                  <p className="text-xs md:text-sm text-blue-800 font-semibold">
                  </p>
                </div>
              </div>
            ))
          ) : (
            <div 
              data-aos="fade-up"
              data-aos-duration="800"
              className="w-full text-center py-8"
            >
              <p className="text-gray-500">{t('no_hotels_found_in_this_category')}</p>
            </div>
          )}
        </div>

        {isMobile && filteredHotels.length > 1 && (
          <div className="flex justify-center items-center mt-6 space-x-4">
            <button
              onClick={() => {
                if (scrollRef.current) {
                  scrollRef.current.scrollBy({
                    left: -300,
                    behavior: 'smooth'
                  });
                }
              }}
              className="bg-black text-white rounded-full p-3 hover:bg-gray-800 transition-colors duration-200 shadow-lg"
              aria-label="Scroll left"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
              </svg>
            </button>
            
            <button
              onClick={() => {
                if (scrollRef.current) {
                  scrollRef.current.scrollBy({
                    left: 300,
                    behavior: 'smooth'
                  });
                }
              }}
              className="bg-black text-white rounded-full p-3 hover:bg-gray-800 transition-colors duration-200 shadow-lg"
              aria-label="Scroll right"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
              </svg>
            </button>
          </div>
        )}

        <button
          data-aos="fade-right"
          data-aos-duration="800"
          data-aos-delay="300"
          onClick={() => scroll('right')}
          className='hidden md:block absolute right-0 top-1/2 transform -translate-y-1/2 z-10 rounded-[50%] p-2 transition-colors h-[48px] w-[48px] bg-black text-white'
          style={{ marginRight: '-24px' }}
        >
          →
        </button>
      </div>
    </div>
  );
};
