import './bootstrap';
import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import HomePage from './components/HomePage';
import HotelDetails from './components/HotelDetails';
import { SearchPage } from './components/SearchPage';
import Checkout from './components/Checkout';
import { Login } from './components/Login';
import { AuthProvider } from './components/AuthContext';
import { Dashboard } from './components/Dashboard';
import { Favorites } from './components/Favorites';
import { MyBookings } from './components/MyBookings';
import { AboutUs } from './components/AboutUs';
import { EditProfile } from './components/EditProfile';
import { ChangePassword } from './components/ChangePassword';
import { LanguageProvider } from './contexts/LanguageContext';
import AOS from "aos";
import "aos/dist/aos.css";
import './i18n'; 
import '../css/rtl.css'; 

AOS.init({ 
  duration: 1000,
  easing: 'ease-in-out',
  once: false,
  mirror: true,
  offset: 100,
  delay: 0
});

const element = document.getElementById('app');
if (element) {
    const root = ReactDOM.createRoot(element);
    root.render(
        <React.StrictMode>
            <LanguageProvider>
                <AuthProvider>
                    <BrowserRouter>
                        <Routes>
                            <Route path="/" element={<HomePage />} />
                            <Route path="/hotels/:id" element={<HotelDetails />} />
                            <Route path="/search" element={<SearchPage />} />
                            <Route path="/checkout" element={<Checkout />} />
                            <Route path="/user/login" element={<Login />} />
                            <Route path="/user/dashboard" element={<Dashboard />} />
                            <Route path="/bookings" element={<MyBookings />} />
                            <Route path="/favorites" element={<Favorites />} />
                            <Route path="/about-us" element={<AboutUs />} />
                            <Route path="/user/edit-profile" element={<EditProfile />} />
                            <Route path="/user/change-password" element={<ChangePassword />} />

                        </Routes>
                    </BrowserRouter>
                </AuthProvider>
            </LanguageProvider>
        </React.StrictMode>
    );
} 