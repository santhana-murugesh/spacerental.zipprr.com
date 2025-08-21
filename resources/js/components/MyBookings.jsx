import React, { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from './AuthContext'
import { DashboardLayout } from './DashboardLayout'
import {
  FaCalendarAlt,
  FaClock,
  FaMapMarkerAlt,
  FaEye,
  FaCheckCircle,
  FaTimesCircle,
  FaExclamationTriangle
} from 'react-icons/fa'
export const MyBookings = () => {
  const { user, authLoading } = useAuth();
  const [bookings, setBookings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [filterStatus, setFilterStatus] = useState('all');
  const API_BASE_URL =
    window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
      ? import.meta.env.VITE_API_BASE_URL_LOCAL
      : import.meta.env.VITE_API_BASE_URL;
  const fetchBookings = async () => {
    try {
      setLoading(true);
      setError(null);
      if (!user || !user.id) {
        console.log('No user or user ID found');
        setBookings([]);
        return;
      }
      const token = localStorage.getItem('jwt_token');
      const response = await fetch(`${API_BASE_URL}/api/bookings`, {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      });
      if (response.ok) {
        const data = await response.json();
        const userBookings = (data.bookings || []).filter(booking =>
          booking.user_id === user.id
        );
        setBookings(userBookings);
      } else if (response.status === 401) {
        const errorText = await response.text();
        setError('Authentication failed. Please login again.');
        setBookings([]);
      } else if (response.status === 404) {
        const errorText = await response.text();
        setError('No bookings found.');
        setBookings([]);
      } else {
        const errorText = await response.text();
        setError(`Failed to fetch bookings. Status: ${response.status}`);
        setBookings([]);
      }
    } catch (error) {
      console.error('Error fetching bookings:', error);
      if (error.name === 'TypeError' && error.message.includes('fetch')) {
        setError('Network error. Please check your connection.');
      } else {
        setError('An unexpected error occurred while fetching bookings.');
      }
      setBookings([]);
    } finally {
      setLoading(false);
    }
  };
  const getStatusBadge = (status) => {
    const statusConfig = {
      confirmed: {
        icon: <FaCheckCircle className="w-4 h-4" />,
        className: "bg-green-100 text-green-800 border-green-200",
        text: "Confirmed"
      },
      pending: {
        icon: <FaClock className="w-4 h-4" />,
        className: "bg-yellow-100 text-yellow-800 border-yellow-200",
        text: "Pending"
      },
      completed: {
        icon: <FaCheckCircle className="w-4 h-4" />,
        className: "bg-blue-100 text-blue-800 border-blue-200",
        text: "Completed"
      },
      cancelled: {
        icon: <FaTimesCircle className="w-4 h-4" />,
        className: "bg-red-100 text-red-800 border-red-200",
        text: "Cancelled"
      }
    };
    const config = statusConfig[status] || statusConfig.pending;
    return (
      <span className={`inline-flex items-center gap-2 px-3 py-1 rounded-full text-sm font-medium border ${config.className}`}>
        {config.icon}
        {config.text}
      </span>
    );
  };
  const filteredBookings = filterStatus === 'all'
    ? bookings
    : bookings.filter(booking => {
      const matches = booking.order_status === filterStatus;
      return matches;
    });
  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };
  const formatTime = (timeString) => {
    if (!timeString) return 'N/A';
    const [hours, minutes] = timeString.split(':');
    const hour = parseInt(hours);
    const ampm = hour >= 12 ? 'PM' : 'AM';
    const displayHour = hour > 12 ? hour - 12 : hour === 0 ? 12 : hour;
    return `${displayHour}:${minutes} ${ampm}`;
  };
  useEffect(() => {
    if (user && !authLoading) {
      fetchBookings();
    }
  }, [user, authLoading]);
  return (
    <DashboardLayout title="My Bookings" showRefresh={true} onRefresh={fetchBookings}>
      {loading ? (
        <div className="flex justify-center items-center py-16">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      ) : error ? (
        <div className="text-center py-16">
          <FaExclamationTriangle className="mx-auto text-red-500 text-6xl mb-4" />
          <p className="text-red-600 text-lg mb-2">Error loading bookings</p>
          <p className="text-gray-500 mb-4">{error}</p>
          <button
            onClick={fetchBookings}
            className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
          >
            Try Again
          </button>
        </div>
      ) : (
        <div className="space-y-6">
          <div className="bg-white rounded-lg shadow-sm p-6">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-lg font-semibold text-gray-800">Filter Bookings</h3>
              <span className="text-sm text-gray-500">
                {filteredBookings.length} of {bookings.length} bookings
              </span>
            </div>
            <div className="flex flex-wrap gap-3">
              <button
                onClick={() => setFilterStatus('all')}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${filterStatus === 'all'
                    ? 'bg-blue-600 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                  }`}
              >
                All Bookings
              </button>
              <button
                onClick={() => setFilterStatus('confirmed')}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${filterStatus === 'confirmed'
                    ? 'bg-green-600 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                  }`}
              >
                Confirmed
              </button>
              <button
                onClick={() => setFilterStatus('pending')}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${filterStatus === 'pending'
                    ? 'bg-yellow-600 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                  }`}
              >
                Pending
              </button>
              <button
                onClick={() => setFilterStatus('completed')}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${filterStatus === 'completed'
                    ? 'bg-blue-600 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                  }`}
              >
                Completed
              </button>
              <button
                onClick={() => setFilterStatus('cancelled')}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${filterStatus === 'cancelled'
                    ? 'bg-red-600 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                  }`}
              >
                Cancelled
              </button>
            </div>
          </div>
          {filteredBookings.length === 0 ? (
            <div className="bg-white rounded-lg shadow-sm p-12 text-center">
              <FaCalendarAlt className="mx-auto text-gray-300 text-6xl mb-4" />
              <h3 className="text-lg font-semibold text-gray-600 mb-2">
                {filterStatus === 'all' ? 'No bookings found' : `No ${filterStatus} bookings`}
              </h3>
              <p className="text-gray-500 mb-4">
                {filterStatus === 'all'
                  ? "You haven't made any bookings yet. Start exploring spaces to book your first event!"
                  : `You don't have any ${filterStatus} bookings at the moment.`
                }
              </p>
              {filterStatus === 'all' && (
                <Link
                  to="/"
                  className="inline-block px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
                >
                  Explore Spaces
                </Link>
              )}
            </div>
          ) : (
            <div className="space-y-4">
              {filteredBookings.map((booking) => (
                <div key={booking.id} className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                  <div className="p-6">
                    {booking.hotel_room?.feature_image && (
                      <div className="mb-4">
                        <img
                          src={`${API_BASE_URL}/assets/img/rooms/${booking.hotel_room.feature_image}`}
                          alt="Hotel Room"
                          className="w-full h-48 object-cover rounded-lg"
                          onError={(e) => {
                            e.target.style.display = 'none';
                          }}
                        />
                      </div>
                    )}
                    <div className="flex items-start justify-between mb-4">
                      <div className="flex-1">
                        <div className="flex items-center justify-between mb-2">
                          <h3 className="text-xl font-semibold text-gray-800">
                            {booking.hotel?.hotel_contents?.[0]?.title ||
                              booking.hotel_room?.hotel?.hotel_contents?.[0]?.title ||
                              (booking.hotel_room?.hotel_id ? `Hotel ${booking.hotel_room.hotel_id}` : 'Hotel')}
                          </h3>
                          {getStatusBadge(booking.order_status)}
                        </div>
                        <p className="text-gray-600 mb-1">{booking.hotel_room?.room_content?.[0]?.title || 'Room'}</p>
                        <p className="text-sm text-gray-500">Booking Code: {booking.order_number}</p>
                      </div>
                    </div>
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-4">
                      <div className="flex items-center gap-2">
                        <FaCalendarAlt className="text-gray-400" />
                        <div>
                          <p className="text-sm text-gray-500">Date</p>
                          <p className="font-medium text-gray-800">{formatDate(booking.check_in_date)}</p>
                        </div>
                      </div>
                      <div className="flex items-center gap-2">
                        <FaClock className="text-gray-400" />
                        <div>
                          <p className="text-sm text-gray-500">Time</p>
                          <p className="font-medium text-gray-800">
                            {formatTime(booking.check_in_time)}
                            {booking.check_out_time && ` - ${formatTime(booking.check_out_time)}`}
                          </p>
                        </div>
                      </div>
                      <div className="flex items-center gap-2">
                        <FaMapMarkerAlt className="text-gray-400" />
                        <div>
                          <p className="text-sm text-gray-500">Location</p>
                          <p className="font-medium text-gray-800">
                            {booking.hotel?.hotel_contents?.[0]?.address ||
                              booking.hotel_room?.hotel?.hotel_contents?.[0]?.address ||
                              (booking.hotel_room?.hotel_id ? `Hotel ${booking.hotel_room.hotel_id}` : 'Location')}
                          </p>
                        </div>
                      </div>
                      <div className="flex items-center gap-2">
                        <div className="w-4 h-4 bg-gray-400 rounded-full"></div>
                        <div>
                          <p className="text-sm text-gray-500">Attendees</p>
                          <p className="font-medium text-gray-800">{booking.adult + (booking.children || 0)} people</p>
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center justify-between pt-4 border-t border-gray-100">
                      <div className="flex items-center gap-4 text-sm text-gray-600">
                        <span><strong>Duration:</strong> {booking.hour} hours</span>
                        <span><strong>Total:</strong> ${booking.grand_total}</span>
                      </div>
                      <div className="flex items-center gap-3">
                        <Link
                          to={`/booking/${booking.id}`}
                          className="inline-flex items-center gap-2 px-4 py-2 text-blue-600 hover:text-blue-700 font-medium text-sm transition-colors"
                        >
                          <FaEye className="w-4 h-4" />
                          View Details
                        </Link>
                        {booking.order_status === 'pending' && (
                          <button className="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors text-sm">
                            Cancel Booking
                          </button>
                        )}
                        {booking.order_status === 'confirmed' && (
                          <button className="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition-colors text-sm">
                            Modify Booking
                          </button>
                        )}
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      )}
    </DashboardLayout>
  )
}
