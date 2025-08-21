import React, { useEffect, useMemo, useState } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import { Header } from './Homepage-sections/Header';
import { useAuth } from './AuthContext';
import { FaHeart, FaRegHeart } from 'react-icons/fa';

const customStyles = `
  .line-clamp-2 {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }
  
  .scrollbar-hide {
    -ms-overflow-style: none;
    scrollbar-width: none;
  }
  
  .scrollbar-hide::-webkit-scrollbar {
    display: none;
  }
  
  @media (max-width: 640px) {
    .mobile-full-width {
      width: 100% !important;
    }
  }
`;

if (typeof document !== 'undefined') {
  const styleElement = document.createElement('style');
  styleElement.textContent = customStyles;
  document.head.appendChild(styleElement);
}
function HotelDetails() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [hotel, setHotel] = useState(null);
  const [rooms, setRooms] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [showAllAmenities, setShowAllAmenities] = useState(false);
  const [distances, setDistances] = useState({
    airport: null,
    railway: null,
    cityCenter: null
  });
  const [similarHotels, setSimilarHotels] = useState([]);
  const [showBookingModal, setShowBookingModal] = useState(false);
  const [showRoomSelectionModal, setShowRoomSelectionModal] = useState(false);
  const [showImageGalleryModal, setShowImageGalleryModal] = useState(false);
  const [showAllHotelImagesModal, setShowAllHotelImagesModal] = useState(false);
  const [selectedRoom, setSelectedRoom] = useState(null);
  const [roomImages, setRoomImages] = useState([]);
  const [loadingRoomImages, setLoadingRoomImages] = useState(false);
  const [roomAmenities, setRoomAmenities] = useState([]);
  const [loadingRoomAmenities, setLoadingRoomAmenities] = useState(false);
  const [hourlyPrices, setHourlyPrices] = useState([]);
  const [loadingPrices, setLoadingPrices] = useState(false);
  const [availableTimeSlots, setAvailableTimeSlots] = useState([]);
  const [loadingTimeSlots, setLoadingTimeSlots] = useState(false);
  const [selectedStartTime, setSelectedStartTime] = useState('');
  const [selectedEndTime, setSelectedEndTime] = useState('');
  const [selectedDate, setSelectedDate] = useState(new Date().toISOString().split('T')[0]);
  const [selectedDuration, setSelectedDuration] = useState('');
  const [selectedAttendees, setSelectedAttendees] = useState('');
  const [selectedPrice, setSelectedPrice] = useState(null);
  const [selectedHourId, setSelectedHourId] = useState(null);
  const [adult, setAdult] = useState(1);
  const [children, setChildren] = useState(0);
  const [checkInDate, setCheckInDate] = useState(new Date().toISOString().split('T')[0]);
  const [checkInTime, setCheckInTime] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [bookingError, setBookingError] = useState(null);
  const [bookingSuccess, setBookingSuccess] = useState(false);
  const [fontAwesomeLoaded, setFontAwesomeLoaded] = useState(false);
  const { user } = useAuth();
  const [whitelistedHotels, setWhitelistedHotels] = useState(new Set());
  const [currentImageIndex, setCurrentImageIndex] = useState(0);
  const [selectedMainImage, setSelectedMainImage] = useState(0);
  const [touchStart, setTouchStart] = useState(null);

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
      link.href = 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css';
      link.onload = () => {
        setTimeout(() => {
          setFontAwesomeLoaded(true);
        }, 100);
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

  const API_BASE_URL = useMemo(() => {
    return window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
      ? import.meta.env.VITE_API_BASE_URL_LOCAL
      : import.meta.env.VITE_API_BASE_URL;
  }, []);
  const calculateDistance = (lat1, lon1, lat2, lon2) => {
    const R = 6371;
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLon = (lon2 - lon1) * Math.PI / 180;
    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
      Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const distance = R * c;
    return distance;
  };
  const calculateDistances = (hotelLat, hotelLon) => {
    if (!hotelLat || !hotelLon) return;
    const airportCoords = { lat: -37.8136, lon: 144.9631 };
    const railwayCoords = { lat: -37.8136, lon: 144.9631 };
    const cityCenterCoords = { lat: -37.8136, lon: 144.9631 };
    const airportDistance = calculateDistance(hotelLat, hotelLon, airportCoords.lat, airportCoords.lon);
    const railwayDistance = calculateDistance(hotelLat, hotelLon, railwayCoords.lat, railwayCoords.lon);
    const cityCenterDistance = calculateDistance(hotelLat, hotelLon, cityCenterCoords.lat, cityCenterCoords.lon);
    setDistances({
      airport: airportDistance.toFixed(1),
      railway: airportDistance.toFixed(1),
      cityCenter: cityCenterDistance.toFixed(1)
    });
  };
  const timeToMinutes = (timeStr) => {
    if (!timeStr) return 0;
    let time = timeStr.trim();
    if (time.includes('AM') || time.includes('PM')) {
      time = new Date(`2000-01-01 ${time}`).toLocaleTimeString('en-US', {
        hour12: false,
        hour: '2-digit',
        minute: '2-digit'
      });
    }
    const parts = time.split(':');
    const hours = parseInt(parts[0], 10);
    const minutes = parseInt(parts[1], 10);
    return hours * 60 + minutes;
  };
  const validateAndFormatPrice = (price) => {
    if (!price) return { isValid: false, formatted: 'N/A', value: 0 };
    const numericPrice = parseFloat(price);
    const isValid = !isNaN(numericPrice) && numericPrice > 0;
    const formatted = isValid ? numericPrice.toFixed(2) : 'N/A';
    return { isValid, formatted, value: numericPrice };
  };



  const fetchWhitelistedHotels = async () => {
    try {
      if (user) {
        // Try to get from JWT-based API
        try {
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
              // Also update localStorage
              localStorage.setItem(`whitelisted_hotels_${user.id}`, JSON.stringify(hotelIds));
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



  const toggleHotelWhitelist = async (hotelId, event) => {
    event.stopPropagation(); 
    
    if (!user) {
      navigate('/user/login');
      return;
    }

    try {
      const isCurrentlyWhitelisted = whitelistedHotels.has(hotelId);
      const endpoint = isCurrentlyWhitelisted ? '/api/wishlist/hotel/remove' : '/api/wishlist/hotel/add';
      
      // Get JWT token
      const token = localStorage.getItem('jwt_token');
      if (!token) {
        console.error('No JWT token found');
        return;
      }
      
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
          
          console.log(data.message);
        } else {
          console.error('API Error:', data.message);
        }
      } else {
        console.error('Failed to update wishlist:', response.status);
      }
      
    } catch (error) {
      console.error('Error toggling hotel whitelist:', error);
    }
  };

  const nextImage = () => {
    setCurrentImageIndex((prevIndex) => 
      prevIndex === galleryImages.length - 1 ? 0 : prevIndex + 1
    );
  };

  const prevImage = () => {
    setCurrentImageIndex((prevIndex) => 
      prevIndex === 0 ? galleryImages.length - 1 : prevIndex - 1
    );
  };

  const goToImage = (index) => {
    setCurrentImageIndex(index);
  };

  const handleTouchStart = (e) => {
    const touch = e.touches[0];
    setTouchStart(touch.clientX);
  };

  const handleTouchMove = (e) => {
    if (!touchStart) return;
    
    const touch = e.touches[0];
    const diff = touchStart - touch.clientX;
    
    if (Math.abs(diff) > 50) {
      if (diff > 0) {
        nextImage();
      } else {
        prevImage();
      }
      setTouchStart(null);
    }
  };

  const handleTouchEnd = () => {
    setTouchStart(null);
  };

  const fetchHourlyPrices = async (roomId, selectedDate, startTime) => {
    if (!roomId || !selectedDate || !startTime) return;
    setLoadingPrices(true);
    try {
      const response = await fetch(`${API_BASE_URL}/api/rooms/get-custom-pricing?roomId=${roomId}&date=${selectedDate}`);
      if (response.ok) {
        const data = await response.json();
        if (data.success && data.hourlyPrices) {
          setHourlyPrices(data.hourlyPrices);
        } else {
          setHourlyPrices([]);
        }
      } else {
        setHourlyPrices([]);
      }
    } catch (error) {
      setHourlyPrices([]);
    } finally {
      setLoadingPrices(false);
    }
  };
  const fetchAvailableTimeSlots = async (roomId, selectedDate) => {
    if (!roomId || !selectedDate) return;
    setLoadingTimeSlots(true);
    try {
      const url = `${API_BASE_URL}/api/rooms/available-time-slots?roomId=${roomId}&date=${selectedDate}`;
      const response = await fetch(url);
      const data = await response.json();
      if (data.success) {
        setAvailableTimeSlots(data.timeSlots || []);
      } else {
        setAvailableTimeSlots([]);
      }
    } catch (error) {
      setAvailableTimeSlots([]);
    } finally {
      setLoadingTimeSlots(false);
    }
  };
  const fetchRoomImages = async (roomId) => {
    if (!roomId) {
      return;
    }
    setLoadingRoomImages(true);
    try {
      const url = `${API_BASE_URL}/api/rooms/get-room-images?roomId=${roomId}`;
      const response = await fetch(url);
      if (response.ok) {
        const data = await response.json();
        if (data.success && data.roomImages && data.roomImages.length > 0) {
          setRoomImages(data.roomImages);
        } else {
          setRoomImages([]);
        }
      } else {
        setRoomImages([]);
      }
    } catch (error) {
      setRoomImages([]);
    } finally {
      setLoadingRoomImages(false);
    }
  };
  const fetchRoomAmenities = async (roomId) => {
    if (!roomId) {
      return;
    }
    setLoadingRoomAmenities(true);
    try {
      const url = `${API_BASE_URL}/api/rooms/get-room-amenities?roomId=${roomId}`;
      const response = await fetch(url);
      if (response.ok) {
        const data = await response.json();
        if (data.success && data.amenities && data.amenities.length > 0) {
          setRoomAmenities(data.amenities);
        } else {
          setRoomAmenities([]);
        }
      } else {
        setRoomAmenities([]);
      }
    } catch (error) {
      setRoomAmenities([]);
    } finally {
      setLoadingRoomAmenities(false);
    }
  };
  useEffect(() => {
    if (showBookingModal && selectedRoom) {
      setAvailableTimeSlots([]);
      setHourlyPrices([]);
      setSelectedStartTime('');
      setSelectedEndTime('');
      setSelectedDate(new Date().toISOString().split('T')[0]);
    }
  }, [showBookingModal, selectedRoom]);
  useEffect(() => {
    if (selectedStartTime && selectedRoom && selectedDate) {
      fetchHourlyPrices(selectedRoom.id, selectedDate, selectedStartTime);
    }
  }, [selectedStartTime, selectedRoom, selectedDate]);
  useEffect(() => {
    if (showImageGalleryModal && selectedRoom) {
      fetchRoomImages(selectedRoom.id);
      fetchRoomAmenities(selectedRoom.id);
    }
  }, [showImageGalleryModal, selectedRoom]);
  useEffect(() => {
    ensureFontAwesomeLoaded();
  }, []);

  useEffect(() => {
    if (user) {
      fetchWhitelistedHotels();
    }
  }, [user]);

  useEffect(() => {
    let isMounted = true;
    const fetchData = async () => {
      try {
        setLoading(true);
        const routesRes = await fetch(`${API_BASE_URL}/api/routes`);
        const routes = await routesRes.json();
        const hotelRes = await fetch(`${routes.hotelsFilterByBounds}?hotelId=${id}`);
        const hotelJson = await hotelRes.json();
        const selectedHotel = hotelJson?.success && Array.isArray(hotelJson.hotels) && hotelJson.hotels.length
          ? hotelJson.hotels[0]
          : null;
        const roomsRes = await fetch(`${API_BASE_URL}/api/rooms/filter-by-bounds?hotelId=${id}`);
        const roomsJson = await roomsRes.json();
        let similarHotelsData = [];
        if (selectedHotel?.city_id) {
          try {
            const similarRes = await fetch(`${routes.hotelsFilterByBounds}?cityId=${selectedHotel.city_id}&limit=4`);
            const similarJson = await similarRes.json();
            if (similarJson?.success && Array.isArray(similarJson.hotels)) {
              similarHotelsData = similarJson.hotels
                .filter(h => h.id !== parseInt(id))
                .slice(0, 4);
            }
          } catch (error) {
          }
        }
        if (isMounted) {
          setHotel(selectedHotel);
          setRooms(Array.isArray(roomsJson?.rooms) ? roomsJson.rooms : []);
          setSimilarHotels(similarHotelsData);
          if (selectedHotel?.latitude && selectedHotel?.longitude) {
            calculateDistances(selectedHotel.latitude, selectedHotel.longitude);
          }
        }
      } catch (e) {
        if (isMounted) setError('Failed to load hotel details.');
      } finally {
        if (isMounted) setLoading(false);
      }
    };
    fetchData();
    return () => {
      isMounted = false;
    };
  }, [API_BASE_URL, id]);
  const galleryImages = useMemo(() => {
    const images = [];
    if (hotel?.hotel_galleries?.length) {
      hotel.hotel_galleries.forEach((img) => {
        if (img?.image) images.push(`/assets/img/hotel/hotel-gallery/${img.image}`);
      });
    }
    if (images.length === 0 && hotel?.logo) {
      images.push(`/assets/img/hotel/logo/${hotel.logo}`);
    }
    if (images.length === 0) {
      images.push('/images/room1.jpg');
    }
    return images;
  }, [hotel]);
  const locationText = useMemo(() => {
    const parts = [];
    if (hotel?.city_name) parts.push(hotel.city_name);
    if (hotel?.state_name) parts.push(hotel.state_name);
    if (hotel?.country_name) parts.push(hotel.country_name);
    return parts.join(', ');
  }, [hotel]);
  useEffect(() => {
    if (selectedRoom && selectedRoom.id) {
      if (typeof selectedRoom.adult === 'undefined' || selectedRoom.adult === null) {
        setAdult(1);
      } else {
        setAdult(Math.max(1, parseInt(selectedRoom.adult) || 1));
      }
      if (typeof selectedRoom.children === 'undefined' || selectedRoom.children === null) {
        setChildren(0);
      } else {
        setChildren(Math.max(0, parseInt(selectedRoom.children) || 0));
      }
      setSelectedPrice(null);
      setSelectedDuration('');
      setSelectedHourId(null);
      setHourlyPrices([]);
    }
  }, [selectedRoom]);
  const handleConfirmBooking = async (e) => {
    e.preventDefault();
    if (!selectedRoom || !selectedRoom.id) {
      setBookingError('Room information is missing. Please try again.');
      return;
    }
    if (!selectedPrice) {
      setBookingError('Please select a booking hour to proceed.');
      return;
    }
    if (!checkInDate || !checkInTime || !adult) {
      setBookingError('Please fill in all required fields.');
      return;
    }
    if (isNaN(adult) || isNaN(children)) {
      setBookingError('Invalid attendee numbers. Please try again.');
      return;
    }
    setIsSubmitting(true);
    setBookingError(null);
    setBookingSuccess(false);
    try {
      const API_BASE_URL =
        window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
          ? import.meta.env.VITE_API_BASE_URL_LOCAL
          : import.meta.env.VITE_API_BASE_URL;
      const requestBody = {
        room_id: selectedRoom.id,
        price: `${selectedHourId}-${selectedPrice}`,
        checkInDate: checkInDate,
        checkInTime: checkInTime,
        adult: parseInt(adult) || 1,
        children: parseInt(children) || 0
      };
      const response = await fetch(`${API_BASE_URL}/api/room/check-checkout`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: JSON.stringify(requestBody)
      });
      const data = await response.json();
      if (response.ok) {
        setBookingSuccess(true);
        const bookingData = {
          room_id: selectedRoom.id,
          hour_id: selectedHourId,
          price: selectedPrice,
          checkInDate: checkInDate,
          checkInTime: checkInTime,
          adult: parseInt(adult) || 1,
          children: parseInt(children) || 0,
          timestamp: Date.now()
        };
        localStorage.setItem('bookingData', JSON.stringify(bookingData));
        setTimeout(() => {
          window.location.href = '/checkout';
        }, 1500);
      } else {
        if (data.errors) {
          const errorMessages = Object.values(data.errors).flat();
          setBookingError(errorMessages.join(', '));
        } else {
          setBookingError(data.message || 'An error occurred during booking. Please try again.');
        }
      }
    } catch (error) {
      if (error.name === 'TypeError' && error.message.includes('fetch')) {
        setBookingError('Network error: Unable to connect to server. Please check if Laravel is running.');
      } else if (error.name === 'SyntaxError') {
        setBookingError('Server response error: Invalid JSON received from server.');
      } else {
        setBookingError(`Network error: ${error.message}. Please check your connection and try again.`);
      }
    } finally {
      setIsSubmitting(false);
    }
  };
  if (loading) {
    return (
      <div className="bg-[#F3F9FF] min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 -2 lue-600"></div>
      </div>
    );
  }
  if (error || !hotel) {
    return (
      <div className="bg-[#F3F9FF] min-h-screen flex items-center justify-center">
        <div className="text-center text-gray-700">
          <p className="font-semibold mb-2">{error || 'Hotel not found'}</p>
          <Link to="/" className="text-blue-600 underline">Go back</Link>
        </div>
      </div>
    );
  }
  return (
    <>
      <Header bgColor="bg-black" />
      <div className="bg-white min-h-screen pt-14">
        <div className="max-w-6xl mx-auto px-0 sm:px-6 lg:px-8 py-4 sm:py-6">
          <div className="flex items-center gap-2 text-sm text-gray-600 mb-4 px-4 sm:px-0">
            <Link
              to="/"
              className="hover:text-black capitalize flex items-center gap-1 font-semibold text-base sm:text-lg lg:text-xl"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth="2.5" 
                stroke="currentColor"
                className="w-4 h-4"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M10.5 19.5 3 12m0 0 7.5-7.5M3 12h18"
                />
              </svg>
              <span className="hidden sm:inline">Back</span>
              <span className="sm:hidden">Back</span>
            </Link>
          </div>

          <div className="sm:hidden px-4 mb-4">
            <div 
              className="relative w-full h-80 rounded-[10px] overflow-hidden"
              onTouchStart={handleTouchStart}
              onTouchMove={handleTouchMove}
              onTouchEnd={handleTouchEnd}
            >
              {galleryImages.length > 0 ? (
                <>
                  <img
                    src={galleryImages[currentImageIndex]}
                    alt={`${hotel?.title || 'Hotel'} - Image ${currentImageIndex + 1}`}
                    className="w-full h-full object-cover"
                    onError={(e) => { e.currentTarget.src = '/images/room1.jpg'; }}
                  />
                  
                  {galleryImages.length > 1 && (
                    <>
                      <button
                        onClick={prevImage}
                        className="absolute left-2 top-1/2 transform -translate-y-1/2 bg-black/50 hover:bg-black/70 text-white p-2 rounded-full transition-colors duration-200"
                        aria-label="Previous image"
                      >
                        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                        </svg>
                      </button>
                      <button
                        onClick={nextImage}
                        className="absolute right-2 top-1/2 transform -translate-y-1/2 bg-black/50 hover:bg-black/70 text-white p-2 rounded-full transition-colors duration-200"
                        aria-label="Next image"
                      >
                        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                        </svg>
                      </button>
                    </>
                  )}
                  
                  <div className="absolute bottom-2 right-2 bg-black/50 text-white px-2 py-1 rounded-full text-xs">
                    {currentImageIndex + 1} / {galleryImages.length}
                  </div>
                  
                  <div 
                    className="absolute top-2 right-2 bg-black/50 hover:bg-black/70 text-white px-3 py-1 rounded-full cursor-pointer transition-colors duration-200 text-sm"
                    onClick={() => {
                      setSelectedMainImage(0);
                      setShowAllHotelImagesModal(true);
                    }}
                  >
                    Show all
                  </div>
                </>
              ) : (
                <div className="w-full h-full bg-gray-200 flex items-center justify-center">
                  <span className="text-gray-500">No images available</span>
                </div>
              )}
            </div>
            
            {galleryImages.length > 1 && (
              <div className="flex justify-center mt-4 space-x-2">
                {galleryImages.map((_, index) => (
                  <button
                    key={index}
                    onClick={() => goToImage(index)}
                    className={`w-2 h-2 rounded-full transition-colors duration-200 ${
                      index === currentImageIndex ? 'bg-black' : 'bg-gray-300'
                    }`}
                    aria-label={`Go to image ${index + 1}`}
                  />
                ))}
              </div>
            )}
          </div>

          <div className="hidden sm:grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-2 sm:gap-4 px-4 sm:px-0">
            <div className="w-full h-56 md:h-72 lg:h-80 rounded-[10px] overflow-hidden">
              <img
                src={galleryImages[0] || '/images/room1.jpg'}
                alt={hotel?.title || 'Hotel cover'}
                className="w-full h-full object-cover"
                onError={(e) => { e.currentTarget.src = '/images/room1.jpg'; }}
              />
            </div>
            
            <div className="w-full h-56 md:h-72 lg:h-80 rounded-[10px] overflow-hidden grid grid-rows-2 gap-2">
              <img
                src={galleryImages[1] || galleryImages[0] || '/images/room1.jpg'}
                alt={hotel?.title || 'Hotel image'}
                className="w-full h-full object-cover"
                onError={(e) => { e.currentTarget.src = '/images/room1.jpg'; }}
              />
              <img
                src={galleryImages[2] || galleryImages[0] || '/images/room1.jpg'}
                alt={hotel?.title || 'Hotel image'}
                className="w-full h-full object-cover"
                onError={(e) => { e.currentTarget.src = '/images/room1.jpg'; }}
              />
            </div>
            
            <div className="w-full h-56 md:h-72 lg:h-80 rounded-[10px] overflow-hidden grid grid-rows-2 gap-2">
              <img
                src={galleryImages[3] || galleryImages[0] || '/images/room1.jpg'}
                alt={hotel?.title || 'Hotel image'}
                className="w-full h-full object-cover"
                onError={(e) => { e.currentTarget.src = '/images/room1.jpg'; }}
              />
              <div className="relative w-full h-full">
                <img
                  src={galleryImages[4] || galleryImages[0] || '/images/room1.jpg'}
                  alt={hotel?.title || 'Hotel image'}
                  className="w-full h-full object-cover"
                  onError={(e) => { e.currentTarget.src = '/images/room1.jpg'; }}
                />
                                  <button
                    type="button"
                    className="absolute bottom-2 right-2 bg-black/60 hover:bg-black/70 text-white px-3 py-1 rounded-lg text-xs sm:text-sm cursor-pointer transition-colors"
                    onClick={() => {
                      setSelectedMainImage(0);
                      setShowAllHotelImagesModal(true);
                    }}
                    aria-label="Show all images"
                  >
                    Show All
                  </button>
              </div>
            </div>
          </div>
          <div className="gap-4 sm:gap-6 mt-4 sm:mt-6 px-4 sm:px-0">
            <div className="lg:col-span-2 space-y-4 sm:space-y-6">
              <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 sm:gap-6">
                <div className="flex-1">
                  <div className="flex items-center justify-between gap-2 sm:gap-4 mb-2">
                    <h1 className="text-xl sm:text-2xl lg:text-[28px] font-semibold">{hotel?.title || 'Venue'}</h1>
                    <div className="sm:hidden flex items-center gap-2">
                      <span className="text-lg font-bold text-gray-900">${hotel.min_price}</span>
                      <span className="text-xs text-gray-500">Min price</span>
                    </div>
                  </div>
                  <div className="flex items-center justify-between gap-2 sm:gap-4">
                    <p className="text-gray-600 text-sm sm:text-base">{locationText || 'Location not available'}</p>
                    <button
                      onClick={() => {
                        setShowRoomSelectionModal(true);
                      }}
                      className="sm:hidden bg-black text-white px-4 py-2 rounded-lg hover:bg-gray-800 transition text-sm"
                    >
                      Select room
                    </button>
                  </div>
                </div>
                <div className="hidden sm:flex flex-col sm:flex-row items-start sm:items-center gap-3 sm:gap-4">
                  <div className="text-left sm:text-right">
                    <h1 className="text-lg sm:text-xl lg:text-[20px] font-bold text-gray-900">
                      ${hotel.min_price}
                    </h1>
                    <p className="text-xs sm:text-sm text-gray-500">Min price</p>
                  </div>
                  <button
                    onClick={() => {
                      setShowRoomSelectionModal(true);
                    }}
                    className="bg-black text-white px-4 py-2 rounded-lg hover:bg-gray-800 transition text-sm sm:text-base"
                  >
                    Select room
                  </button>
                </div>
              </div>
              <div className="bg-white rounded-[10px]  ">
                <div className="flex items-center gap-3 sm:gap-6 overflow-x-auto pb-2 scrollbar-hide">
                  {(() => {
                    let hotelAmenities = [];
                    let amenityIcons = [];
                    if (hotel?.amenity_details && hotel.amenity_details.length > 0) {
                      hotelAmenities = hotel.amenity_details.map(a => a.title);
                      amenityIcons = hotel.amenity_details.map(a => a.icon);
                    } else if (hotel?.amenity_names && hotel?.amenity_icons) {
                      hotelAmenities = hotel.amenity_names;
                      amenityIcons = hotel.amenity_icons;
                    } else if (hotel?.amenities && Array.isArray(hotel.amenities)) {
                      hotelAmenities = hotel.amenities.map(a => a.title || a.name);
                      amenityIcons = hotel.amenities.map(a => a.icon);
                    } else if (hotel?.amenity_names) {
                      hotelAmenities = hotel.amenity_names;
                      amenityIcons = hotel.amenity_names.map(() => 'fas fa-check');
                    }
                    const amenitiesWithIcons = hotelAmenities.map((amenity, index) => ({
                      name: amenity,
                      icon: amenityIcons[index] || 'fas fa-check'
                    }));
                    const finalAmenities = showAllAmenities ? amenitiesWithIcons : amenitiesWithIcons.slice(0, 7);
                    return finalAmenities.map((amenity, index) => (
                      <React.Fragment key={index}>
                        <div className="flex flex-col items-center gap-2 min-w-[70px] sm:min-w-[80px]">
                          <div className="w-6 h-6 sm:w-8 sm:h-8 flex items-center justify-center">
                            <i className={`${amenity.icon} text-gray-600 text-lg sm:text-xl`}></i>
                          </div>
                          <span className="text-xs text-gray-700 text-center leading-tight">{amenity.name}</span>
                        </div>
                        {index < finalAmenities.length - 1 && (
                          <div className="w-px h-6 sm:h-8 bg-gray-300"></div>
                        )}
                      </React.Fragment>
                    ));
                  })()}
                  <div
                    className="flex items-center gap-2 text-purple-500 hover:text-purple-700 cursor-pointer min-w-[120px] sm:min-w-[140px]"
                    onClick={() => {
                      if (showAllAmenities) {
                        setShowAllAmenities(false);
                      } else {
                        document.getElementById('popular-facilities-section')?.scrollIntoView({ behavior: 'smooth' });
                      }
                    }}
                  >
                    <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6-6-1.41-1.41z" />
                    </svg>
                    <span className="text-xs sm:text-sm underline">
                      {showAllAmenities ? 'Show less' : 'Show all'}
                    </span>
                  </div>
                </div>
              </div>
              <div className="flex flex-col sm:flex-row gap-3 sm:gap-4 mt-4">
                <div className="flex items-center gap-3 text-sm text-black bg-[#F0F0F0] px-3 sm:px-4 py-3 rounded-lg shadow-md w-full sm:w-auto sm:min-w-[300px] lg:min-w-[384px]">
                  {typeof hotel?.average_rating !== 'undefined' && (
                    <span className="bg-black text-white font-semibold text-xl sm:text-2xl lg:text-[30px] px-2 sm:px-3 py-2 sm:py-3 rounded">
                      {Number(hotel.stars || 0).toFixed(1)}
                    </span>
                  )}
                  {hotel?.stars && (
                    <span className="flex items-center gap-1">
                      {[...Array(Number(hotel.stars))].map((_, i) => (
                        <svg
                          key={i}
                          className="w-3 h-3 sm:w-4 sm:h-4 text-yellow-400"
                          fill="currentColor"
                          viewBox="0 0 20 20"
                        >
                          <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.286 3.957a1 1 0 00.95.69h4.164c.969 0 1.371 1.24.588 1.81l-3.37 2.448a1 1 0 00-.364 1.118l1.286 3.957c.3.921-.755 1.688-1.538 1.118l-3.37-2.448a1 1 0 00-1.175 0l-3.37 2.448c-.783.57-1.838-.197-1.538-1.118l1.286-3.957a1 1 0 00-.364-1.118L2.07 9.384c-.783-.57-.38-1.81.588-1.81h4.165a1 1 0 00.95-.69l1.286-3.957z" />
                        </svg>
                      ))}
                    </span>
                  )}
                  {typeof hotel?.hotel_reviews_count !== 'undefined' && (
                    <span className="text-gray-700 text-xs sm:text-sm">
                      {hotel.hotel_reviews_count} Reviews
                    </span>
                  )}
                  <a
                    href="#reviews-section"
                    className="text-blue-500 hover:underline ml-auto text-xs cursor-pointer"
                    onClick={(e) => {
                      e.preventDefault();
                      document.getElementById('reviews-section')?.scrollIntoView({ behavior: 'smooth' });
                    }}
                  >
                    Show all reviews
                  </a>
                </div>
                <div className="flex items-center gap-3 text-sm text-black bg-[#F0F0F0] px-3 sm:px-4 py-3 rounded-lg shadow-md w-full sm:w-auto sm:min-w-[300px] lg:min-w-[384px]">
                  <span className="bg-black text-white p-2 sm:p-3 rounded">
                    <svg
                      className="w-4 h-4 sm:w-5 sm:h-5"
                      fill="currentColor"
                      viewBox="0 0 20 20"
                    >
                      <path d="M10 2C6.686 2 4 4.686 4 8c0 4.418 6 10 6 10s6-5.582 6-10c0-3.314-2.686-6-6-6zM10 10.5A2.5 2.5 0 1 1 10 5.5a2.5 2.5 0 0 1 0 5z" />
                    </svg>
                  </span>
                  <div className="flex-1 min-w-0">
                    <p className="font-medium text-xs sm:text-sm truncate">
                      {locationText || 'Address not available'}
                    </p>
                    <a
                      href="#location-section"
                      className="text-blue-500 hover:underline text-xs cursor-pointer"
                      onClick={(e) => {
                        e.preventDefault();
                        document.getElementById('location-section')?.scrollIntoView({ behavior: 'smooth' });
                      }}
                    >
                      View location
                    </a>
                  </div>
                </div>
              </div>
              <div className='mt-5' >
                <h1 className='text-xl sm:text-2xl lg:text-[32px] font-semibold'>Hotel amenties & information</h1>
                <div className='mt-3'>
                  <div id="popular-facilities-section"
                    dangerouslySetInnerHTML={{ __html: hotel?.description || '' }}
                    className='text-gray-700 leading-relaxed text-sm sm:text-base'
                  />
                </div>
              </div>
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-4 sm:gap-6 mt-4 sm:mt-6">
                <div  className="bg-white rounded-[10px]  ">
                  <h2 className="text-lg sm:text-xl lg:text-[22px] font-semibold mb-4">Most popular facilities</h2>
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                    {(() => {
                      let hotelAmenities = [];
                      let amenityIcons = [];
                      if (hotel?.amenity_details && hotel.amenity_details.length > 0) {
                        hotelAmenities = hotel.amenity_details.map(a => a.title);
                        amenityIcons = hotel.amenity_details.map(a => a.icon);
                      } else if (hotel?.amenity_names && hotel?.amenity_icons) {
                        hotelAmenities = hotel.amenity_names;
                        amenityIcons = hotel.amenity_icons;
                      } else if (hotel?.amenities && Array.isArray(hotel.amenities)) {
                        hotelAmenities = hotel.amenities.map(a => a.title || a.name);
                        amenityIcons = hotel.amenities.map(a => a.icon);
                      } else if (hotel?.amenity_names) {
                        hotelAmenities = hotel.amenity_names;
                        amenityIcons = hotel.amenity_names.map(() => 'fas fa-check');
                      }
                      const popularAmenities = hotelAmenities.slice(0, 8);
                      return popularAmenities.map((amenity, index) => (
                        <div key={index} className="flex items-center gap-3 p-2 sm:p-3">
                          <div className="w-5 h-5 sm:w-6 sm:h-6 flex items-center justify-center">
                            <i className={`${amenityIcons[index] || 'fas fa-check'} text-sm`}></i>
                          </div>
                          <span className="text-xs sm:text-sm text-gray-700">{amenity}</span>
                        </div>
                      ));
                    })()}
                  </div>
                </div>
                <div className="bg-white rounded-[10px] p-4">
                  <h2 className="text-lg sm:text-xl lg:text-[22px] font-semibold mb-4">Free for HRS guests</h2>
                  <div className="space-y-3">
                    <div className="flex items-center gap-3 p-2 sm:p-3">
                      <i className="fas fa-wifi text-sm sm:text-[16px]"></i>
                      <span className="text-gray-700 font-medium text-sm sm:text-base">Wi-Fi</span>
                    </div>
                    <div className="flex items-center gap-3 p-2 sm:p-3">
                      <i className="fas fa-parking text-sm sm:text-[16px]"></i>
                      <span className="text-gray-700 font-medium text-sm sm:text-base">Parking</span>
                    </div>
                  </div>
                </div>
              </div>
              <h2 className="text-lg sm:text-xl lg:text-[22px] font-semibold mb-4">Hotel information</h2>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6 mt-4 sm:mt-6">
                <div className="bg-white rounded-[10px] p-4 ">
                  <h2 className="text-base sm:text-lg lg:text-[18px] font-semibold mb-4">Hotel information</h2>
                  <div className="space-y-3">
                    <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-1 sm:gap-0">
                      <span className="text-gray-600 text-xs sm:text-sm">Reception:</span>
                      <span className="text-gray-800 font-medium text-xs sm:text-sm">occupied 24 hours a day</span>
                    </div>
                    <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-1 sm:gap-0">
                      <span className="text-gray-600 text-xs sm:text-sm">Reception manned at weekends:</span>
                      <span className="text-gray-800 font-medium text-xs sm:text-sm">occupied 24 hours a day</span>
                    </div>
                    <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-1 sm:gap-0">
                      <span className="text-gray-600 text-xs sm:text-sm">Earliest check-in:</span>
                      <span className="text-gray-800 font-medium text-xs sm:text-sm">
                        {hotel?.check_in_time || '10:00 AM'}
                      </span>
                    </div>
                    <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-1 sm:gap-0">
                      <span className="text-gray-600 text-xs sm:text-sm">Latest Check-out:</span>
                      <span className="text-gray-800 font-medium text-xs sm:text-sm">
                        {hotel?.check_out_time || '06:30 PM'}
                      </span>
                    </div>
                  </div>
                </div>
                <div className="bg-white rounded-[10px]  ">
                  <h2 className="text-base sm:text-lg lg:text-[18px] font-semibold mb-4">Spoken languages</h2>
                  <div className="space-y-3">
                    <div className="flex items-center">
                      <span className="text-gray-700 text-xs sm:text-sm">Multilingual staff on hand 24 hours a day</span>
                    </div>
                  </div>
                </div>
                <div className="bg-white rounded-[10px]  ">
                  <h2 className="text-base sm:text-lg lg:text-[18px] font-semibold mb-4">Payment options</h2>
                  <div className="space-y-3">
                    <div className="flex items-center gap-3">
                      <i className="fab fa-cc-visa text-blue-600 text-base sm:text-lg"></i>
                      <span className="text-gray-700 text-xs sm:text-sm">Visa</span>
                    </div>
                    <div className="flex items-center gap-3">
                      <i className="fab fa-cc-mastercard text-red-600 text-base sm:text-lg"></i>
                      <span className="text-gray-700 text-xs sm:text-sm">Master Card</span>
                    </div>
                    <div className="flex items-center gap-3">
                      <i className="fas fa-file-invoice-dollar text-green-600 text-base sm:text-lg"></i>
                      <span className="text-gray-700 text-xs sm:text-sm">Billing to corporate account possible</span>
                    </div>
                  </div>
                </div>
              </div>
              <div className="bg-white rounded-[10px]  ">
                <h2 className="text-xl sm:text-2xl lg:text-[32px] font-semibold mb-4">Available Rooms</h2>
                <div className="space-y-4">
                  {rooms.length === 0 && (
                    <p className="text-sm text-gray-500">No rooms found for this venue.</p>
                  )}
                  {rooms.map((room) => (
                    <div key={room.id} className="flex flex-col sm:flex-row items-start sm:items-center gap-3 sm:gap-4 border rounded-[10px] p-3 sm:p-4">
                      <div className="relative flex-shrink-0">
                        <img
                          src={room?.feature_image ? `/assets/img/room/featureImage/${room.feature_image}` : '/images/room1.jpg'}
                          alt={room.title}
                          className="w-20 h-20 sm:w-24 sm:h-24 object-cover rounded-lg cursor-pointer hover:opacity-90 transition-opacity duration-200"
                          onClick={() => {
                            setSelectedRoom(room);
                            setShowImageGalleryModal(true);
                          }}
                          onError={(e) => { e.currentTarget.src = '/images/room1.jpg'; }}
                        />
                        

                      </div>
                      <div className="flex-1 min-w-0">
                        <h3 className="font-semibold mb-2 text-sm sm:text-base">{room.title}</h3>
                        <div className="flex flex-col sm:flex-row sm:items-center gap-2 sm:gap-6 text-xs sm:text-sm text-gray-600 mb-3">
                          <span className="flex items-center gap-2">
                            <i className="fas fa-users text-gray-400"></i>
                            <span>{room.adult} Adults</span>
                          </span>
                          {room.children > 0 && (
                            <span className="flex items-center gap-2">
                              <i className="fas fa-child text-gray-400"></i>
                              <span>{room.children} Children</span>
                            </span>
                          )}
                          {room.two_hour_price && (
                            <span className="flex items-center gap-2">
                              <i className="fas fa-dollar-sign text-gray-400"></i>
                              <span>From {room.two_hour_price}/2h</span>
                            </span>
                          )}
                        </div>
                        {room.amenity_details && room.amenity_details.length > 0 ? (
                          <div className="mb-3">
                            <div className="flex flex-wrap gap-2">
                              {room.amenity_details.slice(0, 4).map((amenity, index) => (
                                <span key={amenity.id || index} className="inline-flex items-center gap-1 px-2 py-1 bg-blue-100 text-blue-800 text-xs rounded-full">
                                  <i className={`${amenity.icon} text-grey-600`}></i>
                                  <span>{amenity.title}</span>
                                </span>
                              ))}
                              {room.amenity_details.length > 4 && (
                                <span className="inline-flex items-center px-2 py-1 bg-gray-100 text-gray-600 text-xs rounded-full">
                                  +{room.amenity_details.length - 4} more
                                </span>
                              )}
                            </div>
                          </div>
                        ) : room.amenities ? (
                          <div className="mb-3">
                            <h4 className="text-xs sm:text-sm font-medium text-gray-700 mb-2">Amenities:</h4>
                            <div className="flex flex-wrap gap-2">
                              {(() => {
                                try {
                                  const amenityIds = JSON.parse(room.amenities);
                                  return amenityIds.slice(0, 4).map((amenityId, index) => (
                                    <span key={index} className="inline-flex items-center gap-1 px-2 py-1 bg-blue-100 text-blue-800 text-xs rounded-full">
                                      <i className="fas fa-check text-blue-600"></i>
                                      <span>Amenity {index + 1}</span>
                                    </span>
                                  ));
                                } catch (e) {
                                  return null;
                                }
                              })()}
                              {(() => {
                                try {
                                  const amenityIds = JSON.parse(room.amenities);
                                  if (amenityIds.length > 4) {
                                    return (
                                      <span className="inline-flex items-center px-2 py-1 bg-gray-100 text-gray-600 text-xs rounded-full">
                                        +{amenityIds.length - 4} more
                                      </span>
                                    );
                                  }
                                } catch (e) {
                                  return null;
                                }
                                return null;
                              })()}
                            </div>
                          </div>
                        ) : null}
                      </div>
                      <div className="text-left sm:text-right w-full sm:w-auto">
                        {room.two_hour_price && (
                          <div className="font-semibold text-gray-900 text-sm sm:text-base mb-2 sm:mb-0">
                            {room.two_hour_price}
                          </div>
                        )}
                        <button
                          onClick={() => {
                            setSelectedRoom(room);
                            setShowBookingModal(true);
                          }}
                          className="w-full sm:w-auto mt-2 inline-block bg-black text-white px-3 sm:px-4 py-2 rounded-lg hover:bg-gray-800 transition text-sm sm:text-base"
                        >
                          Book now
                        </button>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
          <div id="location-section" className="bg-white rounded-[10px]   mt-4 sm:mt-6 mx-4 sm:mx-0">
            <h2 className="text-lg sm:text-xl font-semibold mb-4">Location and distances</h2>
            <div className="mb-4">
              <a
                href={`https://maps.google.com/?q=${encodeURIComponent(`${hotel?.latitude},${hotel?.longitude}`)}`}
                target="_blank"
                rel="noopener noreferrer"
                className="text-blue-500 hover:underline font-medium text-sm sm:text-base"
              >
                Open in Google Maps
              </a>
              {(hotel?.latitude && hotel?.longitude) && (
                <div className="mt-4 sm:mt-6 bg-white rounded-[10px] overflow-hidden">
                  <iframe
                    title="location-map"
                    src={`https://www.google.com/maps?q=${hotel.latitude},${hotel.longitude}&z=14&output=embed`}
                    className="w-full h-[300px] sm:h-[400px] lg:h-[545px]"
                    loading="lazy"
                    referrerPolicy="no-referrer-when-downgrade"
                  />
                </div>
              )}
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3 sm:gap-4 mb-4">
              <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
                <i className="fas fa-plane text-blue-500 text-lg sm:text-xl"></i>
                <div>
                  <span className="text-xs sm:text-sm text-gray-600">Airport</span>
                  <p className="text-gray-800 font-medium text-sm sm:text-base">
                    {distances.airport ? `${distances.airport} km` : 'Calculating...'}
                  </p>
                </div>
              </div>
              <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
                <i className="fas fa-train text-green-500 text-lg sm:text-xl"></i>
                <div>
                  <span className="text-xs sm:text-sm text-gray-600">Railway station</span>
                  <p className="text-gray-800 font-medium text-sm sm:text-base">
                    {distances.railway ? `${distances.railway} km` : 'Calculating...'}
                  </p>
                </div>
              </div>
              <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg sm:col-span-2 lg:col-span-1">
                <i className="fas fa-city text-purple-500 text-lg sm:text-xl"></i>
                <div>
                  <span className="text-xs sm:text-sm text-gray-600">City center</span>
                  <p className="text-gray-800 font-medium text-sm sm:text-base">
                    {distances.cityCenter ? `${distances.cityCenter} km` : 'Calculating...'}
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div id="reviews-section" className="bg-white rounded-[10px]   mt-4 sm:mt-6 mx-4 sm:mx-0">
            <h2 className="text-lg sm:text-xl font-semibold mb-4">Ratings and reviews</h2>
            <div className="flex flex-col sm:flex-row items-center gap-4 sm:gap-6 mb-4 sm:mb-6 p-4 bg-gray-50 rounded-lg">
              <div className="text-center">
                <div className="text-2xl sm:text-3xl font-bold text-blue-600">
                  {hotel?.average_rating ? Number(hotel.average_rating).toFixed(1) : hotel?.stars ? Number(hotel.stars).toFixed(1) : 'N/A'}
                </div>
                <div className="text-xs sm:text-sm text-gray-600">Overall Rating</div>
                {hotel?.stars && (
                  <div className="flex items-center justify-center gap-1 mt-1">
                    {[...Array(5)].map((_, i) => (
                      <svg
                        key={i}
                        className={`w-3 h-3 sm:w-4 sm:h-4 ${i < Number(hotel.stars) ? 'text-yellow-400' : 'text-gray-300'}`}
                        fill="currentColor"
                        viewBox="0 0 20 20"
                      >
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.286 3.957a1 1 0 00.95.69h4.164c.969 0 1.371 1.24.588 1.81l-3.37 2.448a1 1 0 00-.364 1.118l1.286 3.957c.3.921-.755 1.688-1.538 1.118l-3.37-2.448a1 1 0 00-1.175 0l-3.37 2.448c-.783.57-1.838-.197-1.538-1.118l1.286-3.957a1 1 0 00-.364-1.118L2.07 9.384c-.783-.57-.38-1.81.588-1.81h4.165a1 1 0 00.95-.69l1.286-3.957z" />
                      </svg>
                    ))}
                  </div>
                )}
              </div>
              <div className="flex-1 w-full sm:w-auto">
                <div className="text-xs sm:text-sm text-gray-600 mb-2">
                  Based on {hotel?.hotel_reviews_count || 0} reviews
                </div>
                {hotel?.hotel_reviews_count > 0 && (
                  <div className="space-y-2">
                    {[5, 4, 3, 2, 1].map((rating) => (
                      <div key={rating} className="flex items-center gap-2">
                        <span className="text-xs text-gray-600 w-4">{rating}★</span>
                        <div className="flex-1 bg-gray-200 rounded-full h-2">
                          <div
                            className="bg-blue-500 h-2 rounded-full"
                            style={{
                              width: `${hotel?.hotel_reviews_count ? Math.random() * 100 : 0}%`
                            }}
                          ></div>
                        </div>
                        <span className="text-xs text-gray-500 w-8">
                          {hotel?.hotel_reviews_count ? Math.floor(Math.random() * hotel.hotel_reviews_count) : 0}
                        </span>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            </div>
            <div className="flex flex-col sm:flex-row flex-wrap gap-3 sm:gap-4 mb-4 sm:mb-6 p-3 sm:p-4 bg-gray-50 rounded-lg">
              <div className="flex items-center gap-2">
                <i className="fas fa-filter text-gray-600"></i>
                <span className="text-gray-700 text-sm">Filtering</span>
              </div>
              <select className="px-3 py-2 border border-gray-300 rounded-lg text-xs sm:text-sm w-full sm:w-auto">
                <option>Recommended</option>
                <option>Most Recent</option>
                <option>Highest Rated</option>
                <option>Lowest Rated</option>
              </select>
              <select className="px-3 py-2 border border-gray-300 rounded-lg text-xs sm:text-sm w-full sm:w-auto">
                <option>All Traveler Types</option>
                <option>Business</option>
                <option>Leisure</option>
                <option>Family</option>
              </select>
              <select className="px-3 py-2 border border-gray-300 rounded-lg text-xs sm:text-sm w-full sm:w-auto">
                <option>All Ratings</option>
                <option>5 Stars</option>
                <option>4+ Stars</option>
                <option>3+ Stars</option>
              </select>
              <input
                type="text"
                placeholder="Search reviews..."
                className="px-3 py-2 border border-gray-300 rounded-lg text-xs sm:text-sm w-full sm:w-auto"
              />
            </div>
            <div className="space-y-4">
              {hotel?.hotel_reviews_count > 0 ? (
                <>
                  <div className="border-b border-gray-200 pb-4">
                    <div className="flex items-center justify-between mb-2">
                      <h4 className="font-medium text-gray-800">
                        {hotel?.title ? `Great experience at ${hotel.title}` : ''}
                      </h4>
                      <div className="flex items-center gap-1">
                        {[...Array(5)].map((_, i) => (
                          <svg
                            key={i}
                            className={`w-4 h-4 ${i < Number(hotel.stars || 4) ? 'text-yellow-400' : 'text-gray-300'}`}
                            fill="currentColor"
                            viewBox="0 0 20 20"
                          >
                            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.286 3.957a1 1 0 00.95.69h4.164c.969 0 1.371 1.24.588 1.81l-3.37 2.448a1 1 0 00-.364 1.118l1.286 3.957c.3.921-.755 1.688-1.538 1.118l-3.37-2.448a1 1 0 00-1.175 0l-3.37 2.448c-.783.57-1.838-.197-1.538-1.118l1.286-3.957c.3.921-.755 1.688-1.538 1.118l-3.37-2.448a1 1 0 00-.364-1.118L2.07 9.384c-.783-.57-.38-1.81.588-1.81h4.165a1 1 0 00.95-.69l1.286-3.957z" />
                          </svg>
                        ))}
                      </div>
                    </div>
                    <p className="text-gray-600 text-sm mb-2">
                      {hotel?.city_name ? `By Guest from ${hotel.city_name} on ${new Date().toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' })}` : ''}
                    </p>
                    <p className="text-gray-700">
                      {hotel?.description ?
                        `${hotel.description.substring(0, 150)}...` :
                        ''
                      }
                    </p>
                  </div>
                  <div className="border-b border-gray-200 pb-4">
                    <div className="flex items-center justify-between mb-2">
                      <h4 className="font-medium text-gray-800">
                        {hotel?.categoryName ? `Perfect for ${hotel.categoryName}` : ''}
                      </h4>
                      <div className="flex items-center gap-1">
                        {hotel?.state_name ? [...Array(5)].map((_, i) => (
                          <svg
                            key={i}
                            className={`w-4 h-4 ${i < 5 ? 'text-yellow-400' : 'text-gray-300'}`}
                            fill="currentColor"
                            viewBox="0 0 20 20"
                          >
                            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.286 3.957a1 1 0 00.95.69h4.164c.969 0 1.371 1.24.588 1.81l-3.37 2.448a1 1 0 00-.364 1.118l1.286 3.957c.3.921-.755 1.688-1.538 1.118l-3.37-2.448a1 1 0 00-1.175 0l-3.37 2.448c-.783.57-1.838-.197-1.538-1.118l1.286-3.957c.3.921-.755 1.688-1.538 1.118l-3.37-2.448a1 1 0 00-.364-1.118L2.07 9.384c-.783-.57-.38-1.81.588-1.81h4.165a1 1 0 00.95-.69l1.286-3.957z" />
                          </svg>
                        )) : null}
                      </div>
                    </div>
                    <p className="text-gray-600 text-sm mb-2">
                      {hotel?.state_name ? `By Business Traveler from ${hotel.state_name} on ${new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' })}` : ''}
                    </p>
                    <p className="text-gray-700">
                    </p>
                  </div>
                  <button className="w-full mt-4 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">
                    Read all {hotel?.hotel_reviews_count || 0} reviews
                  </button>
                </>
              ) : (
                <div className="text-center py-8">
                  <p className="text-gray-500 mb-2">No reviews yet</p>
                  <p className="text-sm text-gray-400">Be the first to review this hotel</p>
                </div>
              )}
            </div>
          </div>
          <div className="bg-white rounded-[10px]   mt-4 sm:mt-6 mx-4 sm:mx-0">
            <h2 className="text-xl sm:text-2xl lg:text-[32px] font-semibold mb-4">Similar hotels in the area</h2>
            {similarHotels.length === 0 ? (
              <p className="text-gray-500 text-center py-8">No similar hotels found in this area.</p>
            ) : (
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-3 sm:gap-4">
                {similarHotels.map((similarHotel) => (
                  <div
                    key={similarHotel.id}
                    className="w-full h-auto min-h-[265px] rounded-xl shadow-xl bg-white overflow-hidden hover:shadow-2xl transition-shadow duration-300 cursor-pointer"
                    onClick={() => navigate(`/hotels/${similarHotel.id}`)}
                  >
                    <div className="relative">
                      <img
                        src={(() => {
                          if (similarHotel.hotel_galleries && similarHotel.hotel_galleries.length > 0) {
                            return `/assets/img/hotel/hotel-gallery/${similarHotel.hotel_galleries[0].image}`;
                          }
                          if (similarHotel.logo) {
                            return `/assets/img/hotel/logo/${similarHotel.logo}`;
                          }
                          return '/images/room1.jpg';
                        })()}
                        alt={similarHotel.title || similarHotel.name}
                        className="w-full h-[120px] sm:h-[133px] object-cover"
                        onError={(e) => {
                          e.target.src = '/images/room1.jpg';
                        }}
                      />
                      <button
                        onClick={(e) => toggleHotelWhitelist(similarHotel.id, e)}
                        className="absolute top-2 right-2 bg-white p-2 rounded-full shadow-md hover:shadow-lg transition-shadow duration-200 z-10"
                        title={whitelistedHotels.has(similarHotel.id) ? "Remove from favorites" : "Add to favorites"}
                      >
                        {whitelistedHotels.has(similarHotel.id) ? (
                          <FaHeart className="w-3 h-3 sm:w-4 sm:h-4 text-red-500" />
                        ) : (
                          <FaRegHeart className="w-3 h-3 sm:w-4 sm:h-4 text-gray-600 hover:text-red-500 transition-colors duration-200" />
                        )}
                      </button>
                      <div className="absolute bottom-0 right-0 bg-yellow-400 px-2 py-1 text-xs sm:text-sm font-bold">
                        ${similarHotel.min_price || similarHotel.price || 'N/A'}
                      </div>
                    </div>
                    <div className="p-3 sm:p-4 h-auto min-h-[132px] flex flex-col justify-between">
                      <div>
                        <h3 className="font-semibold text-base sm:text-lg mb-1 line-clamp-2">
                          {similarHotel.title || similarHotel.name}
                        </h3>
                        <p className="text-gray-500 text-xs sm:text-sm mb-2">
                          {similarHotel.categoryName || ''}
                        </p>
                        <div className="flex flex-col sm:flex-row sm:justify-between sm:items-center text-xs text-gray-600 mb-2 gap-1">
                          {similarHotel.total_rooms && (
                            <span className="mr-2">Rooms: {similarHotel.total_rooms}</span>
                          )}
                          {similarHotel.stars && (
                            <div className="flex items-center space-x-1">
                              <h1 className="text-xs sm:text-sm text-gray-600">{similarHotel.stars}</h1>
                              <div className="flex items-center">
                                {[...Array(Number(similarHotel.stars))].map((_, i) => (
                                  <svg
                                    key={i}
                                    className="w-3 h-3 sm:w-4 sm:h-4 text-yellow-400"
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
                        <div className="flex flex-wrap items-center text-xs text-gray-600 mb-2">
                          {similarHotel.city_name && (
                            <span className="">📍 {similarHotel.city_name},</span>
                          )}
                          {similarHotel.state_name && (
                            <span className="">{similarHotel.state_name},</span>
                          )}
                          {similarHotel.country_name && (
                            <span className="">{similarHotel.country_name}</span>
                          )}
                        </div>
                      </div>
                      <p className="text-xs sm:text-sm text-blue-800 font-semibold mt-2">
                      </p>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>
        {showBookingModal && selectedRoom && selectedRoom.id && (
          <div className="fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-50 p-2 sm:p-4">
            <div className="w-full max-w-[90vw] sm:max-w-[800px] lg:max-w-[1046px] shadow-xl bg-[#fff] max-h-[90vh] rounded-lg">
              <div className="flex items-center justify-between   p-4">
                <h2 className="text-lg sm:text-xl font-semibold">Book {selectedRoom.title || selectedRoom.name || 'Room'}</h2>
                <button
                  onClick={() => setShowBookingModal(false)}
                  className="w-6 h-6 sm:w-8 sm:h-8 bg-black text-white rounded-full flex items-center justify-center hover:bg-gray-800 transition"
                >
                  ×
                </button>
              </div>
              <div className="p-4  lg:p-8 bg-white overflow-y-auto max-h-[calc(90vh-80px)]">
                {process.env.NODE_ENV === 'development' && (
                  <div className="mb-4 p-3 bg-blue-100 border lue-400 text-blue-700 rounded text-xs">
                    <strong>Debug Info:</strong><br />
                    selectedRoom ID: {selectedRoom?.id}<br />
                    selectedRoom Title: {selectedRoom?.title}<br />
                    selectedRoom Adult: {selectedRoom?.adult} (type: {typeof selectedRoom?.adult})<br />
                    selectedRoom Children: {selectedRoom?.children} (type: {typeof selectedRoom?.children})<br />
                    adult state: {adult} (type: {typeof adult})<br />
                    children state: {children} (type: {typeof children})<br />
                    selectedPrice: {selectedPrice}<br />
                    checkInDate: {checkInDate}, checkInTime: {checkInTime}<br />
                    <br />
                    <strong>Full selectedRoom object:</strong><br />
                    <pre className="text-xs overflow-auto max-h-32">
                      {JSON.stringify(selectedRoom, null, 2)}
                    </pre>
                  </div>
                )}
                {!selectedRoom || !selectedRoom.id || typeof selectedRoom.adult === 'undefined' || typeof selectedRoom.children === 'undefined' ? (
                  <div className="text-center py-8">
                    <div className="animate-spin rounded-full h-8 w-8 -2 lue-600 mx-auto mb-4"></div>
                    <p className="text-gray-600">Loading room details...</p>
                    <p className="text-xs text-gray-500 mt-2">
                      Room ID: {selectedRoom?.id || 'undefined'}<br />
                      Adult: {selectedRoom?.adult !== undefined ? selectedRoom.adult : 'undefined'}<br />
                      Children: {selectedRoom?.children !== undefined ? selectedRoom.children : 'undefined'}
                    </p>
                    {process.env.NODE_ENV === 'development' && (
                      <details className="mt-4 text-left">
                        <summary className="cursor-pointer text-blue-600">Show Debug Info</summary>
                        <pre className="text-xs bg-gray-100 p-2 rounded mt-2 overflow-auto max-h-32">
                          {JSON.stringify(selectedRoom, null, 2)}
                        </pre>
                      </details>
                    )}
                  </div>
                ) : (
                  <form onSubmit={handleConfirmBooking} className="subscription">
                    <input type="hidden" name="room_id" value={selectedRoom.id} />
                    <div className="type-form mb-6">
                      <div className="search-container">
                        <h3 className="text-xl font-bold text-gray-900 mb-6">Book {selectedRoom?.name || 'Room'}</h3>
                        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3 sm:gap-4 mb-4 sm:mb-6">
                          <div className="form-group">
                            <label className="block text-xs sm:text-sm font-medium text-gray-700 mb-2">Date</label>
                            <input
                              type="date"
                              className="w-full px-3 sm:px-4 py-2 sm:py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors text-sm sm:text-base"
                              value={checkInDate}
                              onChange={(e) => {
                                const newDate = e.target.value;
                                setCheckInDate(newDate);
                                if (newDate && selectedRoom) {
                                  fetchAvailableTimeSlots(selectedRoom.id, newDate);
                                  setSelectedStartTime('');
                                  setSelectedEndTime('');
                                  setHourlyPrices([]);
                                }
                              }}
                            />
                          </div>
                          <div className="form-group">
                            <label className="block text-xs sm:text-sm font-medium text-gray-700 mb-2">Start time</label>
                            <select
                              className="w-full px-3 sm:px-4 py-2 sm:py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors text-sm sm:text-base"
                              value={checkInTime}
                              onChange={(e) => {
                                setCheckInTime(e.target.value);
                                if (e.target.value && selectedRoom && checkInDate) {
                                  fetchHourlyPrices(selectedRoom.id, checkInDate, e.target.value);
                                }
                              }}
                            >
                              <option value="">Select time</option>
                              {availableTimeSlots
                                .filter(slot => timeToMinutes(slot.start_time) >= timeToMinutes(selectedRoom?.check_in_time || '09:00'))
                                .map((slot, index) => (
                                  <option key={index} value={slot.start_time}>
                                    {slot.start_time}
                                  </option>
                                ))}
                            </select>
                          </div>
                          <div className="form-group">
                            <label className="block text-xs sm:text-sm font-medium text-gray-700 mb-2">End time</label>
                            <select
                              className="w-full px-3 sm:px-4 py-2 sm:py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors text-sm sm:text-base"
                              value={selectedEndTime}
                              onChange={(e) => setSelectedEndTime(e.target.value)}
                            >
                              <option value="">Select time</option>
                              {availableTimeSlots
                                .filter(slot => timeToMinutes(slot.end_time) <= timeToMinutes(selectedRoom?.check_out_time || '18:00'))
                                .map((slot, index) => (
                                  <option key={index} value={slot.end_time}>
                                    {slot.end_time}
                                  </option>
                                ))}
                            </select>
                          </div>
                        </div>
                        <div className="mb-4 sm:mb-6">
                          <label className="block text-xs sm:text-sm font-medium text-gray-700 mb-2">Select Duration</label>
                          {loadingPrices ? (
                            <div className="text-center py-4 sm:py-6">
                              <div className="animate-spin rounded-full h-6 w-6 sm:h-8 sm:w-8 -2 lue-600 mx-auto"></div>
                              <p className="text-xs sm:text-sm text-gray-500 mt-2">Loading pricing options...</p>
                            </div>
                          ) : hourlyPrices.length > 0 ? (
                            <select
                              className="w-full px-3 sm:px-4 py-2 sm:py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors text-sm sm:text-base"
                              value={selectedDuration ? `${selectedDuration}-${selectedPrice}` : ""}
                              onChange={(e) => {
                                if (e.target.value) {
                                  const [hourId, price] = e.target.value.split('-');
                                  setSelectedHourId(hourId);
                                  setSelectedDuration(hourId);
                                  setSelectedPrice(price);
                                }
                              }}
                            >
                              <option value="">Select duration</option>
                              {hourlyPrices
                                .filter(hourlyPrice => hourlyPrice.price && validateAndFormatPrice(hourlyPrice.price).isValid)
                                .map((hourlyPrice) => {
                                  const { isValid, formatted } = validateAndFormatPrice(hourlyPrice.price);
                                  return (
                                    <option
                                      key={hourlyPrice.hour_id}
                                      value={`${hourlyPrice.hour_id}-${hourlyPrice.price}`}
                                      disabled={!isValid}
                                    >
                                      {hourlyPrice.hour} Hours - ${formatted}
                                      {hourlyPrice.is_custom && ' (Custom)'}
                                    </option>
                                  );
                                })}
                            </select>
                          ) : (
                            <div className="text-center py-4 sm:py-6 border-2 border-dashed border-gray-300 rounded-lg">
                              <div className="text-gray-400 mb-2">
                                <i className="fas fa-calendar-times text-xl sm:text-2xl"></i>
                              </div>
                              <h6 className="text-gray-600 text-xs sm:text-sm font-medium">No pricing available</h6>
                              <p className="text-gray-500 text-xs mt-1">Please select a date and time first</p>
                            </div>
                          )}
                        </div>
                        <div className="mb-4 sm:mb-6">
                          <label className="block text-xs sm:text-sm font-medium text-gray-700 mb-2">Attendees</label>
                          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 sm:gap-4">
                            <div className="form-group">
                              <label className="block text-xs text-gray-500 mb-1">Total Adults</label>
                              <select
                                className="w-full px-3 sm:px-4 py-2 sm:py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors text-sm sm:text-base"
                                value={adult}
                                onChange={(e) => setAdult(parseInt(e.target.value))}
                              >
                                {(() => {
                                  try {
                                    const maxAdults = Math.max(1, parseInt(selectedRoom?.adult) || 5);
                                    return [...Array(maxAdults)].map((_, i) => (
                                      <option key={i + 1} value={i + 1}>
                                        {i + 1}
                                      </option>
                                    ));
                                  } catch (error) {
                                    return [...Array(5)].map((_, i) => (
                                      <option key={i + 1} value={i + 1}>
                                        {i + 1}
                                      </option>
                                    ));
                                  }
                                })()}
                              </select>
                            </div>
                            <div className="form-group">
                              <label className="block text-xs text-gray-500 mb-1">Total Children</label>
                              <select
                                className="w-full px-3 sm:px-4 py-2 sm:py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors text-sm sm:text-base"
                                value={children}
                                onChange={(e) => setChildren(parseInt(e.target.value))}
                              >
                                {(() => {
                                  try {
                                    const maxChildren = Math.max(0, parseInt(selectedRoom?.children || 0) + 1);
                                    return [...Array(maxChildren)].map((_, i) => (
                                      <option key={i} value={i}>
                                        {i}
                                      </option>
                                    ));
                                  } catch (other) {
                                    return [...Array(4)].map((_, i) => (
                                      <option key={i} value={i}>
                                        {i}
                                      </option>
                                    ));
                                  }
                                })()}
                              </select>
                            </div>
                          </div>
                        </div>
                        {hourlyPrices.length > 0 && (
                          <div className="mb-4 sm:mb-6 p-3 sm:p-4 bg-gray-50 rounded-lg border border-gray-200">
                            <h4 className="text-xs sm:text-sm font-semibold text-gray-900 mb-3">Price details</h4>
                            <div className="flex justify-between items-center">
                              <span className="text-xs sm:text-sm text-gray-600">Subtotal</span>
                              <span className="text-lg sm:text-xl lg:text-2xl font-bold text-gray-900">
                                ${selectedPrice || hourlyPrices
                                  .filter(hp => validateAndFormatPrice(hp.price).isValid)
                                  .sort((a, b) => validateAndFormatPrice(a.price).value - validateAndFormatPrice(b.price).value)[0]?.price || '0.00'}
                              </span>
                            </div>
                          </div>
                        )}
                        {bookingError && (
                          <div className="mb-4 p-3 bg-red-100 border border-red-400 text-red-700 rounded text-sm">
                            {bookingError}
                          </div>
                        )}
                        {bookingSuccess && (
                          <div className="mb-4 p-3 bg-green-100 border border-green-400 text-green-700 rounded text-sm">
                            Booking confirmed! Redirecting to checkout...
                          </div>
                        )}
                        <div className="text-center">
                          <button
                            className={`w-full font-semibold py-3 sm:py-4 px-4 sm:px-6 rounded-lg transition-colors duration-200 text-base sm:text-lg ${isSubmitting
                              ? 'bg-gray-400 cursor-not-allowed'
                              : 'bg-gray-900 hover:bg-gray-800'
                              } text-white`}
                            type="submit"
                            disabled={isSubmitting}
                            aria-label="Confirm Booking"
                          >
                            {isSubmitting ? (
                              <span className="flex items-center justify-center">
                                <div className="animate-spin rounded-full h-4 w-4 sm:h-5 sm:w-5 -2 border-white mr-2"></div>
                                Processing...
                              </span>
                            ) : (
                              'Confirm Booking'
                            )}
                          </button>
                        </div>
                      </div>
                    </div>
                  </form>
                )}
              </div>
            </div>
          </div>
        )}
        {showRoomSelectionModal && (
          <div className="fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-50 p-2 sm:p-4">
            <div className="w-full max-w-[90vw] sm:max-w-[800px] lg:max-w-[1046px] shadow-xl bg-[#fff] max-h-[90vh] rounded-lg">
              <div className="flex items-center justify-between   p-4">
                <h2 className="text-lg sm:text-xl font-semibold">Select a Room</h2>
                <button
                  onClick={() => setShowRoomSelectionModal(false)}
                  className="w-6 h-6 sm:w-8 sm:h-8 bg-black text-white rounded-full flex items-center justify-center hover:bg-gray-800 transition"
                >
                  ×
                </button>
              </div>
              <div className="lg:p-8 p-4 bg-white overflow-y-auto max-h-[calc(90vh-80px)]">
                <div className="grid gap-6">
                  {rooms.length === 0 ? (
                    <div className="text-center py-12">
                      <div className="text-gray-400 mb-4">
                        <i className="fas fa-bed text-4xl"></i>
                      </div>
                      <h3 className="text-lg font-medium text-gray-900 mb-2">No rooms available</h3>
                      <p className="text-gray-500">There are currently no rooms available for this venue.</p>
                    </div>
                  ) : (
                    rooms.map((room) => (
                      <div key={room.id} className="p-4 flex flex-col sm:flex-row items-start sm:items-center gap-4 sm:gap-6 border border-gray-200 rounded-lg   hover:border-gray-300 transition-all duration-200">
                        <div className="flex-shrink-0 relative">
                          <img
                            src={room?.feature_image ? `/assets/img/room/featureImage/${room.feature_image}` : '/images/room1.jpg'}
                            alt={room.title}
                            className="w-20 h-20 sm:w-24 sm:h-24 object-cover rounded-lg"
                            onClick={() => {
                              setSelectedRoom(room);
                              setShowImageGalleryModal(true);
                            }}
                            onError={(e) => { e.currentTarget.src = '/images/room1.jpg'; }}
                          />
                          

                        </div>
                        <div className="flex-grow min-w-0">
                          <h3 className="text-base sm:text-lg font-semibold text-gray-900 mb-2">{room.title}</h3>
                          <div className="flex flex-col sm:flex-row sm:items-center gap-2 sm:gap-6 text-xs sm:text-sm text-gray-600 mb-3">
                            <span className="flex items-center gap-2">
                              <i className="fas fa-users text-gray-400"></i>
                              <span>{room.adult} Adults</span>
                            </span>
                            {room.children > 0 && (
                              <span className="flex items-center gap-2">
                                <i className="fas fa-child text-gray-400"></i>
                                <span>{room.children} Children</span>
                              </span>
                            )}
                            {room.two_hour_price && (
                              <span className="flex items-center gap-2">
                                <i className="fas fa-dollar-sign text-gray-400"></i>
                                <span>From {room.two_hour_price}/2h</span>
                              </span>
                            )}
                          </div>
                          {room.amenity_details && room.amenity_details.length > 0 ? (
                            <div className="mb-3">
                              <h4 className="text-xs sm:text-sm font-medium text-gray-700 mb-2">Amenities:</h4>
                              <div className="flex flex-wrap gap-2">
                                {room.amenity_details.slice(0, 4).map((amenity, index) => (
                                  <span key={amenity.id || index} className="inline-flex items-center gap-1 px-2 py-1 bg-blue-100 text-blue-800 text-xs rounded-full">
                                    <i className={`${amenity.icon} text-blue-600`}></i>
                                    <span>{amenity.title}</span>
                                  </span>
                                ))}
                                {room.amenity_details.length > 4 && (
                                  <span className="inline-flex items-center px-2 py-1 bg-gray-100 text-gray-600 text-xs rounded-full">
                                    +{room.amenity_details.length - 4} more
                                  </span>
                                )}
                              </div>
                            </div>
                          ) : room.amenities ? (
                            <div className="mb-3">
                              <h4 className="text-xs sm:text-sm font-medium text-gray-700 mb-2">Amenities:</h4>
                              <div className="flex flex-wrap gap-2">
                                {(() => {
                                  try {
                                    const amenityIds = JSON.parse(room.amenities);
                                    return amenityIds.slice(0, 4).map((amenityId, index) => (
                                      <span key={index} className="inline-flex items-center gap-1 px-2 py-1 bg-blue-100 text-blue-800 text-xs rounded-full">
                                        <i className="fas fa-check text-blue-600"></i>
                                        <span>Amenity {index + 1}</span>
                                      </span>
                                    ));
                                  } catch (e) {
                                    return null;
                                  }
                                })()}
                                {(() => {
                                  try {
                                    const amenityIds = JSON.parse(room.amenities);
                                    if (amenityIds.length > 4) {
                                      return (
                                        <span className="inline-flex items-center px-2 py-1 bg-gray-100 text-gray-600 text-xs rounded-full">
                                          +{amenityIds.length - 4} more
                                        </span>
                                      );
                                    }
                                  } catch (e) {
                                    return null;
                                  }
                                  return null;
                                })()}
                              </div>
                            </div>
                          ) : null}
                        </div>
                        <div className="flex-shrink-0 w-full sm:w-auto">
                          <button
                            onClick={() => {
                              setSelectedRoom(room);
                              setShowRoomSelectionModal(false);
                              setShowBookingModal(true);
                            }}
                            className="w-full sm:w-auto bg-black text-white px-4 sm:px-6 py-2 sm:py-3 rounded-lg hover:bg-gray-800 transition-colors duration-200 font-medium text-sm sm:text-base"
                          >
                            Book this room
                          </button>
                        </div>
                      </div>
                    ))
                  )}
                </div>
              </div>
            </div>
          </div>
        )}
        {showImageGalleryModal && selectedRoom && (
          <div className="fixed inset-0 bg-black bg-opacity-60 flex items-center rounded-lg justify-center z-50 p-2 sm:p-4">
            <div className="w-full max-w-[90vw] sm:max-w-[800px] lg:max-w-[1046px] shadow-xl bg-[#fff] max-h-[90vh]">
              <div className="flex items-center justify-between   p-4">
                <h2 className="text-lg sm:text-xl font-semibold">Book {selectedRoom.title}</h2>
                <button
                  onClick={() => setShowImageGalleryModal(false)}
                  className="w-6 h-6 sm:w-8 sm:h-8 bg-black text-white rounded-full flex items-center justify-center hover:bg-gray-800 transition"
                >
                  ×
                </button>
              </div>
              <div className="  lg:p-8 bg-white overflow-y-auto max-h-[calc(90vh-120px)]">
                <div className="mb-6">
                  {(() => {
                    const validImages = roomImages.filter(roomImage => roomImage.image && roomImage.image.trim() !== '');
                    const firstValidImage = validImages[0];
                    if (firstValidImage) {
                      return (
                        <img
                          src={`/assets/img/room/room-gallery/${firstValidImage.image}`}
                          alt={selectedRoom.title}
                          className="w-full h-[400px] object-cover rounded-lg"
                          onError={(e) => { e.currentTarget.src = '/images/room1.jpg'; }}
                        />
                      );
                    } else {
                      return (
                        <img
                          src={selectedRoom?.feature_image ? `/assets/img/room/featureImage/${selectedRoom.feature_image}` : '/images/room1.jpg'}
                          alt={selectedRoom.title}
                          className="w-full h-full object-cover rounded-lg"
                          onError={(e) => { e.currentTarget.src = '/images/room1.jpg'; }}
                        />
                      );
                    }
                  })()}
                </div>
                <div className="mb-6 sm:mb-8">
                  {loadingRoomImages ? (
                    <div className="flex justify-center py-6 sm:py-8">
                      <div className="animate-spin rounded-full h-6 w-6 sm:h-8 sm:w-8 -2 lue-600"></div>
                    </div>
                  ) : roomImages.length > 0 ? (
                    <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-2 sm:gap-4">
                      {roomImages
                        .filter(roomImage => roomImage.image && roomImage.image.trim() !== '')
                        .map((roomImage, index) => {
                          const imageUrl = `/assets/img/room/room-gallery/${roomImage.image}`;
                          return (
                            <div
                              key={roomImage.id || index}
                              className={`border-2 ${index === 0 ? 'border-blue-500' : 'border-gray-200'} rounded-lg overflow-hidden cursor-pointer hover:border-blue-400 transition-colors`}
                              onClick={() => {
                                const newImages = [...roomImages];
                                const clickedImage = newImages.splice(index, 1)[0];
                                newImages.unshift(clickedImage);
                                setRoomImages(newImages);
                              }}
                            >
                              <img
                                src={imageUrl}
                                alt={`Room view ${index + 1}`}
                                className="w-full h-[80px] sm:h-[100px] lg:h-[124px] rounded-[8px] object-contain"
                                onError={(e) => {
                                  e.currentTarget.src = '/images/room1.jpg';
                                }}
                              />
                            </div>
                          );
                        })}
                    </div>
                  ) : (
                    <div className="flex flex-wrap gap-2 sm:gap-4">
                      <div className="border-2 lue-500 rounded-lg overflow-hidden">
                        <img
                          src={selectedRoom?.feature_image ? `/assets/img/room/featureImage/${selectedRoom.feature_image}` : '/images/room1.jpg'}
                          alt="Main room view"
                          className="w-20 h-20 sm:w-24 sm:h-24 object-cover"
                          onError={(e) => { e.currentTarget.src = '/images/room1.jpg'; }}
                        />
                      </div>
                      <div className="border-2 border-gray-200 rounded-lg overflow-hidden">
                        <img
                          src="/images/room1.jpg"
                          alt="Meeting area"
                          className="w-20 h-20 sm:w-24 sm:h-24 object-cover"
                        />
                      </div>
                      <div className="border-2 border-gray-200 rounded-lg overflow-hidden">
                        <img
                          src="/images/room1.jpg"
                          alt="Bedroom"
                          className="w-20 h-20 sm:w-24 sm:h-24 object-cover"
                        />
                      </div>
                    </div>
                  )}
                </div>
                <div className="mb-6">
                  <h3 className="text-lg font-semibold text-gray-900 mb-3">Room Description</h3>
                  <p
                    className="text-gray-600 leading-relaxed"
                    dangerouslySetInnerHTML={{ __html: selectedRoom?.description || '' }}
                  />
                </div>
                <div className="mb-6">
                  <h3 className="text-base sm:text-lg font-semibold text-gray-900 mb-3">Room Amenities</h3>
                  {(() => {
                    if (selectedRoom?.amenity_details && selectedRoom.amenity_details.length > 0) {
                      return (
                        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3 sm:gap-4">
                          {selectedRoom.amenity_details.map((amenity, index) => (
                            <div key={amenity.id || index} className="flex items-center gap-3 p-2 sm:p-3 bg-gray-50 rounded-lg">
                              <div className="w-5 h-5 sm:w-6 sm:h-6 flex items-center justify-center">
                                <i className={`${amenity.icon} text-blue-600 text-base sm:text-lg`}></i>
                              </div>
                              <span className="text-xs sm:text-sm text-gray-700 font-medium">{amenity.title}</span>
                            </div>
                          ))}
                        </div>
                      );
                    }
                    if (loadingRoomAmenities) {
                      return (
                        <div className="flex justify-center py-4">
                          <div className="animate-spin rounded-full h-5 w-5 sm:h-6 sm:w-6 -2 lue-600"></div>
                        </div>
                      );
                    }
                    if (roomAmenities.length > 0) {
                      return (
                        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3 sm:gap-4">
                          {roomAmenities.map((amenity, index) => (
                            <div key={amenity.id || index} className="flex items-center gap-3 p-2 sm:p-3 bg-gray-50 rounded-lg">
                              <div className="w-5 h-5 sm:w-6 sm:h-6 flex items-center justify-center">
                                <i className={`${amenity.icon} text-blue-600 text-base sm:text-lg`}></i>
                              </div>
                              <span className="text-xs sm:text-sm text-gray-700 font-medium">{amenity.title}</span>
                            </div>
                          ))}
                        </div>
                      );
                    }
                    if (selectedRoom?.amenities) {
                      try {
                        const amenityIds = JSON.parse(selectedRoom.amenities);
                        if (amenityIds.length > 0) {
                          return (
                            <div className="text-center py-4 sm:py-6 border-2 border-dashed border-gray-300 rounded-lg">
                              <div className="text-gray-400 mb-2">
                                <i className="fas fa-info-circle text-xl sm:text-2xl"></i>
                              </div>
                              <h6 className="text-gray-600 text-xs sm:text-sm font-medium">Amenities available</h6>
                              <p className="text-gray-500 text-xs mt-1">Click on room images to see detailed amenities</p>
                            </div>
                          );
                        }
                      } catch (e) {
                      }
                    }
                    return (
                      <div className="text-center py-4 sm:py-6 border-2 border-dashed border-gray-300 rounded-lg">
                        <div className="text-gray-400 mb-2">
                          <i className="fas fa-info-circle text-xl sm:text-2xl"></i>
                        </div>
                        <h6 className="text-gray-600 text-xs sm:text-sm font-medium">No amenities available</h6>
                        <p className="text-xs text-gray-500 mt-1">This room doesn't have any amenities listed</p>
                      </div>
                    );
                  })()}
                </div>
              </div>
            </div>
          </div>
        )}
        {showAllHotelImagesModal && (
          <div className="fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-50 p-2 sm:p-4">
            <div className="w-full max-w-[90vw] sm:max-w-[800px] lg:max-w-[1046px] shadow-xl bg-[#fff] max-h-[90vh] rounded-lg">
              <div className="flex items-center justify-between  p-f ">
                <h2 className="text-lg sm:text-xl font-semibold p-4">All Hotel Images</h2>
                <button
                  onClick={() => setShowAllHotelImagesModal(false)}
                  className="w-6 h-6 sm:w-8 sm:h-8  bg-black text-white rounded-full flex items-center justify-center hover:bg-gray-800 transition"
                >
                  ×
                </button>
              </div>
              <div className="p-4  lg:p-8 bg-white overflow-y-auto max-h-[calc(90vh-120px)]">
                <div className="mb-6">
                  {galleryImages.length > 0 ? (
                    <img
                      src={galleryImages[selectedMainImage]}
                      alt={hotel?.title || 'Hotel'}
                      className="w-full h-[400px] object-cover rounded-lg"
                      onError={(e) => { e.currentTarget.src = '/images/room1.jpg'; }}
                    />
                  ) : (
                    <div className="w-full h-[400px] bg-gray-200 rounded-lg flex items-center justify-center">
                      <span className="text-gray-500">No images available</span>
                    </div>
                  )}
                </div>
                <div className="mb-6">
                  <h3 className="text-lg font-semibold text-gray-900 mb-4">All Images</h3>
                  {galleryImages.length > 0 ? (
                    <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-2 sm:gap-4">
                      {galleryImages.map((image, index) => (
                        <div
                          key={index}
                          className={`border-2 ${index === selectedMainImage ? 'border-blue-500' : 'border-gray-200'} rounded-lg overflow-hidden cursor-pointer hover:border-blue-400 transition-colors`}
                          onClick={() => setSelectedMainImage(index)}
                        >
                          <img
                            src={image}
                            alt={`Hotel image ${index + 1}`}
                            className="w-full h-[80px] sm:h-[100px] lg:h-[124px] rounded-[8px] object-cover"
                            onError={(e) => {
                              e.currentTarget.src = '/images/room1.jpg';
                            }}
                          />
                        </div>
                      ))}
                    </div>
                  ) : (
                    <div className="text-center py-8">
                      <div className="text-gray-400 mb-4">
                        <i className="fas fa-images text-4xl"></i>
                      </div>
                      <h3 className="text-lg font-medium text-gray-900 mb-2">No images available</h3>
                      <p className="text-gray-500">This hotel doesn't have any gallery images.</p>
                    </div>
                  )}
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
    </>
  );
}
export default HotelDetails;