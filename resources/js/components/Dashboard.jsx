import React, { useState, useEffect, useCallback } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from './AuthContext'
import { DashboardLayout } from './DashboardLayout'
import {
  FaSearch,
  FaBell,
  FaFileAlt,
  FaHeart,
  FaEye,
  FaHotel,
  FaBed,
  FaCalendarAlt,
  FaBookmark,
  FaStar,
  FaComments
} from 'react-icons/fa'

export const Dashboard = ({
  logoText = "Peerspace",
  logoColor = "bg-green-500",
  logoIcon = null
}) => {
  const { user, loading } = useAuth();
  const [generalSettings, setGeneralSettings] = useState(null);
  const [dashboardStats, setDashboardStats] = useState(null);
  const [recentBookings, setRecentBookings] = useState([]);
  const [dashboardWishlists, setDashboardWishlists] = useState({ hotel_wishlists: [], room_wishlists: [] });
  const [loadingStats, setLoadingStats] = useState(true);
  const [errorStats, setErrorStats] = useState(null);
  const [isRefreshing, setIsRefreshing] = useState(false);
  const [lastUpdated, setLastUpdated] = useState(null);
  
  const API_BASE_URL =
    window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
      ? import.meta.env.VITE_API_BASE_URL_LOCAL
      : import.meta.env.VITE_API_BASE_URL;

  const fetchBasicImages = useCallback(async () => {
    try {
      const response = await fetch(`${API_BASE_URL}/api/basic-images`);
      const data = await response.json();
      if (data && data.logo) {
        setGeneralSettings(data);
      }
    } catch (error) {
      console.error('Error fetching basic images:', error);
    }
  }, [API_BASE_URL]);

  const fetchDashboardStats = useCallback(async () => {
    try {
      setLoadingStats(true);
      setErrorStats(null);
      console.log('Fetching dashboard stats...');
      
      // Get JWT token from localStorage
      const token = localStorage.getItem('jwt_token');
      if (!token) {
        console.error('No JWT token found');
        setErrorStats('Authentication token not found');
        setLoadingStats(false);
        return;
      }
      
      // Use simple endpoint with JWT authentication
      const response = await fetch(`${API_BASE_URL}/api/user/dashboard/simple`, {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
      });
      
      console.log('Simple endpoint response status:', response.status);
      
      if (response.ok) {
        const data = await response.json();
        console.log('Dashboard data:', data);
        setDashboardStats(data.stats);
        setRecentBookings(data.recent_bookings || []);
        setDashboardWishlists({
          hotel_wishlists: data.hotel_wishlists || [],
          room_wishlists: []
        });
      } else {
        const errorText = await response.text();
        console.error('Dashboard response error:', errorText);
        setErrorStats('Failed to fetch dashboard data');
      }
    } catch (error) {
      console.error('Error fetching dashboard data:', error);
      setErrorStats('Error fetching dashboard data');
    } finally {
      setLoadingStats(false);
    }
  }, [API_BASE_URL]);

  // Remove the other fetch functions since we get all data from one endpoint

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
        // setHotelsData(hotelsMap); // This state was removed, so this line is removed
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
    // Use a data URI for a simple placeholder instead of a missing file
    return 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzEwIiBoZWlnaHQ9IjE3NSIgdmlld0JveD0iMCAwIDMxMCAxNzUiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIzMTAiIGhlaWdodD0iMTc1IiBmaWxsPSIjRjNGNEY2Ii8+CjxwYXRoIGQ9Ik0xNTUgODcuNUwxNjUgOTcuNUwxNTUgMTA3LjVMMTQ1IDk3LjVMMTU1IDg3LjVaIiBmaWxsPSIjOUI5QkEwIi8+Cjx0ZXh0IHg9IjE1NSIgeT0iMTMwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjOUI5QkEwIiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMTQiPkltYWdlPC90ZXh0Pgo8dGV4dCB4PSIxNTUiIHk9IjE0OCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzlCOUJBMCIgZm9udC1mYW1pbHk9IkFyaWFsIiBmb250LXNpemU9IjEyIj5Ob3QgQXZhaWxhYmxlPC90ZXh0Pgo8L3N2Zz4K';
  };

  const getHotelTitle = (hotel) => {
    return hotel.title || hotel.name || 'Meeting Space Hire';
  };

  const getStatusBadge = (status) => {
    switch (status) {
      case 'confirmed':
      case 'approved':
        return 'bg-green-100 text-green-800';
      case 'pending':
        return 'bg-yellow-100 text-yellow-800';
      case 'cancelled':
      case 'rejected':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };

  const getStatusText = (status) => {
    switch (status) {
      case 'confirmed':
      case 'approved':
        return 'Confirmed';
      case 'pending':
        return 'Pending';
      case 'cancelled':
      case 'rejected':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  };

  useEffect(() => {
    fetchBasicImages();
    console.log('Dashboard mounted, API_BASE_URL:', API_BASE_URL);
    console.log('localStorage contents:', {
      user: localStorage.getItem('user'),
      jwt_token: localStorage.getItem('jwt_token') ? 'Present' : 'Missing',
      vendor_id: localStorage.getItem('vendor_id')
    });
    
    // Check if we're on the user dashboard page
    if (window.location.pathname.includes('/user/dashboard')) {
      console.log('On user dashboard page - user should be authenticated via web session');
    }
    
    // Test authentication by trying to access a simple endpoint
    fetch(`${API_BASE_URL}/api/user/auth-status`)
      .then(response => response.json())
      .then(data => {
        console.log('Auth status check:', data);
        if (data.success && data.authenticated && data.user) {
          console.log('User is authenticated via session:', data.user);
        } else {
          console.log('User is not authenticated via session');
        }
      })
      .catch(error => {
        console.error('Auth status check failed:', error);
      });
    
    // Test the new auth test endpoint
    fetch(`${API_BASE_URL}/api/user/test-auth`)
      .then(response => response.json())
      .then(data => {
        console.log('Auth test result:', data);
      })
      .catch(error => {
        console.error('Auth test failed:', error);
      });
    
    // Force refresh data after a short delay to ensure everything is loaded
    setTimeout(() => {
      console.log('Force refreshing dashboard data...');
      Promise.all([
        fetchDashboardStats()
      ]).then(() => {
        setLastUpdated(new Date());
      });
    }, 1000);
  }, []);

  useEffect(() => {
    if (user && !loading) {
      console.log('User authenticated, fetching dashboard data...', { user, loading });
      fetchDashboardStats().then(() => {
        setLastUpdated(new Date());
      });
    } else if (!user && !loading) {
      // Try to get user from localStorage as fallback
      const storedUser = localStorage.getItem('user');
      if (storedUser) {
        try {
          const userData = JSON.parse(storedUser);
          console.log('Found user in localStorage:', userData);
          // Try to fetch data anyway
          fetchDashboardStats().then(() => {
            setLastUpdated(new Date());
          });
        } catch (e) {
          console.error('Error parsing stored user data:', e);
        }
      } else {
        console.log('No user found in localStorage');
      }
    } else {
      console.log('User not ready yet:', { user, loading });
    }
  }, [user, loading, fetchDashboardStats]);

  // Redirect to homepage if user is not authenticated
  if (!user && !loading) {
    window.location.href = '/';
    return null;
  }

  return (
    <DashboardLayout title="Dashboard">
      {/* Welcome Message */}
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-800 mb-2">
          Welcome back, {user?.name || user?.username || 'User'}! 👋
        </h1>
        <p className="text-gray-600">
          Here's what's happening with your account today.
        </p>
        {lastUpdated && (
          <p className="text-sm text-gray-500 mt-2">
            Last updated: {lastUpdated.toLocaleString()}
          </p>
        )}
      </div>

      <div className="flex items-center justify-between mb-8">
        <div className="relative">
          <FaSearch className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400" />
          <input
            type="text"
            placeholder="Search"
            className="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          />
        </div>
        <div className="flex items-center space-x-4">
          <button
            onClick={async () => {
              setIsRefreshing(true);
              try {
                await Promise.all([
                  fetchDashboardStats()
                ]);
                setLastUpdated(new Date());
              } finally {
                setIsRefreshing(false);
              }
            }}
            className="flex items-center space-x-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            disabled={loadingStats || isRefreshing}
          >
            {isRefreshing ? (
              <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
            ) : (
              <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
              </svg>
            )}
            <span>{isRefreshing ? 'Refreshing...' : 'Refresh'}</span>
          </button>
          <FaBell className="text-xl text-gray-600 cursor-pointer" />
          <div className="w-10 h-10 bg-gray-300 rounded-full"></div>
        </div>
      </div>

      {/* Statistics Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <div className="bg-white p-6 rounded-lg shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
              <FaCalendarAlt className="text-blue-600 text-xl" />
            </div>
            <span className="text-2xl font-bold text-gray-800">
              {loadingStats ? '...' : (dashboardStats?.upcoming_bookings || 0)}
            </span>
          </div>
          <p className="text-gray-600">Upcoming Bookings</p>
          {errorStats && (
            <p className="text-red-500 text-sm mt-2">{errorStats}</p>
          )}
        </div>
        <div className="bg-white p-6 rounded-lg shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
              <FaFileAlt className="text-green-600 text-xl" />
            </div>
            <span className="text-2xl font-bold text-gray-800">
              {loadingStats ? '...' : (dashboardStats?.total_bookings || 0)}
            </span>
          </div>
          <p className="text-gray-600">Total Bookings</p>
        </div>
        <div className="bg-white p-6 rounded-lg shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center">
              <FaStar className="text-yellow-600 text-xl" />
            </div>
            <span className="text-2xl font-bold text-gray-800">
              {loadingStats ? '...' : (dashboardStats?.total_reviews || 0)}
            </span>
          </div>
          <p className="text-gray-600">Total Reviews Submitted</p>
        </div>
        <div className="bg-white p-6 rounded-lg shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <div className="w-12 h-12 bg-red-100 rounded-lg flex items-center justify-center">
              <FaHeart className="text-red-600 text-xl" />
            </div>
            <span className="text-2xl font-bold text-gray-800">
              {loadingStats ? '...' : (dashboardStats?.total_favorites || 0)}
            </span>
          </div>
          <p className="text-gray-600">Total Favorites</p>
        </div>
      </div>

      {/* Quick Actions */}
      <div className="mb-8">
        <h2 className="text-xl font-bold text-gray-800 mb-4">Quick Actions</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <Link to="/search" className="bg-white p-4 rounded-lg shadow-sm border border-gray-200 hover:shadow-md transition-shadow">
            <div className="flex items-center space-x-3">
              <div className="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                <FaSearch className="text-blue-600" />
              </div>
              <div>
                <h3 className="font-semibold text-gray-800">Search Spaces</h3>
                <p className="text-sm text-gray-600">Find your perfect meeting space</p>
              </div>
            </div>
          </Link>
          
          <Link to="/bookings" className="bg-white p-4 rounded-lg shadow-sm border border-gray-200 hover:shadow-md transition-shadow">
            <div className="flex items-center space-x-3">
              <div className="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center">
                <FaCalendarAlt className="text-green-600" />
              </div>
              <div>
                <h3 className="font-semibold text-gray-800">View Bookings</h3>
                <p className="text-sm text-gray-600">Check your upcoming reservations</p>
              </div>
            </div>
          </Link>
          
          <Link to="/favorites" className="bg-white p-4 rounded-lg shadow-sm border border-gray-200 hover:shadow-md transition-shadow">
            <div className="flex items-center space-x-3">
              <div className="w-10 h-10 bg-red-100 rounded-lg flex items-center justify-center">
                <FaHeart className="text-red-600" />
              </div>
              <div>
                <h3 className="font-semibold text-gray-800">My Favorites</h3>
                <p className="text-sm text-gray-600">Access your saved spaces</p>
              </div>
            </div>
          </Link>
        </div>
      </div>

      <div className="">
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-xl font-bold text-gray-800">Recent Bookings</h2>
          <Link to="/bookings" className="text-blue-600 hover:text-blue-700">View All</Link>
        </div>
        {loadingStats ? (
          <div className="flex justify-center items-center py-8">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
          </div>
        ) : errorStats ? (
          <div className="text-center py-8">
            <FaCalendarAlt className="mx-auto text-red-300 text-4xl mb-4" />
            <p className="text-red-500 mb-2">{errorStats}</p>
            <button
              onClick={fetchDashboardStats}
              className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
            >
              Try Again
            </button>
          </div>
        ) : recentBookings.length === 0 ? (
          <div className="text-center py-8">
            <FaCalendarAlt className="mx-auto text-gray-300 text-4xl mb-4" />
            <p className="text-gray-500 mb-2">No bookings yet</p>
            <p className="text-sm text-gray-400">Start exploring and make your first booking!</p>
          </div>
        ) : (
          <div className="overflow-x-auto bg-white rounded-lg shadow-sm p-4 mb-8">
            <table className="w-full">
              <thead>
                <tr className="border-b border-gray-200">
                  <th className="text-left py-3 px-4 font-medium text-gray-600">Space</th>
                  <th className="text-left py-3 px-4 font-medium text-gray-600">Date/Time</th>
                  <th className="text-left py-3 px-4 font-medium text-gray-600">Location</th>
                  <th className="text-left py-3 px-4 font-medium text-gray-600">Status</th>
                  <th className="text-left py-3 px-4 font-medium text-gray-600">Actions</th>
                </tr>
              </thead>
              <tbody>
                {recentBookings.map((booking) => (
                  <tr key={booking.id} className="border-b border-gray-100">
                    <td className="py-4 px-4 font-medium">
                      {booking.hotelRoom?.hotel?.hotel_title || 'Hotel'} - {booking.hotelRoom?.room_content?.[0]?.title || 'Room'}
                    </td>
                    <td className="py-4 px-4 text-gray-600">
                      {new Date(booking.check_in_date).toLocaleDateString()}
                      {booking.check_in_time && `, ${booking.check_in_time}`}
                    </td>
                    <td className="py-4 px-4 text-gray-600">
                      {[booking.hotelRoom?.hotel?.city_name, booking.hotelRoom?.hotel?.state_name, booking.hotelRoom?.hotel?.country_name]
                        .filter(Boolean)
                        .join(', ')}
                    </td>
                    <td className="py-4 px-4">
                      <span className={`px-3 py-1 rounded-full text-sm ${getStatusBadge(booking.status)}`}>
                        {getStatusText(booking.status)}
                      </span>
                    </td>
                    <td className="py-4 px-4">
                      <Link to={`/booking/${booking.id}`} className="text-blue-600 hover:text-blue-700">
                        View Details
                      </Link>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* Favorites Hotels Section */}
      <div>
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-xl font-bold text-gray-800">Favorite Hotels</h2>
          <Link to="/favorites" className="text-blue-600 hover:text-blue-700">View All</Link>
        </div>
        {loadingStats ? ( // Changed from loadingWishlists to loadingStats
          <div className="flex justify-center items-center py-8">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
          </div>
        ) : errorStats ? ( // Changed from errorWishlists to errorStats
          <div className="text-center py-8">
            <FaHeart className="mx-auto text-red-300 text-4xl mb-4" />
            <p className="text-red-500 mb-2">{errorStats}</p>
            <button
              onClick={fetchDashboardStats}
              className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
            >
              Try Again
            </button>
          </div>
        ) : dashboardWishlists.hotel_wishlists.length === 0 ? (
          <div className="text-center py-8">
            <FaHeart className="mx-auto text-gray-300 text-4xl mb-4" />
            <p className="text-gray-500 mb-2">No favorite hotels yet</p>
            <p className="text-sm text-gray-400">Start exploring and add hotels to your favorites!</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {dashboardWishlists.hotel_wishlists.map((wishlist) => {
              const hotel = wishlist.hotel;
              return (
                <Link key={wishlist.id} to={`/hotels/${hotel.id}`}>
                  <div className="rounded-lg overflow-hidden">
                    <div className="h-[174.9771728515625px] w-[310.58447265625px] relative">
                      <img
                        src={hotel ? getHotelImage(hotel) : 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzEwIiBoZWlnaHQ9IjE3NSIgdmlld0JveD0iMCAwIDMxMCAxNzUiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIzMTAiIGhlaWdodD0iMTc1IiBmaWxsPSIjRjNGNEY2Ii8+CjxwYXRoIGQ9Ik0xNTUgODcuNUwxNjUgOTcuNUwxNTUgMTA3LjVMMTQ1IDk3LjVMMTU1IDg3LjVaIiBmaWxsPSIjOUI5QkEwIi8+Cjx0ZXh0IHg9IjE1NSIgeT0iMTMwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjOUI5QkEwIiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMTNiPkltYWdlPC90ZXh0Pgo8dGV4dCB4PSIxNTUiIHk9IjE0OCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzlCOUJBMCIgZm9udC1mYW1pbHk9IkFyaWFsIiBmb250LXNpemU9IjEyIj5Ob3QgQXZhaWxhYmxlPC90ZXh0Pgo8L3N2Zz4K'}
                        alt={hotel ? getHotelTitle(hotel) : `Hotel #${hotel.id}`}
                        className="w-[310.58447265625px] h-[174.9771728515625px] object-cover rounded-lg"
                        style={{ borderRadius: '8px' }}
                        onError={(e) => {
                          e.target.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzEwIiBoZWlnaHQ9IjE3NSIgdmlld0JveD0iMCAwIDMxMCAxNzUiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIzMTAiIGhlaWdodD0iMTc1IiBmaWxsPSIjRjNGNEY2Ii8+CjxwYXRoIGQ9Ik0xNTUgODcuNUwxNjUgOTcuNUwxNTUgMTA3LjVMMTQ1IDk3LjVMMTU1IDg3LjVaIiBmaWxsPSIjOUI5QkEwIi8+Cjx0ZXh0IHg9IjE1NSIgeT0iMTMwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjOUI5QkEwIiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMTQiPkltYWdlPC90ZXh0Pgo8dGV4dCB4PSIxNTUiIHk9IjE0OCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIjlCOUJBMCIgZm9udC1mYW1pbHk9IkFyaWFsIiBmb250LXNpemU9IjEyIj5Ob3QgQXZhaWxhYmxlPC90ZXh0Pgo8L3N2Zz4K';
                        }}
                      />
                      <div className="absolute top-2 right-2 bg-white p-2 rounded-full shadow-md">
                        <FaHeart className="w-4 h-4 text-red-500" />
                      </div>
                    </div>
                    <div className="p-4">
                      <h3 className="font-semibold text-gray-800 mb-1">
                        {hotel?.hotel_title || `Hotel #${hotel.id}`}
                      </h3>
                      <p className="text-gray-600 mb-2 text-sm">
                        {hotel?.categoryName || 'Hotel'}
                      </p>
                      {hotel?.city_name && (
                        <p className="text-gray-500 text-sm mb-3">
                          📍 {hotel.city_name}{hotel?.state_name && `, ${hotel.state_name}`}
                        </p>
                      )}
                    </div>
                  </div>
                </Link>
              );
            })}
          </div>
        )}
      </div>
    </DashboardLayout>
  )
}
