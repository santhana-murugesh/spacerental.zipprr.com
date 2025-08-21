import React, { useState, useEffect } from 'react'
import { Link, useLocation, useNavigate } from 'react-router-dom'
import { useAuth } from './AuthContext';
import {
  FaHome,
  FaCalendarAlt,
  FaBookmark,
  FaComments,
  FaStar,
  FaEdit,
  FaCog,
  FaSignOutAlt
} from 'react-icons/fa'
export const DashboardLayout = ({ children, title, showRefresh = false, onRefresh }) => {
  const location = useLocation();
  const navigate = useNavigate();
  const { user, logout } = useAuth();
  const [generalSettings, setGeneralSettings] = useState(null);
  const API_BASE_URL =
    window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
      ? import.meta.env.VITE_API_BASE_URL_LOCAL
      : import.meta.env.VITE_API_BASE_URL;
  const handleLogout = async () => {
    await logout();
    alert('You have been logged out successfully.');
    navigate('/');
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
  useEffect(() => {
    fetchBasicImages();
  }, []);
  const isActiveRoute = (path) => {
    return location.pathname === path;
  };
  return (
    <>
      <div className="min-h-screen bg-[#E8EDF5] flex">
        <div className="fixed left-0 top-0 w-64 h-screen bg-white rounded-tr-3xl rounded-br-3xl p-6 overflow-y-auto flex flex-col">
          <div className="flex items-center mb-8">
            <Link to="/">
              <div className="w-[105px] h-[45px] flex items-center justify-center mr-3">
                {generalSettings?.logo ? (
                  <img
                    src={`${window.location.origin}/assets/img/${generalSettings.logo}`}
                    alt="Website Logo"
                    className="w-[105px] h-[45px] object-contain"
                  />
                ) : (
                  <div className="w-[82px] h-[24px] bg-green-500 rounded-full flex items-center justify-center">
                    <span className="text-white font-bold text-sm">space rental</span>
                  </div>
                )}
              </div>
            </Link>
          </div>
          <nav className="space-y-2 flex-1">
            <Link
              to="/user/dashboard"
              className={`flex items-center px-4 py-3 rounded-lg transition-colors ${isActiveRoute('/user/dashboard')
                  ? 'text-gray-700 bg-blue-100'
                  : 'text-gray-600 hover:bg-gray-200'
                }`}
            >
              <FaHome className={`mr-3 ${isActiveRoute('/user/dashboard') ? 'text-blue-600' : ''}`} />
              <span>Dashboard</span>
            </Link>
            <Link
              to="/bookings"
              className={`flex items-center px-4 py-3 rounded-lg transition-colors ${isActiveRoute('/bookings')
                  ? 'text-gray-700 bg-blue-100'
                  : 'text-gray-600 hover:bg-gray-200'
                }`}
            >
              <FaCalendarAlt className={`mr-3 ${isActiveRoute('/bookings') ? 'text-blue-600' : ''}`} />
              <span>My Bookings</span>
            </Link>
            <Link
              to="/favorites"
              className={`flex items-center px-4 py-3 rounded-lg transition-colors ${isActiveRoute('/favorites')
                  ? 'text-gray-700 bg-blue-100'
                  : 'text-gray-600 hover:bg-gray-200'
                }`}
            >
              <FaBookmark className={`mr-3 ${isActiveRoute('/favorites') ? 'text-blue-600' : ''}`} />
              <span>Favorites</span>
            </Link>
           
            <Link
              to="/user/change-password"
              className={`flex items-center px-4 py-3 rounded-lg transition-colors ${isActiveRoute('/user/change-password')
                  ? 'text-gray-700 bg-blue-100'
                  : 'text-gray-600 hover:bg-gray-200'
                }`}
            >
              <FaEdit className={`mr-3 ${isActiveRoute('/user/change-password') ? 'text-blue-600' : ''}`} />
              <span>Change Password</span>
            </Link>
            <Link
              to="/user/edit-profile"
              className={`flex items-center px-4 py-3 rounded-lg transition-colors ${isActiveRoute('/user/edit-profile')
                  ? 'text-gray-700 bg-blue-100'
                  : 'text-gray-600 hover:bg-gray-200'
                }`}
            >
              <FaEdit className={`mr-3 ${isActiveRoute('/user/edit-profile') ? 'text-blue-600' : ''}`} />
              <span>Edit Profile</span>
            </Link>
          </nav>
          <div className="mt-auto space-y-2">
           
            <button
              onClick={handleLogout}
              className="flex items-center px-4 py-3 rounded-lg transition-colors text-gray-600 hover:bg-gray-200 w-full text-left"
            >
              <FaSignOutAlt className="mr-3" />
              <span>Logout</span>
            </button>
          </div>
        </div>
        {/* Main Content */}
        <div className="flex-1 ml-64 p-8">
          {/* Page Header */}
          <div className="flex items-center justify-between mb-8">
            <h1 className="text-2xl font-bold text-gray-800">{title}</h1>
            {showRefresh && onRefresh && (
              <button
                onClick={onRefresh}
                className="text-blue-600 hover:text-blue-700 text-sm font-medium flex items-center"
                title="Refresh"
              >
                <svg className="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                </svg>
                Refresh
              </button>
            )}
          </div>
          {children}
        </div>
      </div>
    </>
  )
}