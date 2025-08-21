import React, { createContext, useContext, useState, useEffect } from 'react';
const AuthContext = createContext();
export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [token, setToken] = useState(localStorage.getItem('jwt_token'));
  const [isCheckingAuth, setIsCheckingAuth] = useState(false);
  const API_BASE_URL = window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
    ? import.meta.env.VITE_API_BASE_URL_LOCAL
    : import.meta.env.VITE_API_BASE_URL;
  useEffect(() => {
    if (token) {
      checkAuthStatusWithRetry();
    } else {
      const urlParams = new URLSearchParams(window.location.search);
      const vendorId = urlParams.get('vendor_id');
      const verified = urlParams.get('verified');
      if (vendorId && verified === '1') {
        // Vendor just verified email, automatically authenticate them
        handleVendorVerification(vendorId);
      } else {
        const existingVendorId = localStorage.getItem('vendor_id');
        const existingUser = localStorage.getItem('user');
        if (existingVendorId && existingUser) {
          try {
            const userData = JSON.parse(existingUser);
            if (userData.role === 'vendor' && userData.id == existingVendorId) {
              console.log('Found existing vendor authentication in localStorage:', userData);
              setUser(userData);
              setLoading(false);
              return;
            }
          } catch (e) {
            console.error('Error parsing existing user data:', e);
          }
        }
        checkVendorSession();
        checkUserSession();
        setLoading(false);
      }
    }
  }, [token]);
  const checkAuthStatusWithRetry = async (retryCount = 0) => {
    try {
      await checkAuthStatus();
    } catch (error) {
      if (retryCount < 2) {
        const delay = Math.pow(2, retryCount) * 1000; // 1s, 2s
        setTimeout(() => {
          checkAuthStatusWithRetry(retryCount + 1);
        }, delay);
      } else {
        setLoading(false);
      }
    }
  };
  const debouncedAuthCheck = (() => {
    let timeoutId;
    return () => {
      if (timeoutId) {
        clearTimeout(timeoutId);
      }
      timeoutId = setTimeout(() => {
        if (token && !user) {
          checkAuthStatusWithRetry();
        }
      }, 1000); // Wait 1 second before retrying
    };
  })();
  const checkAuthStatus = async () => {
    if (isCheckingAuth) {
      return;
    }
    setIsCheckingAuth(true);
    try {
      const storedUser = localStorage.getItem('user');
      let isVendor = false;
      if (storedUser) {
        try {
          const userData = JSON.parse(storedUser);
          isVendor = userData.role === 'vendor';
        } catch (e) {
        }
      }
      if (isVendor) {
        const vendorId = localStorage.getItem('vendor_id');
        if (!vendorId) {
          setUser(null);
          setToken(null);
          localStorage.removeItem('jwt_token');
          localStorage.removeItem('user');
          localStorage.removeItem('vendor_id');
          return;
        }
        const response = await fetch(`${API_BASE_URL}/api/vendor/user?vendor_id=${vendorId}`, {
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        });
        if (response.ok) {
          const data = await response.json();
          setUser(data.user);
        } else {
          setUser(null);
          setToken(null);
          localStorage.removeItem('jwt_token');
          localStorage.removeItem('user');
          localStorage.removeItem('vendor_id');
        }
      } else {
        const response = await fetch(`${API_BASE_URL}/api/auth/user`, {
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`,
          },
        });
        if (response.ok) {
          const data = await response.json();
          setUser(data.user);
        } else {
          if (response.status === 429) {
            return;
          }
          if (response.status === 401) {
            const refreshSuccess = await refreshToken();
            if (!refreshSuccess) {
              setUser(null);
              setToken(null);
              localStorage.removeItem('jwt_token');
            }
          }
        }
      }
    } catch (error) {
      console.error('Auth check error:', error);
      setUser(null);
      setToken(null);
      localStorage.removeItem('jwt_token');
      localStorage.removeItem('user');
      localStorage.removeItem('vendor_id');
    } finally {
      setIsCheckingAuth(false);
    }
  };
  const checkVendorSession = async () => {
    try {
      console.log('Checking vendor session...');
      const response = await fetch(`${API_BASE_URL}/api/vendor/auth-status`, {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      });
      if (response.ok) {
        const data = await response.json();
        console.log('Vendor session check response:', data);
        if (data.success && data.authenticated && data.user) {
          console.log('Vendor authenticated via session:', data.user);
          setUser(data.user);
          localStorage.setItem('vendor_id', data.user.id);
          localStorage.setItem('user', JSON.stringify(data.user));
        } else {
          console.log('No vendor authenticated via session');
        }
      } else {
        console.log('Vendor session check failed:', response.status);
      }
    } catch (error) {
      console.error('Vendor session check error:', error);
    }
  };

  const checkUserSession = async () => {
    try {
      console.log('Checking user session...');
      const response = await fetch(`${API_BASE_URL}/api/user/auth-status`, {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      });
      if (response.ok) {
        const data = await response.json();
        console.log('User session check response:', data);
        if (data.success && data.authenticated && data.user) {
          console.log('User authenticated via session:', data.user);
          setUser(data.user);
          localStorage.setItem('user', JSON.stringify(data.user));
        } else {
          console.log('No user authenticated via session');
        }
      } else {
        console.log('User session check failed:', response.status);
      }
    } catch (error) {
      console.error('User session check error:', error);
    }
  };
  const login = async (credentials) => {
    try {
      const response = await fetch(`${API_BASE_URL}/api/auth/login`, {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(credentials),
      });
      const data = await response.json();
      if (response.ok && data.success) {
        setUser(data.user);
        setToken(data.token);
        localStorage.setItem('jwt_token', data.token);
        localStorage.setItem('user', JSON.stringify(data.user));
        return { success: true, message: data.message, user: data.user, token: data.token };
      } else {
        return { success: false, message: data.message };
      }
    } catch (error) {
      console.error('Login error:', error);
      return { success: false, message: 'An error occurred during login' };
    }
  };
  const logout = async () => {
    try {
      const storedUser = localStorage.getItem('user');
      let isVendor = false;
      if (storedUser) {
        try {
          const userData = JSON.parse(storedUser);
          isVendor = userData.role === 'vendor';
        } catch (e) {
        }
      }
      setUser(null);
      setToken(null);
      localStorage.removeItem('jwt_token');
      localStorage.removeItem('user');
      localStorage.removeItem('vendor_id');
      if (isVendor) {
        window.location.href = '/';
      } else {
        window.location.href = '/';
      }
    } catch (error) {
      console.error('Logout error:', error);
      setUser(null);
      setToken(null);
      localStorage.removeItem('jwt_token');
      localStorage.removeItem('user');
      localStorage.removeItem('vendor_id');
      window.location.href = '/';
    }
  };
  const refreshToken = async () => {
    try {
      const response = await fetch(`${API_BASE_URL}/api/auth/refresh`, {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
      });
      if (response.ok) {
        const data = await response.json();
        setToken(data.token);
        localStorage.setItem('jwt_token', data.token);
        return true;
      } else if (response.status === 429) {
        return false;
      } else if (response.status === 401) {
        setUser(null);
        setToken(null);
        localStorage.removeItem('jwt_token');
        return false;
      } else if (response.status >= 500) {
        return false;
      } else {
        return false;
      }
    } catch (error) {
      if (error.name === 'TypeError' && error.message.includes('fetch')) {
      } else {
      }
      return false;
    }
  };
  const handleVendorVerification = async (vendorId) => {
    try {
      console.log('Handling vendor verification for ID:', vendorId);
      const response = await fetch(`${API_BASE_URL}/api/vendor/user?vendor_id=${vendorId}`, {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      });
      if (response.ok) {
        const data = await response.json();
        console.log('Vendor verification response:', data);
        setUser(data.user);
        localStorage.setItem('vendor_id', vendorId);
        localStorage.setItem('user', JSON.stringify(data.user));
        window.history.replaceState({}, document.title, '/');
        localStorage.setItem('vendor_verification_success', 'true');
        setTimeout(() => {
          window.location.href = `/vendor/dashboard?vendor_id=${vendorId}`;
        }, 500);
      } else {
        console.error('Vendor verification failed:', response.status);
        setUser(null);
        setToken(null);
        localStorage.removeItem('jwt_token');
        localStorage.removeItem('user');
        localStorage.removeItem('vendor_id');
        setLoading(false);
      }
    } catch (error) {
      console.error('Vendor verification error:', error);
      setUser(null);
      setToken(null);
      localStorage.removeItem('jwt_token');
      localStorage.removeItem('user');
      localStorage.removeItem('vendor_id');
      setLoading(false);
    }
  };
  const value = {
    user,
    loading,
    login,
    logout,
    checkAuthStatus,
    token,
    refreshToken,
    setUser,
    setToken,
    handleVendorVerification,
    checkVendorSession,
    checkUserSession,
  };
  useEffect(() => {
    window.authContext = {
      setUser,
      setToken,
      user,
      token
    };
    return () => {
      delete window.authContext;
    };
  }, [user, token]);
  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
};
