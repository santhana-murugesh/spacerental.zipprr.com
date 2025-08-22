import React, { useState, useEffect, useRef, useMemo } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import { Login } from './Login';
import { useTranslation } from 'react-i18next';
import { useLanguage } from '../contexts/LanguageContext';
import { Signup } from './Signup';
import { FaHeart, FaRegHeart } from 'react-icons/fa';
import { Header } from './Homepage-sections/Header';
import { useAuth } from './AuthContext';

export const SearchPage = () => {
  const { user } = useAuth();
  const [searchParams] = useSearchParams();
  const { t } = useTranslation();
  const { currentLanguage, direction } = useLanguage();
  const navigate = useNavigate();
  const [searchResults, setSearchResults] = useState([]);
  const [filteredResults, setFilteredResults] = useState([]);
  const [loading, setLoading] = useState(true);
  const [pagination, setPagination] = useState({});
  const [error, setError] = useState(null);
  const [filters, setFilters] = useState({
    priceRange: '',
    rating: '',
    amenities: [],
    sortBy: 'relevance',
    hotelType: '',
    roomType: '',
    guests: '',
    distance: ''
  });
  const [searchData, setSearchData] = useState({
    activity: '',
    location: '',
    date: ''
  });
  const [categories, setCategories] = useState([]);
  const [filteredCategories, setFilteredCategories] = useState([]);
  const [showcategoryDropdown, setShowcategoryDropdown] = useState(false);
  const [cities, setCities] = useState([]);
  const [filteredCities, setFilteredCities] = useState([]);
  const [showCitiesDropdown, setShowCitiesDropdown] = useState(false);
  const [mapSearchEnabled, setMapSearchEnabled] = useState(false);
  const [mapSettings, setMapSettings] = useState(null);
  const [generalSettings, setGeneralSettings] = useState(null);
  const [map, setMap] = useState(null);
  const [markers, setMarkers] = useState([]);
  const [showMapOnMobile, setShowMapOnMobile] = useState(false);
  const [showFilters, setShowFilters] = useState(false);
  const [showLogin, setShowLogin] = useState(false);
  const [showSignUp, setShowSignUp] = useState(false);
  const [showMobileMenu, setShowMobileMenu] = useState(false);
  const [viewMode, setViewMode] = useState('list');
  const [whitelistedHotels, setWhitelistedHotels] = useState(new Set());
  const mapRef = useRef(null);
  const hotelTypes = [
    { label: t('boutique'), value: 'Boutique' },
    { label: t('luxury'), value: 'Luxury' },
    { label: t('business'), value: 'Business' },
    { label: t('resort'), value: 'Resort' },
    { label: t('budget'), value: 'Budget' },
    { label: t('family'), value: 'Family' }
  ];
  const roomTypes = [
    { label: t('single'), value: 'Single' },
    { label: t('double'), value: 'Double' },
    { label: t('suite'), value: 'Suite' },
    { label: t('deluxe'), value: 'Deluxe' },
    { label: t('standard'), value: 'Standard' },
    { label: t('premium'), value: 'Premium' }
  ];
  const guestOptions = ['1', '2', '3', '4', '5+'];
  const distanceOptions = ['1km', '5km', '10km', '25km', '50km+'];
  const priceRanges = [
    { label: t('under_100'), value: '0-100' },
    { label: t('100_to_200'), value: '100-200' },
    { label: t('200_to_500'), value: '200-500' },
    { label: t('500_to_1000'), value: '500-1000' },
    { label: t('1000_plus'), value: '1000+' }
  ];
  const ratingOptions = ['1+', '2+', '3+', '4+', '5'];
  const API_BASE_URL = useMemo(() => {
    const hostname = window.location.hostname;
    if (hostname === "localhost" || hostname === "127.0.0.1") {
      const localUrl = import.meta.env.VITE_API_BASE_URL_LOCAL;
      return localUrl;
    } else {
      const productionUrl = import.meta.env.VITE_API_BASE_URL;
      return productionUrl;
    }
  }, []);
  const activity = searchParams.get('activity') || searchParams.get('category') || '';
  const location = searchParams.get('location') || '';
  const date = searchParams.get('date') || '';
  const country = searchParams.get('country') || '';
  useEffect(() => {
    fetchMapSettings();
    fetchBasicImages();
    loadCategories();
    loadCities();
    fetchWhitelistedHotels();
    window.hotelClick = handleHotelClick;
    return () => {
      delete window.hotelClick;
    };
  }, []);
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (showMobileMenu && !event.target.closest('header')) {
        setShowMobileMenu(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [showMobileMenu]);
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
  useEffect(() => {
    fetchSearchResults();
  }, [activity, location, date, country]);
  useEffect(() => {
    if (searchResults.length > 0) {
      const filtered = filterResults(searchResults);
      setFilteredResults(filtered);
      if (user) {
        fetchWhitelistedHotels();
      }
    }
  }, [searchResults, filters, user]);
  useEffect(() => {
    console.log('User state changed:', user);
    if (user) {
      console.log('User is authenticated, fetching whitelisted hotels...');
      fetchWhitelistedHotels();
    } else {
      console.log('No user, clearing whitelist');
      setWhitelistedHotels(new Set());
    }
  }, [user]);
  useEffect(() => {
    if (mapSettings && mapSettings.google_map_api_key_status === 1 && filteredResults.length > 0) {
      initializeMap();
    } else if (mapSettings && mapSettings.google_map_api_key_status === 0) {
      showMapFallback(t('google_maps_disabled_in_settings'));
    } else if (!mapSettings && filteredResults.length > 0) {
      showMapFallback(t('map_settings_unavailable_using_default'));
    }
    const style = document.createElement('style');
    style.textContent = `
        .gm-style-iw.gm-style-iw-c {
          padding: 0 !important;
          background: transparent !important;
          box-shadow: none !important;
        }
        .gm-style-iw-d {
          overflow: hidden !important;
          background: transparent !important;
        }
        .gm-style-iw-t::after {
          background: transparent !important;
        }
        .gm-style-iw-tc {
          background: transparent !important;
        }
        .gm-style-iw-chr {
          display: none !important;
        }
      `;
    document.head.appendChild(style);
    return () => {
      if (style.parentNode) {
        style.parentNode.removeChild(style);
      }
    };
  }, [mapSettings, filteredResults]);
  useEffect(() => {
    if (map && location && filteredResults.length === 0) {
      centerMapOnLocation(location);
    }
  }, [map, location, filteredResults]);
  useEffect(() => {
  }, [currentLanguage]);
  const fetchMapSettings = async () => {
    try {
      const response = await fetch(`${API_BASE_URL}/api/settings`);
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const data = await response.json();
      if (data.success) {
        setMapSettings(data.data);
        if (data.data.google_map_api_key_status === 0) {
          showMapFallback(t('google_maps_disabled_in_settings'));
        }
      } else {
        throw new Error(data.message || t('api_returned_success_false'));
      }
    } catch (error) {
      console.error('Error fetching map settings:', error);
      showMapFallback(`${t('failed_to_load_map_settings')}: ${error.message}`);
    }
  };
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
  const loadCategories = async () => {
    try {
      const routesResponse = await fetch(`${API_BASE_URL}/api/routes`);
      const routes = await routesResponse.json();
      const categoriesResponse = await fetch(routes.hotelsCategories);
      const categoriesData = await categoriesResponse.json();
      if (categoriesData && categoriesData.length > 0) {
        setCategories(categoriesData);
      } else {
        setCategories([]);
      }
    } catch (error) {
      console.error('Error loading categories:', error);
      setCategories([]);
    }
  };
  const loadCities = async () => {
    try {
      const routesResponse = await fetch(`${API_BASE_URL}/api/routes`);
      const routes = await routesResponse.json();
      const citiesResponse = await fetch(routes.cities);
      const citiesData = await citiesResponse.json();
      if (citiesData && Object.keys(citiesData).length > 0) {
        const citiesArray = Object.values(citiesData);
        setCities(citiesArray);
      } else {
        setCities([]);
      }
    } catch (error) {
      console.error('Error loading cities:', error);
      setCities([]);
    }
  };
  const fetchSearchResults = async (page = 1) => {
    setLoading(true);
    setError(null);
    try {
      const params = new URLSearchParams();
      if (activity) params.append('activity', activity);
      if (location) params.append('location', location);
      if (date) params.append('date', date);
      if (searchParams.get('category')) params.append('category', searchParams.get('category'));
      if (country) params.append('country', country);
      if (filters.priceRange) params.append('priceRange', filters.priceRange);
      if (filters.rating) params.append('rating', filters.rating);
      if (filters.amenities.length > 0) {
        filters.amenities.forEach(amenity => params.append('amenities[]', amenity));
      }
      params.append('page', page);
      const response = await fetch(`${API_BASE_URL}/api/search/hotels?${params.toString()}`);
      if (!response.ok) {
        const errorText = await response.text();
        console.error('API Error Response:', errorText);
        throw new Error(`HTTP error! status: ${response.status}, message: ${errorText}`);
      }
      const data = await response.json();
      if (data.success) {
        setSearchResults(data.data.hotels);
        setPagination(data.data.pagination);
      } else {
        setError(data.message || t('failed_to_fetch_search_results'));
        setSearchResults([]);
      }
    } catch (error) {
      console.error('Error fetching search results:', error);
      setError(`An unexpected error occurred: ${error.message}`);
      setSearchResults([]);
    } finally {
      setLoading(false);
    }
  };
  const initializeMap = () => {
    if (!mapSettings?.google_map_api_key || !mapRef.current) return;
    if (window.google && window.google.maps) {
      createMap();
      return;
    }
    const script = document.createElement('script');
    script.src = `https://maps.googleapis.com/maps/api/js?key=${mapSettings.google_map_api_key}&libraries=places,geocoding`;
    script.async = true;
    script.defer = true;
    script.onload = () => {
      createMap();
    };
    script.onerror = () => {
      showMapFallback();
    };
    document.head.appendChild(script);
  };
  const handleInputChange = (field, value) => {
    setSearchData(prev => ({
      ...prev,
      [field]: value
    }));
    if (field === 'activity') {
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
      activity: categoryName
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
  const centerMapOnLocation = (searchLocation) => {
    if (!map || !searchLocation) return;
    const geocoder = new window.google.maps.Geocoder();
    geocoder.geocode({ address: searchLocation }, (results, status) => {
      if (status === 'OK' && results[0]) {
        const location = results[0].geometry.location;
        map.setCenter(location);
        map.setZoom(12);
        new window.google.maps.Marker({
          position: location,
          map: map,
          title: `Search: ${searchLocation}`,
          icon: {
            url: 'data:image/svg+xml;charset=UTF-8,' + encodeURIComponent(`
              <svg width="70" height="45" viewBox="0 0 70 45" xmlns="http://www.w3.org/2000/svg">
                <!-- Speech bubble shadow -->
                <path d="M8 2 L62 2 Q68 2 68 8 L68 20 Q68 26 62 26 L40 26 L35 35 L30 26 L8 26 Q2 26 2 20 L2 8 Q2 2 8 2 Z" fill="#000000" opacity="0.2"/>
                <!-- Speech bubble -->
                <path d="M8 0 L62 0 Q68 0 68 6 L68 18 Q68 24 62 24 L40 24 L35 33 L30 24 L8 24 Q2 24 2 18 L2 6 Q2 0 8 0 Z" fill="#10B981" stroke="#059669" stroke-width="1"/>
                <!-- Search icon -->
                <text x="35" y="16" text-anchor="middle" fill="white" font-size="12" font-weight="bold">🔍</text>
              </svg>
            `),
            scaledSize: new window.google.maps.Size(70, 45),
            anchor: new window.google.maps.Point(35, 33)
          }
        });
      }
    });
  };
  const showMapFallback = (message = 'Map Not Available') => {
    if (mapRef.current) {
      mapRef.current.innerHTML = `
        <div class="w-full h-full bg-gradient-to-br from-gray-100 to-gray-200 flex items-center justify-center">
          <div class="text-center">
            <div class="text-4xl mb-2">🗺️</div>
            <p class="text-gray-600 text-sm">${message}</p>
            <p class="text-gray-500 text-xs">Please contact administrator to enable maps</p>
            <p class="text-gray-500 text-xs mt-2">API URL: ${API_BASE_URL}</p>
            <div class="mt-4 p-3 bg-white rounded-lg shadow-sm max-w-xs mx-auto">
              <h4 class="text-sm font-semibold text-gray-700 mb-2">Hotel Locations</h4>
              <div class="space-y-2 text-xs text-gray-600">
                ${filteredResults.slice(0, 5).map(hotel => `
                  <div class="flex justify-between items-center">
                    <span class="truncate">${hotel.name}</span>
                    <span class="text-green-600 font-medium">${hotel.price}</span>
                  </div>
                `).join('')}
                ${filteredResults.length > 5 ? `<p class="text-gray-500 italic">... ${t('and')} ${filteredResults.length - 5} ${t('more')}</p>` : ''}
              </div>
            </div>
          </div>
        </div>
      `;
    }
  };
  const createMap = () => {
    if (!window.google || !mapRef.current) return;
    const mapInstance = new window.google.maps.Map(mapRef.current, {
      zoom: 12,
      center: new window.google.maps.LatLng(40.7128, -74.0060),
      mapTypeId: window.google.maps.MapTypeId.ROADMAP,
      styles: [
        {
          featureType: 'poi',
          elementType: 'labels',
          stylers: [{ visibility: 'off' }]
        },
        {
          featureType: 'transit',
          elementType: 'labels',
          stylers: [{ visibility: 'off' }]
        }
      ],
      zoomControl: true,
      mapTypeControl: false,
      scaleControl: true,
      streetViewControl: false,
      rotateControl: false,
      fullscreenControl: true
    });
    setMap(mapInstance);
    const bounds = new window.google.maps.LatLngBounds();
    const validHotels = filteredResults.filter(hotel => hotel.latitude && hotel.longitude);
    let mapCenter;
    let defaultZoom = 12;
    let latDiff = 0;
    let lngDiff = 0;
    if (validHotels.length === 0) {
      if (location) {
        const geocoder = new window.google.maps.Geocoder();
        geocoder.geocode({ address: location }, (results, status) => {
          if (status === 'OK' && results[0]) {
            const searchLocation = results[0].geometry.location;
            mapInstance.setCenter(searchLocation);
            mapInstance.setZoom(12);
          } else {
            mapInstance.setCenter(new window.google.maps.LatLng(40.7128, -74.0060));
            mapInstance.setZoom(10);
          }
        });
      } else {
        mapCenter = new window.google.maps.LatLng(40.7128, -74.0060);
        defaultZoom = 10;
      }
    } else {
      validHotels.forEach(hotel => {
        const lat = parseFloat(hotel.latitude);
        const lng = parseFloat(hotel.longitude);
        bounds.extend(new window.google.maps.LatLng(lat, lng));
      });
      const ne = bounds.getNorthEast();
      const sw = bounds.getSouthWest();
      latDiff = Math.abs(ne.lat() - sw.lat());
      lngDiff = Math.abs(ne.lng() - sw.lng());
      if (latDiff > 10 || lngDiff > 10) {
        const firstHotel = validHotels[0];
        mapCenter = new window.google.maps.LatLng(
          parseFloat(firstHotel.latitude),
          parseFloat(firstHotel.longitude)
        );
        defaultZoom = 12;
      } else {
        mapCenter = bounds.getCenter();
        defaultZoom = 10;
      }
      // Set the center and zoom
      mapInstance.setCenter(mapCenter);
      mapInstance.setZoom(defaultZoom);
    }
    markers.forEach(marker => marker.setMap(null));
    const newMarkers = validHotels.map(hotel => {
      const marker = new window.google.maps.Marker({
        position: new window.google.maps.LatLng(
          parseFloat(hotel.latitude),
          parseFloat(hotel.longitude)
        ),
        map: mapInstance,
        title: hotel.name,
        icon: {
          url: 'data:image/svg+xml;charset=UTF-8,' + encodeURIComponent(`
            <svg width="80" height="50" viewBox="0 0 80 50" xmlns="http://www.w3.org/2000/svg">
              <!-- Speech bubble shadow -->
              <path d="M10 2 L70 2 Q78 2 78 10 L78 25 Q78 33 70 33 L45 33 L40 42 L35 33 L10 33 Q2 33 2 25 L2 10 Q2 2 10 2 Z" fill="#000000" opacity="0.2"/>
              <!-- Speech bubble -->
              <path d="M10 0 L70 0 Q78 0 78 8 L78 23 Q78 31 70 31 L45 31 L40 40 L35 31 L10 31 Q2 31 2 23 L2 8 Q2 0 10 0 Z" fill="#4F46E5" stroke="#4338CA" stroke-width="1"/>
              <!-- Price text -->
              <text x="40" y="20" text-anchor="middle" fill="white" font-size="14" font-weight="bold" font-family="Arial, sans-serif">$${parseFloat(hotel.price.replace(/[^0-9.]/g, '')).toFixed(0)}</text>
            </svg>
          `),
          scaledSize: new window.google.maps.Size(80, 50),
          anchor: new window.google.maps.Point(40, 40)
        },
        animation: window.google.maps.Animation.DROP
      });
      const infoWindow = new window.google.maps.InfoWindow({
        content: `
          <div style="width: 280px; border-radius: 12px; overflow: hidden; background-color: white; box-shadow: 0 2px 8px rgba(0,0,0,0.15); font-family: sans-serif;">
            <div style="position: relative; height: 180px; cursor: pointer;" onclick="window.hotelClick(hotel.id)">
              <img src="${getHotelImages(hotel)[0]}" alt="${hotel.name}" style="width: 100%; height: 100%; object-fit: cover;">
              <!-- Close button (X) -->
              <div style="position: absolute; top: 10px; right: 10px; width: 24px; height: 24px; background: rgba(0, 0, 0, 0.6); border-radius: 50%; display: flex; align-items: center; justify-content: center; cursor: pointer; z-index: 10;" onclick="event.stopPropagation(); this.closest('.gm-style-iw').style.display='none';">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="white">
                  <path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"/>
                </svg>
              </div>
              <div style="position: absolute; bottom: 10px; left: 50%; transform: translateX(-50%); display: flex; gap: 6px;">
                <div style="width: 6px; height: 6px; background: white; border-radius: 50%; opacity: 1;"></div>
                <div style="width: 6px; height: 6px; background: white; border-radius: 50%; opacity: 0.5;"></div>
                <div style="width: 6px; height: 6px; background: white; border-radius: 50%; opacity: 0.5;"></div>
                <div style="width: 6px; height: 6px; background: white; border-radius: 50%; opacity: 0.5;"></div>
                <div style="width: 6px; height: 6px; background: white; border-radius: 50%; opacity: 0.5;"></div>
              </div>
            </div>
            <div style="padding: 12px 16px;">
              <h4 style="margin: 0; font-size: 18px; font-weight: bold; color: #000;">${hotel.name}</h4>
              <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 6px;">
                <div style="display: flex; align-items: center; gap: 4px; font-size: 14px; color: #000;">
                  <span style="color: #2563eb;">${hotel.stars || '5.0'}</span>
                  <span style="color: #2563eb;">★★★★★</span>
                  <span style="color: #555;">(${Math.floor(Math.random() * 200) + 50} Reviews)</span>
                </div>
                <div style="font-size: 16px; font-weight: bold; color: #000;">
                  $${parseFloat(hotel.price.replace(/[^0-9.]/g, '')).toLocaleString()} /hr
                </div>
              </div>
            </div>
          </div>
        `,
        maxWidth: 300,
        pixelOffset: new window.google.maps.Size(0, -10),
        backgroundColor: 'transparent',
        disableAutoPan: false
      });
      marker.addListener('click', () => {
        markers.forEach(m => {
          if (m.infoWindow && m.infoWindow !== infoWindow) {
            m.infoWindow.close();
          }
        });
        infoWindow.open(mapInstance, marker);
      });
      marker.infoWindow = infoWindow;
      return marker;
    });
    setMarkers(newMarkers);
    if (validHotels.length > 0 && latDiff <= 10 && lngDiff <= 10) {
      mapInstance.fitBounds(bounds);
      const listener = window.google.maps.event.addListener(mapInstance, 'idle', () => {
        if (mapInstance.getZoom() > 15) {
          mapInstance.setZoom(15);
        }
        window.google.maps.event.removeListener(listener);
      });
    }
    mapInstance.addListener('click', () => {
      markers.forEach(marker => {
        if (marker.infoWindow) {
          marker.infoWindow.close();
        }
      });
    });
  };
  const handleFilterChange = (filterType, value) => {
    setFilters(prev => ({
      ...prev,
      [filterType]: value
    }));
  };
  const filterResults = (results) => {
    let filtered = results.filter(hotel => {
      if (filters.priceRange && filters.priceRange !== '') {
        try {
          const [min, max] = filters.priceRange.split('-');
          const hotelPrice = parseFloat(hotel.price?.replace(/[^0-9.]/g, '') || '0');
          if (max === '+') {
            if (hotelPrice < parseFloat(min)) return false;
          } else {
            if (hotelPrice < parseFloat(min) || hotelPrice > parseFloat(max)) return false;
          }
        } catch (error) {
          console.log('Price filter error for hotel:', hotel.name, error);
        }
      }
      if (filters.rating && filters.rating !== '') {
        try {
          const minRating = parseInt(filters.rating);
          const hotelRating = parseInt(hotel.stars) || parseInt(hotel.rating) || 0;
          if (hotelRating < minRating) return false;
        } catch (error) {
          console.log('Rating filter error for hotel:', hotel.name, error);
        }
      }
      if (filters.hotelType && filters.hotelType !== '') {
        const hotelCategory = hotel.category || hotel.hotel_type || hotel.type || '';
        if (hotelCategory.toLowerCase() !== filters.hotelType.toLowerCase()) return false;
      }
      if (filters.roomType && filters.roomType !== '') {
        const hasRoomType = hotel.rooms && hotel.rooms.some(room =>
          room.type && room.type.toLowerCase().includes(filters.roomType.toLowerCase())
        );
        if (!hasRoomType) return false;
      }
      if (filters.guests && filters.guests !== '') {
        try {
          const guestCount = parseInt(filters.guests);
          const availableRooms = parseInt(hotel.roomCount) || parseInt(hotel.available_rooms) || parseInt(hotel.total_rooms) || 0;
          if (availableRooms < guestCount) return false;
        } catch (error) {
          console.log('Guests filter error for hotel:', hotel.name, error);
        }
      }
      if (filters.amenities.length > 0) {
        try {
          const hotelAmenities = hotel.amenities || hotel.features || hotel.facilities || [];
          const hasAllAmenities = filters.amenities.every(amenity =>
            hotelAmenities.some(hotelAmenity =>
              hotelAmenity.toLowerCase().includes(amenity.toLowerCase())
            )
          );
          if (!hasAllAmenities) return false;
        } catch (error) {
          console.log('Amenities filter error for hotel:', hotel.name, error);
        }
      }
      return true;
    });
    if (filters.sortBy && filters.sortBy !== 'relevance') {
      console.log('Sorting results by:', filters.sortBy);
      filtered.sort((a, b) => {
        switch (filters.sortBy) {
          case 'price-low':
            const priceA = parseFloat(a.price?.replace(/[^0-9.]/g, '') || a.min_price?.replace(/[^0-9.]/g, '') || '0');
            const priceB = parseFloat(b.price?.replace(/[^0-9.]/g, '') || b.min_price?.replace(/[^0-9.]/g, '') || '0');
            return priceA - priceB;
          case 'price-high':
            const priceHighA = parseFloat(a.price?.replace(/[^0-9.]/g, '') || a.min_price?.replace(/[^0-9.]/g, '') || '0');
            const priceHighB = parseFloat(b.price?.replace(/[^0-9.]/g, '') || b.min_price?.replace(/[^0-9.]/g, '') || '0');
            return priceHighB - priceHighA;
          case 'rating':
            const ratingA = parseFloat(a.stars || a.rating || a.average_rating || '0');
            const ratingB = parseFloat(b.stars || b.rating || b.average_rating || '0');
            return ratingB - ratingA;
          default:
            return 0;
        }
      });
    }
    return filtered;
  };
  const handleSearchSubmit = (e) => {
    e.preventDefault();
    const params = new URLSearchParams();
    if (searchData.activity) params.append('activity', searchData.activity);
    if (searchData.location) params.append('location', searchData.location);
    if (searchData.date) params.append('date', searchData.date);
    navigate(`/search?${params.toString()}`);
  };
  const handleAmenityToggle = (amenity) => {
    setFilters(prev => ({
      ...prev,
      amenities: prev.amenities.includes(amenity)
        ? prev.amenities.filter(a => a !== amenity)
        : [...prev.amenities, amenity]
    }));
  };
  const handleHotelClick = (hotelId) => {
    navigate(`/hotels/${hotelId}`);
  };
  const handlePageChange = (page) => {
    fetchSearchResults(page);
  };
  const getHotelImages = useMemo(() => (hotel) => {
    const images = [];
    if (hotel?.image) {
      if (hotel.image.startsWith('http://') || hotel.image.startsWith('https://')) {
        images.push(hotel.image);
      } else {
        const baseUrl = window.location.origin;
        images.push(`${baseUrl}${hotel.image}`);
      }
    }
    if (images.length === 0 && hotel?.hotel_galleries?.length > 0) {
      hotel.hotel_galleries.forEach((img) => {
        if (img?.image) {
          images.push(`/assets/img/hotel/hotel-gallery/${img.image}`);
        }
      });
    }
    if (images.length === 0 && hotel?.logo) {
      images.push(`/assets/img/hotel/logo/${hotel.logo}`);
    }
    if (images.length === 0) {
      images.push('/images/room1.jpg');
    }
    return images;
  }, []);


  const fetchWhitelistedHotels = async () => {
    try {
      if (user) {
        console.log('Fetching whitelisted hotels for user:', user.id);
        
        // Try to get from JWT-based API
        try {
          const token = localStorage.getItem('jwt_token');
          if (!token) {
            console.log('No JWT token found, falling back to localStorage');
            const stored = localStorage.getItem(`whitelisted_hotels_${user.id}`);
            if (stored) {
              const whitelistArray = JSON.parse(stored);
              console.log('Setting whitelisted hotels from localStorage:', whitelistArray);
              setWhitelistedHotels(new Set(whitelistArray));
            } else {
              console.log('No localStorage data found, initializing empty wishlist');
              setWhitelistedHotels(new Set());
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
          
          console.log('API Response status:', response.status);
          
          if (response.ok) {
            const data = await response.json();
            console.log('API Response data:', data);
            
            if (data.success && data.wishlists) {
              const hotelIds = data.wishlists.map(item => item.hotel_id);
              console.log('Setting whitelisted hotels from API:', hotelIds);
              setWhitelistedHotels(new Set(hotelIds));
              // Also update localStorage
              localStorage.setItem(`whitelisted_hotels_${user.id}`, JSON.stringify(hotelIds));
              return;
            } else {
              console.log('API returned success but no wishlists data:', data);
            }
          } else {
            console.log('API request failed with status:', response.status);
          }
        } catch (apiError) {
          console.log('JWT API fetch failed, falling back to localStorage:', apiError);
        }
        
        // Fallback to localStorage if API fails
        const stored = localStorage.getItem(`whitelisted_hotels_${user.id}`);
        if (stored) {
          const whitelistArray = JSON.parse(stored);
          console.log('Setting whitelisted hotels from localStorage:', whitelistArray);
          setWhitelistedHotels(new Set(whitelistArray));
        } else {
          console.log('No localStorage data found, initializing empty wishlist');
          setWhitelistedHotels(new Set());
        }
      } else {
        console.log('No user found, clearing whitelist');
        setWhitelistedHotels(new Set());
      }
    } catch (error) {
      console.error('Error fetching whitelisted hotels:', error);
      setWhitelistedHotels(new Set());
    }
  };
  const toggleWishlist = async (hotelId, event) => {
    event.stopPropagation();
    
    if (!user) {
      setShowLogin(true);
      return;
    }
    
    console.log('Toggling wishlist for hotel:', hotelId, 'User:', user);
    
    try {
      const isCurrentlyWhitelisted = whitelistedHotels.has(hotelId);
      const endpoint = isCurrentlyWhitelisted ? '/api/wishlist/hotel/remove' : '/api/wishlist/hotel/add';
      
      // Get JWT token
      const token = localStorage.getItem('jwt_token');
      if (!token) {
        console.error('No JWT token found');
        return;
      }
      
      console.log('JWT Token found:', token ? 'Yes' : 'No');
      console.log('Endpoint:', endpoint);
      
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
      
      console.log('Response status:', response.status);
      console.log('Response headers:', response.headers);

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
  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center" dir={direction}>
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600">{t('searching_for_best_options')}</p>
        </div>
      </div>
    );
  }
  return (
    <>
      <Header bgColor="bg-black" />
      <div className="bg-[#f3f9ff]" dir={direction}>
        <div className="bg-[#f3f9ff] pt-14 hidden md:block">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 md:py-6">
            <form
              onSubmit={handleSearchSubmit}
              className="max-w-6xl mx-auto mb-8 p-5 sm:p-6 border-white rounded-[15px] bg-white/20 backdrop-blur-md shadow-2xl mt-[2rem] sm:mt-[4rem] md:mt-[1rem] flex flex-col lg:flex-row items-center justify-between gap-4 text-white"
            >
              <div className="flex items-start sm:items-center gap-3 flex-1 w-full lg:border-r lg:border-white/40 lg:pr-4 pb-4 lg:pb-0 relative">
                <span className="text-[40px] sm:text-xl md:text-2xl">🎉</span>
                <div className="w-full relative category-input-container">
                  <p className="font-semibold text-xs sm:text-sm md:text-base mb-2 text-black">{t('what_are_you_planning')}</p>
                  <input
                    type="text"
                    placeholder={t('enter_your_category')}
                    value={searchData.activity}
                    onChange={(e) => handleInputChange('activity', e.target.value)}
                    onFocus={() => {
                      if (searchData.activity.trim() !== '') {
                        const filtered = categories.filter(category =>
                          category.name && category.name.toLowerCase().includes(searchData.activity.toLowerCase())
                        );
                        setFilteredCategories(filtered);
                        setShowcategoryDropdown(true);
                      }
                    }}
                    className="bg-transparent placeholder-black/80 text-black focus:outline-none text-sm sm:text-base w-full border-b border-black/30 pb-2 focus:border-black/60 transition-colors lg:border-b-0"
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
                <span className="text-[40px] sm:text-[50px] md:text-[60px]">
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="black" className="size-6 sm:size-8 md:size-10">
                    <path fillRule="evenodd" d="m11.54 22.351.07.04.028.016a.76.76 0 0 0 .723 0l.028-.015.071-.041a16.975 16.975 0 0 0 1.144-.742 19.58 19.58 0 0 0 2.683-2.282c1.944-1.99 3.963-4.98 3.963-8.827a8.25 8.25 0 0 0-16.5 0c0 3.846 2.02 6.837 3.963 8.827a19.58 19.58 0 0 0 2.682 2.282 16.975 16.975 0 0 0 1.145.742ZM12 13.5a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z" clipRule="evenodd" />
                  </svg>
                </span>
                <div className="w-full relative location-input-container">
                  <p className="font-semibold text-xs sm:text-sm md:text-base mb-2 text-black">{t('where')}</p>
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
                    className="bg-transparent placeholder-black/80 text-black focus:outline-none text-sm sm:text-base w-full border-b border-black/30 pb-2 focus:border-black/60 transition-colors lg:border-b-0"
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
                          No cities found
                        </div>
                      )}
                    </div>
                  )}
                </div>
              </div>
              <div className="flex items-start sm:items-center gap-3 flex-1 w-full px-0 lg:px-4 pb-4 lg:pb-0">
                <span className="text-[40px] sm:text-[50px] md:text-[60px]">
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="black" className="size-6 sm:size-8 md:size-10">
                    <path d="M12.75 12.75a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM7.5 15.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5ZM8.25 17.25a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM9.75 15.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5ZM10.5 17.25a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM12 15.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5ZM12.75 17.25a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM14.25 15.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5ZM15 17.25a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM16.5 15.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5ZM15 12.75a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0ZM16.5 13.5a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Z" />
                    <path fillRule="evenodd" d="M6.75 2.25A.75.75 0 0 1 7.5 3v1.5h9V3A.75.75 0 0 1 18 3v1.5h.75a3 3 0 0 1 3 3v11.25a3 3 0 0 1-3 3H5.25a3 3 0 0 1-3-3V7.5a3 3 0 0 1 3-3H6V3a.75.75 0 0 1 .75-.75Zm13.5 9a1.5 1.5 0 0 0-1.5-1.5H5.25a1.5 1.5 0 0 0-1.5 1.5v7.5a1.5 1.5 0 0 0 1.5 1.5h13.5a1.5 1.5 0 0 0 1.5-1.5v-7.5Z" clipRule="evenodd" />
                  </svg>
                </span>
                <div className="w-full">
                  <p className="font-semibold text-xs sm:text-sm md:text-base mb-2 text-black">{t('when')}</p>
                  <input
                    type="text"
                    placeholder={t('anytime')}
                    value={searchData.date}
                    onChange={(e) => handleInputChange('date', e.target.value)}
                    className="bg-transparent placeholder-black/80 text-black focus:outline-none text-sm sm:text-base w-full border-b border-black/30 pb-2 focus:border-black/60 transition-colors lg:border-b-0"
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
        <div className="py-3 md:py-6">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-4 md:gap-6">
            <div className={`${showMapOnMobile ? 'hidden' : 'block'} lg:col-span-1 pl-2 md:pl-3`}>
              <div className="mb-4 md:mb-6">
                <h1 className="text-2xl md:text-3xl font-bold text-gray-900 mb-2">
                  {t('hotels_in')} {location || t('new_york')}
                </h1>
                <p className="text-gray-600 text-sm md:text-base">
                  {filteredResults.length} {t('results')} • {date || t('jul_14_21')}
                </p>
              </div>
              <div className="mb-4 md:mb-6">
                <div className="md:hidden flex items-center justify-between">
                  <button
                    onClick={() => setShowFilters(!showFilters)}
                    className="px-4 py-2 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors text-sm font-medium"
                  >
                    {t('filters')}
                  </button>
                  <div className="flex items-center space-x-2">
                    <span className="text-gray-600 text-sm font-medium">{t('sort_by')}:</span>
                    <select
                      value={filters.sortBy}
                      onChange={(e) => handleFilterChange('sortBy', e.target.value)}
                      className={`text-sm border rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 ${filters.sortBy !== 'relevance'
                          ? 'bg-blue-100 border-blue-300 text-blue-700'
                          : 'bg-white border-gray-300 text-gray-700'
                        }`}
                    >
                      <option value="relevance">{t('relevance')}</option>
                      <option value="price-low">{t('price_low_to_high')}</option>
                      <option value="price-high">{t('price_high_to_low')}</option>
                      <option value="rating">{t('rating')}</option>
                    </select>
                    {filters.sortBy !== 'relevance' && (
                      <button
                        onClick={() => handleFilterChange('sortBy', 'relevance')}
                        className="text-blue-600 hover:text-blue-800 text-sm font-bold"
                        title="Clear sorting"
                      >
                        ×
                      </button>
                    )}
                  </div>
                </div>
                {/* Desktop View - Full Filter Options */}
                <div className="hidden md:block">
                  <div className="flex items-center justify-between">
                    <div className="flex items-center space-x-1 md:space-x-2 overflow-x-auto flex-1">
                      <button
                        onClick={() => setShowFilters(!showFilters)}
                        className="px-3 md:px-4 py-2 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors text-xs md:text-sm whitespace-nowrap flex-shrink-0"
                      >
                        {t('filters')}
                      </button>
                      <button
                        onClick={() => {
                          if (filters.priceRange) {
                            setFilters(prev => ({ ...prev, priceRange: '' }));
                          } else {
                            setShowFilters(true);
                          }
                        }}
                        className={`px-3 md:px-4 py-2 border rounded-lg transition-colors text-xs md:text-sm whitespace-nowrap flex-shrink-0 ${filters.priceRange ? 'bg-blue-100 border-blue-300 text-blue-700' : 'bg-white border-gray-300 hover:bg-gray-50'
                          }`}
                      >
                        {t('price')} {filters.priceRange && `(${filters.priceRange})`}
                      </button>
                      <button
                        onClick={() => {
                          if (filters.guests) {
                            setFilters(prev => ({ ...prev, guests: '' }));
                          } else {
                            setShowFilters(true);
                          }
                        }}
                        className={`px-3 md:px-4 py-2 border rounded-lg transition-colors text-xs md:text-sm whitespace-nowrap flex-shrink-0 ${filters.guests ? 'bg-blue-100 border-blue-300 text-blue-700' : 'bg-white border-gray-300 hover:bg-gray-50'
                          }`}
                      >
                        {t('guests')} {filters.guests && `(${filters.guests})`}
                      </button>
                      <button
                        onClick={() => setShowFilters(!showFilters)}
                        className="px-3 md:px-4 py-2 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors text-xs md:text-sm whitespace-nowrap flex-shrink-0"
                      >
                        {t('more')}
                      </button>
                      {/* View Toggle Buttons */}
                      <div className="flex items-center border border-gray-300 rounded-lg overflow-hidden ml-2">
                        <button
                          onClick={() => setViewMode('list')}
                          className={`px-3 py-2 text-xs md:text-sm transition-colors ${viewMode === 'list'
                              ? 'bg-blue-600 text-white'
                              : 'bg-white text-gray-600 hover:bg-gray-50'
                            }`}
                        >
                          📋 {t('list')}
                        </button>
                        <button
                          onClick={() => setViewMode('grid')}
                          className={`px-3 py-2 text-xs md:text-sm transition-colors ${viewMode === 'grid'
                              ? 'bg-blue-600 text-white'
                              : 'bg-white text-gray-600 hover:bg-gray-50'
                            }`}
                        >
                          🔲 {t('grid')}
                        </button>
                      </div>
                    </div>
                    <div className="flex items-center space-x-1 md:space-x-2">
                      <span className="text-gray-600 text-xs md:text-sm font-medium">{t('sort_by')}:</span>
                      <select
                        value={filters.sortBy}
                        onChange={(e) => handleFilterChange('sortBy', e.target.value)}
                        className={`text-xs md:text-sm border rounded-lg px-2 py-1 focus:outline-none focus:ring-2 focus:ring-blue-500 ${filters.sortBy !== 'relevance'
                            ? 'bg-blue-100 border-blue-300 text-blue-700'
                            : 'bg-white border-gray-300 text-gray-700'
                          }`}
                      >
                        <option value="relevance">{t('relevance')}</option>
                        <option value="price-low">{t('price_low_to_high')}</option>
                        <option value="price-high">{t('price_high_to_low')}</option>
                        <option value="rating">{t('rating')}</option>
                      </select>
                      {filters.sortBy !== 'relevance' && (
                        <button
                          onClick={() => handleFilterChange('sortBy', 'relevance')}
                          className="ml-1 text-blue-600 hover:text-blue-800 text-xs"
                          title="Clear sorting"
                        >
                          ×
                        </button>
                      )}
                    </div>
                  </div>
                </div>
              </div>
              {/* Filter Summary */}
              {(filters.priceRange || filters.rating || filters.amenities.length > 0 || filters.hotelType || filters.roomType || filters.guests || filters.distance || filters.sortBy !== 'relevance') && (
                <div className="mb-4 p-3 bg-blue-50 border border-blue-200 rounded-lg">
                  <div className="flex items-center justify-between">
                    <span className="text-sm font-medium text-blue-800">{t('active_filters')}:</span>
                    <button
                      onClick={() => {
                        setFilters({
                          priceRange: '',
                          rating: '',
                          amenities: [],
                          sortBy: 'relevance',
                          hotelType: '',
                          roomType: '',
                          guests: '',
                          distance: ''
                        });
                      }}
                      className="text-xs text-blue-600 hover:text-blue-800 underline"
                    >
                      Clear All
                    </button>
                  </div>
                  <div className="flex flex-wrap gap-2 mt-2">
                    {filters.priceRange && (
                      <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                        {t('price')}: {filters.priceRange}
                        <button
                          onClick={() => setFilters(prev => ({ ...prev, priceRange: '' }))}
                          className="ml-1 text-blue-600 hover:text-blue-800"
                        >
                          ×
                        </button>
                      </span>
                    )}
                    {filters.rating && (
                      <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                        {t('rating')}: {filters.rating}+
                        <button
                          onClick={() => setFilters(prev => ({ ...prev, rating: '' }))}
                          className="ml-1 text-blue-600 hover:text-blue-800"
                        >
                          ×
                        </button>
                      </span>
                    )}
                    {filters.hotelType && (
                      <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                        {t('type')}: {filters.hotelType}
                        <button
                          onClick={() => setFilters(prev => ({ ...prev, hotelType: '' }))}
                          className="ml-1 text-blue-600 hover:text-blue-800"
                        >
                          ×
                        </button>
                      </span>
                    )}
                    {filters.roomType && (
                      <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                        {t('room')}: {filters.roomType}
                        <button
                          onClick={() => setFilters(prev => ({ ...prev, roomType: '' }))}
                          className="ml-1 text-blue-600 hover:text-blue-800"
                        >
                          ×
                        </button>
                      </span>
                    )}
                    {filters.guests && (
                      <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                        {t('guests')}: {filters.guests}
                        <button
                          onClick={() => setFilters(prev => ({ ...prev, guests: '' }))}
                          className="ml-1 text-blue-600 hover:text-blue-800"
                        >
                          ×
                        </button>
                      </span>
                    )}
                    {filters.distance && (
                      <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                        {t('distance')}: {filters.distance}
                        <button
                          onClick={() => setFilters(prev => ({ ...prev, distance: '' }))}
                          className="ml-1 text-blue-600 hover:text-blue-800"
                        >
                          ×
                        </button>
                      </span>
                    )}
                    {filters.sortBy !== 'relevance' && (
                      <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                        {t('sort')}: {filters.sortBy === 'price-low' ? t('price_low_to_high') :
                          filters.sortBy === 'price-high' ? t('price_high_to_low') :
                            filters.sortBy === 'rating' ? t('rating') : filters.sortBy}
                        <button
                          onClick={() => setFilters(prev => ({ ...prev, sortBy: 'relevance' }))}
                          className="ml-1 text-blue-600 hover:text-blue-800"
                        >
                          ×
                        </button>
                      </span>
                    )}
                    {filters.amenities.length > 0 && filters.amenities.map((amenity, index) => (
                      <span key={index} className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                        {amenity}
                        <button
                          onClick={() => setFilters(prev => ({
                            ...prev,
                            amenities: prev.amenities.filter(a => a !== amenity)
                          }))}
                          className="ml-1 text-blue-600 hover:text-blue-800"
                        >
                          ×
                        </button>
                      </span>
                    ))}
                  </div>
                </div>
              )}
              {/* Error Display */}
              {error && (
                <div className="bg-red-50 border border-red-200 rounded-lg p-3 md:p-4 mb-4">
                  <div className="flex">
                    <div className="flex-shrink-0">
                      <span className="text-red-400">⚠️</span>
                    </div>
                    <div className="ml-3">
                      <h3 className="text-sm font-medium text-red-800">{t('error')}</h3>
                      <div className="mt-2 text-sm text-red-700">
                        {error}
                      </div>
                    </div>
                  </div>
                </div>
              )}
              {/* Hotel Results */}
              <div className={viewMode === 'grid' ? 'grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-6' : 'space-y-3 md:space-y-4'}>
                {filteredResults.map((hotel) => (
                  <div
                    key={hotel.id}
                    className={`bg-white rounded-lg shadow-sm border hover:shadow-md transition-shadow cursor-pointer relative ${viewMode === 'grid' ? 'h-full' : ''
                      }`}
                  >
                    <button
                      onClick={(e) => toggleWishlist(hotel.id, e)}
                      className="absolute top-3 md:top-4 right-3 md:right-4 bg-white p-2 rounded-full shadow-md hover:shadow-lg transition-shadow duration-200 z-10"
                      title={whitelistedHotels.has(hotel.id) ? t("remove_from_favorites") : t("add_to_favorites")}
                    >
                      {whitelistedHotels.has(hotel.id) ? (
                        <FaHeart className="w-4 h-4 md:w-5 md:h-5 text-red-500" />
                      ) : (
                        <FaRegHeart className="w-4 h-4 md:w-5 md:h-5 text-gray-600 hover:text-red-500 transition-colors duration-200" />
                      )}
                    </button>
                    <div className={viewMode === 'grid' ? 'p-3 md:p-4 h-full flex flex-col' : 'p-4 md:p-6'} onClick={() => handleHotelClick(hotel.id)}>
                      <div className={viewMode === 'grid' ? 'flex flex-col gap-3' : 'flex flex-col sm:flex-row gap-3 md:gap-4'}>
                        <div className={`${viewMode === 'grid' ? 'w-full h-48' : 'w-full sm:w-48 h-48'} flex-shrink-0 relative`}>
                          <img
                            src={getHotelImages(hotel)[0]}
                            alt={hotel.name}
                            className="w-full h-full object-cover rounded-lg"
                            onError={(e) => {
                              e.target.style.display = 'none';
                              e.target.nextElementSibling.classList.remove('hidden');
                            }}
                          />
                          <div className="w-full h-full bg-gradient-to-br from-blue-100 to-blue-200 rounded-lg flex items-center justify-center hidden">
                            <div className="text-center">
                              <div className="text-4xl mb-2">🏨</div>
                              <div className="text-xs text-gray-500 mt-1">
                                {/* {getHotelImages(hotel)[0]  } */}
                              </div>
                            </div>
                          </div>
                        </div>
                        <div className={`${viewMode === 'grid' ? 'flex-1 flex flex-col' : 'flex-1 min-w-0'}`}>
                          <h3 className={`${viewMode === 'grid' ? 'text-sm md:text-base' : 'text-base md:text-lg'} font-bold text-gray-900 mb-2`}>
                            {hotel.name}
                          </h3>
                          <p className="text-gray-600 text-xs md:text-sm mb-2">
                            {hotel.location}
                          </p>
                          {hotel.category && (
                            <div className="inline-block bg-blue-100 text-blue-800 px-2 py-1 rounded-full text-xs font-medium mb-2">
                              {hotel.category}
                            </div>
                          )}
                          {viewMode === 'list' && (
                            <div className="flex flex-wrap gap-1 md:gap-2 mb-2 md:mb-3">
                              {hotel.amenities && hotel.amenities.length > 0 ? (
                                hotel.amenities.slice(0, 6).map((amenity, index) => (
                                  <span key={index} className="text-gray-500 text-xs">
                                    {amenity}
                                    {index < hotel.amenities.length - 1 && index < 5 ? ' • ' : ''}
                                  </span>
                                ))
                              ) : (
                                <span className="text-gray-400 text-xs">No amenities listed</span>
                              )}
                            </div>
                          )}
                          <div className="inline-block bg-green-100 text-green-800 px-2 md:px-3 py-1 rounded-full text-xs md:text-sm font-medium mb-2 md:mb-3">
                            {hotel.roomCount || 0} {t('rooms_available')}
                          </div>
                          <div className={`${viewMode === 'grid' ? 'mt-auto' : ''} flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2 md:gap-3`}>
                            <div className="flex items-center space-x-2 min-w-0">
                              <div className="flex items-center">
                                {[...Array(5)].map((_, i) => (
                                  <span
                                    key={i}
                                    className={i < (hotel.stars || 4) ? "text-[#2B67F6]" : "text-gray-300"}
                                  >
                                    ★
                                  </span>
                                ))}
                                <span className="text-gray-700 font-medium ml-1 text-sm md:text-base">
                                  {hotel.stars || '4.0'}
                                </span>
                              </div>
                            </div>
                            <div className="text-xl md:text-[24px] font-bold text-gray-900 flex-shrink-0">
                              ${parseFloat(hotel.price.replace(/[^0-9.]/g, '')).toFixed(0)}
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
              {/* No Results */}
              {filteredResults.length === 0 && (
                <div className="text-center py-8 md:py-12">
                  <div className="text-gray-400 text-4xl md:text-6xl mb-4">🔍</div>
                  <h3 className="text-base md:text-lg font-medium text-gray-900 mb-2">{t('no_results_found')}</h3>
                  <p className="text-gray-600 mb-4 md:mb-6 text-sm md:text-base">
                    {t('try_adjusting_search_criteria')}
                  </p>
                  <button
                    onClick={() => navigate('/')}
                    className="bg-green-500 text-white px-4 md:px-6 py-2 md:py-2 rounded-lg hover:bg-green-600 transition-colors text-sm md:text-base"
                  >
                    Back to Home
                  </button>
                </div>
              )}
              {/* Pagination */}
              {pagination.last_page > 1 && (
                <div className="mt-6 md:mt-8 flex justify-center">
                  <nav className="flex items-center space-x-1 md:space-x-2">
                    <button
                      onClick={() => handlePageChange(pagination.current_page - 1)}
                      disabled={pagination.current_page === 1}
                      className="px-2 md:px-3 py-2 text-xs md:text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
                    >
                      Previous
                    </button>
                    {Array.from({ length: pagination.last_page }, (_, i) => i + 1).map((page) => (
                      <button
                        key={page}
                        onClick={() => handlePageChange(page)}
                        className={`px-2 md:px-3 py-2 text-xs md:text-sm font-medium rounded-md ${page === pagination.current_page
                          ? 'bg-green-500 text-white'
                          : 'text-gray-500 bg-white border border-gray-300 hover:bg-gray-50'
                          }`}
                      >
                        {page}
                      </button>
                    ))}
                    <button
                      onClick={() => handlePageChange(pagination.current_page + 1)}
                      disabled={pagination.current_page === pagination.last_page}
                      className="px-2 md:px-3 py-2 text-xs md:text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
                    >
                      Next
                    </button>
                  </nav>
                </div>
              )}
            </div>
            {/* Map Section */}
            <div className={`${showMapOnMobile ? 'block' : 'hidden'} lg:block lg:col-span-1`}>
              <div className="border sticky top-8">
                <div className="bg-gray-200 rounded-lg relative overflow-hidden" style={{ height: '100vh', width: '100%' }}>
                  <div ref={mapRef} className="w-full h-full">
                    <div className="w-full h-full bg-gradient-to-br from-blue-100 to-blue-200 flex items-center justify-center">
                      <div className="text-center">
                        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-2"></div>
                        <p className="text-gray-600 text-sm">Loading Map...</p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        {/* Floating Map Toggle Button - Mobile Only */}
        <div className="lg:hidden fixed bottom-6 right-6 z-50">
          <button
            onClick={() => setShowMapOnMobile(!showMapOnMobile)}
            className="bg-blue-600 text-white p-4 rounded-full shadow-lg hover:bg-blue-700 transition-colors"
            aria-label={showMapOnMobile ? t("show_results") : t("show_map")}
          >
            {showMapOnMobile ? (
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="w-6 h-6">
                <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 18L9 11.25l4.306 4.307a11.95 11.95 0 015.814-5.519l2.74-1.22m0 0l-5.94-2.28m5.94 2.28l-2.28 5.941" />
              </svg>
            ) : (
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="w-6 h-6">
                <path strokeLinecap="round" strokeLinejoin="round" d="M9 6.75V15m6-6v8.25m.503 3.498l4.875-2.437c.381-.19.622-.58.622-1.006V4.82c0-.836-.88-1.38-1.628-1.006l-3.869 1.934c-.317.159-.69.159-1.006 0L9.503 3.252a1.125 1.125 0 00-1.006 0L3.622 5.689C3.24 5.88 3 6.27 3 6.695V19.18c0 .836.88 1.38 1.628 1.006l3.869-1.934c.317-.159.69-.159 1.006 0l4.994 2.497c.317.158.69.158 1.006 0z" />
              </svg>
            )}
          </button>
        </div>
        {/* Filter Modal */}
        {showFilters && (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
            <div className="bg-white rounded-lg max-w-2xl w-full max-h-[90vh] overflow-y-auto">
              <div className="p-6">
                <div className="flex items-center justify-between mb-6">
                  <h3 className="text-lg font-semibold">Filters</h3>
                  <button
                    onClick={() => setShowFilters(false)}
                    className="text-gray-400 hover:text-gray-600"
                  >
                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                    </svg>
                  </button>
                </div>
                {/* Price Range */}
                <div className="mb-6">
                  <h4 className="font-medium mb-3">Price Range</h4>
                  <div className="grid grid-cols-2 md:grid-cols-3 gap-2">
                    {priceRanges.map((range) => (
                      <button
                        key={range.value}
                        onClick={() => handleFilterChange('priceRange', range.value)}
                        className={`px-3 py-2 text-sm rounded-lg border transition-colors ${filters.priceRange === range.value
                          ? 'bg-blue-100 border-blue-300 text-blue-700'
                          : 'bg-white border-gray-300 hover:bg-gray-50'
                          }`}
                      >
                        {range.label}
                      </button>
                    ))}
                  </div>
                </div>
                {/* Hotel Type */}
                <div className="mb-6">
                  <h4 className="font-medium mb-3">{t('hotel_type')}</h4>
                  <div className="grid grid-cols-2 md:grid-cols-3 gap-2">
                    {hotelTypes.map((type) => (
                      <button
                        key={type.value}
                        onClick={() => handleFilterChange('hotelType', type.value)}
                        className={`px-3 py-2 text-sm rounded-lg border transition-colors ${filters.hotelType === type.value
                          ? 'bg-blue-100 border-blue-300 text-blue-700'
                          : 'bg-white border-gray-300 hover:bg-gray-50'
                          }`}
                      >
                        {type.label}
                      </button>
                    ))}
                  </div>
                </div>
                {/* Room Type */}
                <div className="mb-6">
                  <h4 className="font-medium mb-3">{t('room_type')}</h4>
                  <div className="grid grid-cols-2 md:grid-cols-3 gap-2">
                    {roomTypes.map((type) => (
                      <button
                        key={type.value}
                        onClick={() => handleFilterChange('roomType', type.value)}
                        className={`px-3 py-2 text-sm rounded-lg border transition-colors ${filters.roomType === type.value
                          ? 'bg-blue-300 text-blue-700'
                          : 'bg-white border-gray-300 hover:bg-gray-50'
                          }`}
                      >
                        {type.label}
                      </button>
                    ))}
                  </div>
                </div>
                {/* Guests */}
                <div className="mb-6">
                  <h4 className="font-medium mb-3">{t('number_of_guests')}</h4>
                  <div className="grid grid-cols-3 md:grid-cols-5 gap-2">
                    {guestOptions.map((guests) => (
                      <button
                        key={guests}
                        onClick={() => handleFilterChange('guests', guests)}
                        className={`px-3 py-2 text-sm rounded-lg border transition-colors ${filters.guests === guests
                          ? 'bg-blue-100 border-blue-300 text-blue-700'
                          : 'bg-white border-gray-300 hover:bg-gray-50'
                          }`}
                      >
                        {guests}
                      </button>
                    ))}
                  </div>
                </div>
                {/* Distance */}
                <div className="mb-6">
                  <h4 className="font-medium mb-3">{t('distance')}</h4>
                  <div className="grid grid-cols-3 md:grid-cols-5 gap-2">
                    {distanceOptions.map((distance) => (
                      <button
                        key={distance}
                        onClick={() => handleFilterChange('distance', distance)}
                        className={`px-3 py-2 text-sm rounded-lg border transition-colors ${filters.distance === distance
                          ? 'bg-blue-100 border-blue-300 text-blue-700'
                          : 'bg-white border-gray-300 hover:bg-gray-50'
                          }`}
                      >
                        {distance}
                      </button>
                    ))}
                  </div>
                </div>
                {/* Rating */}
                <div className="mb-6">
                  <h4 className="font-medium mb-3">{t('minimum_rating')}</h4>
                  <div className="grid grid-cols-5 gap-2">
                    {ratingOptions.map((rating) => (
                      <button
                        key={rating}
                        onClick={() => handleFilterChange('rating', rating)}
                        className={`px-3 py-2 text-sm rounded-lg border transition-colors ${filters.rating === rating
                          ? 'bg-blue-100 border-blue-300 text-blue-700'
                          : 'bg-white border-gray-300 hover:bg-gray-50'
                          }`}
                      >
                        {rating}+
                      </button>
                    ))}
                  </div>
                </div>
                {/* Amenities */}
                <div className="mb-6">
                  <h4 className="font-medium mb-3">{t('amenities')}</h4>
                  <div className="grid grid-cols-2 md:grid-cols-3 gap-2">
                    {[
                      { label: t('free_wifi'), value: 'Free Wi-Fi' },
                      { label: t('swimming_pool'), value: 'Swimming Pool' },
                      { label: t('fitness_center'), value: 'Fitness Center' },
                      { label: t('restaurant'), value: 'Restaurant' },
                      { label: t('air_conditioning'), value: 'Air Conditioning' },
                      { label: t('24_hour_front_desk'), value: '24-Hour Front Desk' },
                      { label: t('parking'), value: 'Parking' },
                      { label: t('spa'), value: 'Spa' }
                    ].map((amenity) => (
                      <button
                        key={amenity.value}
                        onClick={() => {
                          if (filters.amenities.includes(amenity.value)) {
                            handleFilterChange('amenities', filters.amenities.filter(a => a !== amenity.value));
                          } else {
                            handleFilterChange('amenities', [...filters.amenities, amenity.value]);
                          }
                        }}
                        className={`px-3 py-2 text-sm rounded-lg border transition-colors ${filters.amenities.includes(amenity.value)
                          ? 'bg-blue-100 border-blue-300 text-blue-700'
                          : 'bg-white border-gray-300 hover:bg-gray-50'
                          }`}
                      >
                        {amenity.label}
                      </button>
                    ))}
                  </div>
                </div>
                {/* Action Buttons */}
                <div className="flex gap-3 pt-4 border-t">
                  <button
                    onClick={() => {
                      setFilters({
                        priceRange: '',
                        rating: '',
                        amenities: [],
                        sortBy: 'relevance',
                        hotelType: '',
                        roomType: '',
                        guests: '',
                        distance: ''
                      });
                    }}
                    className="flex-1 px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
                  >
                    {t('clear_all')}
                  </button>
                  <button
                    onClick={() => setShowFilters(false)}
                    className="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
                  >
                    {t('apply_filters')}
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}
        {/* Login Modal */}
        {showLogin && (
          <div
            className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
            onClick={(e) => {
              if (e.target === e.currentTarget) {
                setShowLogin(false);
              }
            }}
          >
            <Login
              setShowLogin={setShowLogin}
              setShowSignUp={(show) => {
                if (show) {
                  setShowSignUp(true);
                  setShowLogin(false);
                }
              }}
              onAuthSuccess={handleAuthStateChange}
            />
          </div>
        )}
        {/* Signup Modal */}
        {showSignUp && (
          <div
            className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
            onClick={(e) => {
              if (e.target === e.currentTarget) {
                setShowSignUp(false);
              }
            }}
          >
            <Signup
              setShowSignUp={setShowSignUp}
              setShowLogin={(show) => {
                if (show) {
                  setShowLogin(true);
                  setShowSignUp(false);
                }
              }}
              onAuthSuccess={handleAuthStateChange}
            />
          </div>
        )}
      </div>
    </>
  );
};
