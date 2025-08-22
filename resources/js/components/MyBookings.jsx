import React, { useState, useEffect } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from './AuthContext'
import { DashboardLayout } from './DashboardLayout'
import Swal from 'sweetalert2'
import {
  FaCalendarAlt,
  FaClock,
  FaMapMarkerAlt,
  FaEye,
  FaCheckCircle,
  FaTimesCircle,
  FaExclamationTriangle,
  FaCreditCard,
  FaImage
} from 'react-icons/fa'

export const MyBookings = () => {
  const { user, authLoading } = useAuth();
  const navigate = useNavigate();
  const [bookings, setBookings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [filterStatus, setFilterStatus] = useState('all');
  const [detailModal, setDetailModal] = useState({ open: false, booking: null });
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
        
        // Debug logging to see the actual data structure
        console.log('Fetched bookings data:', userBookings);
        if (userBookings.length > 0) {
          console.log('First booking hotel data:', {
            hotel_room: userBookings[0].hotel_room,
            hotel_room_hotel: userBookings[0].hotel_room?.hotel,
            hotel_room_hotel_contents: userBookings[0].hotel_room?.hotel?.hotel_contents
          });
          console.log('First booking payment data:', {
            payment_status: userBookings[0].payment_status,
            payment_method: userBookings[0].payment_method,
            order_number: userBookings[0].order_number
          });
        }
        
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

  const deleteBooking = async (id) => {
    const result = await Swal.fire({
      title: 'Are you sure?',
      text: "You won't be able to revert this!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#3085d6',
      confirmButtonText: 'Yes, delete it!'
    });

    if (result.isConfirmed) {
      try {
        const token = localStorage.getItem('jwt_token');
        const res = await fetch(`${API_BASE_URL}/api/bookings/${id}`, {
          method: 'DELETE',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Accept': 'application/json'
          }
        });
        if (res.ok) {
          setBookings(prev => prev.filter(b => b.id !== id));
          Swal.fire(
            'Deleted!',
            'Your booking has been deleted.',
            'success'
          );
        } else {
          const data = await res.json().catch(() => ({}));
          setError(data.message || 'Failed to delete booking');
          Swal.fire(
            'Error!',
            data.message || 'Failed to delete booking',
            'error'
          );
        }
      } catch (e) {
        setError('Failed to delete booking');
        Swal.fire(
          'Error!',
          'Failed to delete booking',
          'error'
        );
      }
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
      if (filterStatus === 'completed') {
        return booking.payment_status === 1 || booking.payment_status === '1';
      } else if (filterStatus === 'pending') {
        return booking.payment_status === 0 || booking.payment_status === '0';
      } else if (filterStatus === 'rejected') {
        return booking.payment_status === 2 || booking.payment_status === '2';
      }
      return false;
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
                onClick={() => setFilterStatus('completed')}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${filterStatus === 'completed'
                    ? 'bg-green-600 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                  }`}
              >
                Completed
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
                onClick={() => setFilterStatus('rejected')}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${filterStatus === 'rejected'
                    ? 'bg-red-600 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                  }`}
              >
                Rejected
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
            <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
              <div className="bg-gray-50 px-6 py-4 border-b border-gray-200">
                <div className="grid grid-cols-12 gap-4 text-sm font-semibold text-gray-700">
                  <div className="col-span-2">Booking No.</div>
                  <div className="col-span-3">Room</div>
                  <div className="col-span-1">Vendor</div>
                  <div className="col-span-2">Customer</div>
                  <div className="col-span-1">Amount</div>
                  <div className="col-span-1">Payment Method</div>
                  <div className="col-span-1">Payment Status</div>
                  <div className="col-span-1">Actions</div>
                </div>
              </div>
              
              {filteredBookings.map((booking) => (
                <div key={booking.id} className="px-6 py-4 border-b border-gray-100 last:border-b-0 hover:bg-gray-50">
                  <div className="grid grid-cols-12 gap-4 items-center text-sm">
                    <div className="col-span-2">
                      <span className="font-medium text-gray-900 text-xs">#{booking.order_number}</span>
                    </div>
                    
                    <div className="col-span-3">
                      <div className="text-blue-600 hover:text-blue-800 cursor-pointer text-sm font-medium">
                        {booking.hotel_room?.room_content?.[0]?.title || 'Room'}
                      </div>
                      <div 
                        className="text-xs text-blue-500 hover:text-blue-700 cursor-pointer mt-0.5"
                        onClick={() => {
                          const hotelId = booking.hotel_room?.hotel?.id;
                          if (hotelId) {
                            navigate(`/hotels/${hotelId}`);
                          }
                        }}
                      >
                        {booking.hotel_room?.hotel?.hotel_contents?.[0]?.title || 'Hotel'}
                      </div>
                    </div>
                    
                    <div className="col-span-1">
                      {booking.vendor_id ? (
                        <span className="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                          Admin
                        </span>
                      ) : (
                        <span className="text-gray-400 text-xs">--</span>
                      )}
                    </div>
                    
                    <div className="col-span-2">
                      <span className="text-blue-600 hover:text-blue-800 cursor-pointer text-sm">
                        {booking.booking_name || 'user'}
                      </span>
                    </div>
                    
                    <div className="col-span-1">
                      <div className="text-gray-900 font-medium text-sm">${booking.grand_total}</div>
                      <div className="text-xs text-gray-500">USD</div>
                    </div>
                    
                    <div className="col-span-1">
                      <span className="text-gray-600 text-xs">
                        {booking.payment_method ? 
                          (booking.payment_method.length > 10 ? 
                            booking.payment_method.substring(0, 10) + '...' : 
                            booking.payment_method) 
                          : '--'}
                      </span>
                    </div>
                    
                    <div className="col-span-1">
                      {(() => {
                        const status = booking.payment_status;
                        if (status === 1 || status === '1') {
                          return (
                            <span className="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                              Completed
                            </span>
                          );
                        } else if (status === 2 || status === '2') {
                          return (
                            <span className="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                              Rejected
                            </span>
                          );
                        } else if (status === 0 || status === '0') {
                          return (
                            <span className="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-orange-100 text-orange-800">
                              Pending
                            </span>
                          );
                        } else {
                          return (
                            <span className="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                              {status || 'Unknown'}
                            </span>
                          );
                        }
                      })()}
                    </div>
                    
                    <div className="col-span-1">
                      <div className="flex items-center gap-1">
                        <button
                          onClick={() => setDetailModal({ open: true, booking })}
                          className="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-blue-100 text-blue-800 hover:bg-blue-200"
                        >
                          <FaEye className="w-3 h-3" />
                        </button>
                        <button
                          onClick={() => deleteBooking(booking.id)}
                          className="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-red-100 text-red-800 hover:bg-red-200"
                        >
                          Delete
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      )}
      {detailModal.open && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-white w-full max-w-2xl rounded-lg shadow-lg p-6 max-h-[90vh] overflow-y-auto">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-lg font-semibold">Booking Summary</h3>
              <button onClick={() => setDetailModal({ open: false, booking: null })} className="text-gray-500 hover:text-gray-700">✕</button>
            </div>
            {detailModal.booking && (
              <div className="space-y-4">
                {detailModal.booking.hotel_room?.feature_image && (
                  <div className="text-center">
                    <img
                      src={`${API_BASE_URL}/assets/img/rooms/${detailModal.booking.hotel_room.feature_image}`}
                      alt="Room"
                      className="w-full max-w-md h-48 object-cover rounded-lg mx-auto"
                      onError={(e) => {
                        e.target.style.display = 'none';
                      }}
                    />
                  </div>
                )}
                
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <p className="text-gray-500">Hotel</p>
                    <p className="font-medium text-gray-800">{detailModal.booking.hotel_room?.hotel?.hotel_contents?.[0]?.title || 'Hotel'}</p>
                  </div>
                  <div>
                    <p className="text-gray-500">Booking Code</p>
                    <p className="font-medium text-gray-800">{detailModal.booking.order_number}</p>
                  </div>
                  <div>
                    <p className="text-gray-500">Date</p>
                    <p className="font-medium text-gray-800">{formatDate(detailModal.booking.check_in_date)}</p>
                  </div>
                  <div>
                    <p className="text-gray-500">Time</p>
                    <p className="font-medium text-gray-800">{formatTime(detailModal.booking.check_in_time)}</p>
                  </div>
                  <div>
                    <p className="text-gray-500">Attendees</p>
                    <p className="font-medium text-gray-800">{detailModal.booking.adult + (detailModal.booking.children || 0)} people</p>
                  </div>
                  <div>
                    <p className="text-gray-500">Total</p>
                    <p className="font-medium text-gray-800">${detailModal.booking.grand_total}</p>
                  </div>
                  <div>
                    <p className="text-gray-500">Duration</p>
                    <p className="font-medium text-gray-800">{detailModal.booking.hour} hours</p>
                  </div>
                  <div>
                    <p className="text-gray-500">Payment Method</p>
                    <p className="font-medium text-gray-800 flex items-center gap-2">
                      <FaCreditCard className="text-gray-400" />
                      {detailModal.booking.payment_method || 'Not specified'}
                    </p>
                  </div>
                  <div>
                    <p className="text-gray-500">Payment Status</p>
                    <p className="font-medium text-gray-800">
                      {(() => {
                        const status = detailModal.booking.payment_status;
                        if (status === 1 || status === '1') {
                          return 'Completed';
                        } else if (status === 2 || status === '2') {
                          return 'Rejected';
                        } else if (status === 0 || status === '0') {
                          return 'Pending';
                        } else {
                          return status || 'Unknown';
                        }
                      })()}
                    </p>
                  </div>
                  <div>
                    <p className="text-gray-500">Room</p>
                    <p className="font-medium text-gray-800">{detailModal.booking.hotel_room?.room_content?.[0]?.title || 'Room'}</p>
                  </div>
                </div>
                
                <div className="col-span-1 md:col-span-2">
                  <p className="text-gray-500">Location</p>
                  <p className="font-medium text-gray-800">{detailModal.booking.hotel_room?.hotel?.hotel_contents?.[0]?.address || 'Location not specified'}</p>
                </div>
                
                {detailModal.booking.additional_service && (
                  <div className="col-span-1 md:col-span-2">
                    <p className="text-gray-500">Additional Services</p>
                    <div className="bg-gray-50 p-3 rounded">
                      <pre className="text-sm text-gray-700 whitespace-pre-wrap">{JSON.stringify(detailModal.booking.additional_service, null, 2)}</pre>
                    </div>
                  </div>
                )}
              </div>
            )}
            <div className="mt-6 text-right">
              <button onClick={() => setDetailModal({ open: false, booking: null })} className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">Close</button>
            </div>
          </div>
        </div>
      )}
    </DashboardLayout>
  )
}
