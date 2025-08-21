import React, { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from './AuthContext'
import { DashboardLayout } from './DashboardLayout'
import { 
  FaHeart,
  FaEye,
  FaHotel
} from 'react-icons/fa'
export const Favorites = () => {
  const { user, authLoading } = useAuth();
  const [whitelistedHotels, setWhitelistedHotels] = useState([]);
  const [loadingWhitelist, setLoadingWhitelist] = useState(true);
  const [hotelsData, setHotelsData] = useState({});
  const API_BASE_URL =
    window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
      ? import.meta.env.VITE_API_BASE_URL_LOCAL
      : import.meta.env.VITE_API_BASE_URL;
  const fetchHotelData = async (hotelIds) => {
    try {
      const routesResponse = await fetch(`${API_BASE_URL}/api/routes`);
      const routes = await routesResponse.json();
      const hotelsResponse = await fetch(routes.hotelsFilterByBounds);
      const hotelsData = await hotelsResponse.json();
      if (hotelsData.success && hotelsData.hotels) {
        const hotelsMap = {};
        hotelsData.hotels.forEach(hotel => {
          if (hotelIds.includes(hotel.id)) {
            hotelsMap[hotel.id] = hotel;
          }
        });
        setHotelsData(hotelsMap);
      }
    } catch (error) {
      console.error('Error fetching hotel data:', error);
    }
  };
  const getHotelImage = (hotel) => {
    if (hotel.hotel_galleries && hotel.hotel_galleries.length > 0) {
      return `/assets/img/hotel/hotel-gallery/${hotel.hotel_galleries[0].image}`;
    }
    if (hotel.logo) {
      return `/assets/img/hotel/logo/${hotel.logo}`;
    }
    return '/images/room1.jpg';
  };
  const getHotelTitle = (hotel) => {
    return hotel.title || hotel.name || 'Meeting Space Hire';
  };
  const fetchWhitelistedItems = () => {
    try {
      if (user && user.id) {
        const userId = user.id;
        const hotelKey = `whitelisted_hotels_${userId}`;
        const storedHotels = localStorage.getItem(hotelKey);
        if (storedHotels) {
          try {
            const hotelsArray = JSON.parse(storedHotels);
            if (Array.isArray(hotelsArray) && hotelsArray.length > 0) {
              setWhitelistedHotels(hotelsArray);
              fetchHotelData(hotelsArray);
            } else {
              setWhitelistedHotels([]);
            }
          } catch (e) {
            setWhitelistedHotels([]);
          }
        } else {
          setWhitelistedHotels([]);
        }
      } else {
        setWhitelistedHotels([]);
      }
    } catch (error) {
      setWhitelistedHotels([]);
    } finally {
      setLoadingWhitelist(false);
    }
  };
  useEffect(() => {
    if (user && !authLoading) {
      fetchWhitelistedItems();
    }
  }, [user, authLoading]);
  return (
    <DashboardLayout title="My Favorites" showRefresh={true} onRefresh={fetchWhitelistedItems}>
      {loadingWhitelist ? (
        <div className="flex justify-center items-center py-16">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      ) : (
        <div className="space-y-8">
          <div className="">
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-2xl font-bold text-gray-800 flex items-center">
                <FaHotel className="mr-3 text-blue-600" />
                Favorite Hotels ({whitelistedHotels.length})
              </h2>
            </div>
            {whitelistedHotels.length === 0 ? (
              <div className="text-center py-12">
                <FaHeart className="mx-auto text-gray-300 text-6xl mb-4" />
                <p className="text-gray-500 text-lg mb-2">No favorite hotels yet</p>
                <p className="text-gray-400">Start exploring and add hotels to your favorites!</p>
                <Link 
                  to="/" 
                  className="inline-block mt-4 px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
                >
                  Explore Hotels
                </Link>
              </div>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                {whitelistedHotels.map((hotelId) => {
                  const hotel = hotelsData[hotelId];
                  return (
                    <div key={hotelId} className=" rounded-lg overflow-hidden">
                      <div className="h-[174.9771728515625px] w-[310.58447265625px] relative">
                        <img
                          src={hotel ? getHotelImage(hotel) : '/images/room1.jpg'}
                          alt={hotel ? getHotelTitle(hotel) : `Hotel #${hotelId}`}
                          className="w-[310.58447265625px] h-[174.9771728515625px] object-cover rounded-lg"
                          style={{ borderRadius: '8px' }}
                          onError={(e) => {
                            e.target.src = '/images/room1.jpg';
                          }}
                        />
                        <div className="absolute top-2 right-2 bg-white p-2 rounded-full shadow-md">
                          <FaHeart className="w-4 h-4 text-red-500" />
                        </div>
                      </div>
                      <div className="p-4">
                        <h3 className="font-semibold text-gray-800 mb-1">
                          {hotel ? getHotelTitle(hotel) : `Hotel #${hotelId}`}
                        </h3>
                        <p className="text-gray-600 mb-2 text-sm">
                          {hotel?.categoryName || 'Hotel'}
                        </p>
                        {hotel?.city_name && (
                          <p className="text-gray-500 text-sm mb-3">
                            📍 {hotel.city_name}{hotel?.state_name && `, ${hotel.state_name}`}
                          </p>
                        )}
                        <Link 
                          to={`/hotels/${hotelId}`}
                          className="inline-flex items-center text-blue-600 hover:text-blue-700 text-sm font-medium"
                        >
                          <FaEye className="mr-1" />
                          View Details
                        </Link>
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </div>
        </div>
      )}
    </DashboardLayout>
  )
}