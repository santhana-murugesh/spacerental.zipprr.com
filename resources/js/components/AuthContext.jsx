import React, { createContext, useContext, useState, useEffect } from 'react';

const AuthContext = createContext();

const API_BASE_URL =
  window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
    ? import.meta.env.VITE_API_BASE_URL_LOCAL
    : import.meta.env.VITE_API_BASE_URL;

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
};

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [token, setToken] = useState(localStorage.getItem("jwt_token"));
  const [isCheckingAuth, setIsCheckingAuth] = useState(false);
  const [hasCheckedSession, setHasCheckedSession] = useState(false);

  useEffect(() => {
    if (token) {
      checkAuthStatusWithRetry();
    } else if (!hasCheckedSession) {
      const urlParams = new URLSearchParams(window.location.search);
      const vendorId = urlParams.get("vendor_id");
      const verified = urlParams.get("verified");

      if (vendorId && verified === "1") {
        handleVendorVerification(vendorId);
      } else {
        const existingVendorId = localStorage.getItem("vendor_id");
        const existingUser = localStorage.getItem("user");

        if (existingVendorId && existingUser) {
          try {
            const userData = JSON.parse(existingUser);
            if (userData.role === "vendor" && userData.id == existingVendorId) {
              setUser(userData);
              setLoading(false);
              setHasCheckedSession(true);
              return;
            }
          } catch (e) {}
        }

        // run session checks once
        checkVendorSession();
        checkUserSession();
        setHasCheckedSession(true);
        setLoading(false);
      }
    }
  }, [token, hasCheckedSession]);

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

  const checkAuthStatus = async () => {
    if (isCheckingAuth) return;

    setIsCheckingAuth(true);
    try {
      const storedUser = localStorage.getItem("user");
      let isVendor = false;
      if (storedUser) {
        try {
          const userData = JSON.parse(storedUser);
          isVendor = userData.role === "vendor";
        } catch (e) {}
      }

      if (isVendor) {
        const vendorId = localStorage.getItem("vendor_id");
        if (!vendorId) {
          clearAuth();
          return;
        }

        const response = await fetch(`${API_BASE_URL}/api/vendor/user?vendor_id=${vendorId}`, {
          headers: {
            Accept: "application/json",
            "Content-Type": "application/json",
          },
        });

        if (response.ok) {
          const data = await response.json();
          setUser(data.user);
        } else {
          clearAuth();
        }
      } else {
        const response = await fetch(`${API_BASE_URL}/api/auth/user`, {
          headers: {
            Accept: "application/json",
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        });

        if (response.ok) {
          const data = await response.json();
          setUser(data.user);
        } else {
          if (response.status === 429) return;
          if (response.status === 401) {
            const refreshSuccess = await refreshToken();
            if (!refreshSuccess) clearAuth();
          }
        }
      }
    } catch (error) {
      clearAuth();
    } finally {
      setIsCheckingAuth(false);
    }
  };

  const clearAuth = () => {
    setUser(null);
    setToken(null);
    localStorage.removeItem("jwt_token");
    localStorage.removeItem("user");
    localStorage.removeItem("vendor_id");
  };

  const checkVendorSession = async () => {
    try {
      const response = await fetch(`${API_BASE_URL}/api/vendor/auth-status`, {
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
      });
      if (response.ok) {
        const data = await response.json();
        if (data.success && data.authenticated && data.user) {
          setUser(data.user);
          localStorage.setItem("vendor_id", data.user.id);
          localStorage.setItem("user", JSON.stringify(data.user));
        }
      }
    } catch (error) {}
  };

  const checkUserSession = async () => {
    try {
      const response = await fetch(`${API_BASE_URL}/api/user/auth-status`, {
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
      });
      if (response.ok) {
        const data = await response.json();
        if (data.success && data.authenticated && data.user) {
          setUser(data.user);
          localStorage.setItem("user", JSON.stringify(data.user));
        }
      }
    } catch (error) {}
  };

  const login = async (credentials) => {
    try {
      const response = await fetch(`${API_BASE_URL}/api/auth/login`, {
        method: "POST",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
        body: JSON.stringify(credentials),
      });
      const data = await response.json();
      if (response.ok && data.success) {
        setUser(data.user);
        setToken(data.token);
        localStorage.setItem("jwt_token", data.token);
        localStorage.setItem("user", JSON.stringify(data.user));
        return { success: true, message: data.message, user: data.user, token: data.token };
      } else {
        return { success: false, message: data.message };
      }
    } catch (error) {
      return { success: false, message: "An error occurred during login" };
    }
  };

  const logout = async () => {
    try {
      const storedUser = localStorage.getItem("user");
      let isVendor = false;
      if (storedUser) {
        try {
          const userData = JSON.parse(storedUser);
          isVendor = userData.role === "vendor";
        } catch (e) {}
      }

      clearAuth();
      window.location.href = "/";
    } catch (error) {
      clearAuth();
      window.location.href = "/";
    }
  };

  const refreshToken = async () => {
    try {
      const response = await fetch(`${API_BASE_URL}/api/auth/refresh`, {
        method: "POST",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });
      if (response.ok) {
        const data = await response.json();
        setToken(data.token);
        localStorage.setItem("jwt_token", data.token);
        return true;
      } else {
        clearAuth();
        return false;
      }
    } catch (error) {
      return false;
    }
  };

  const handleVendorVerification = async (vendorId) => {
    try {
      const response = await fetch(`${API_BASE_URL}/api/vendor/user?vendor_id=${vendorId}`, {
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
      });
      if (response.ok) {
        const data = await response.json();
        setUser(data.user);
        localStorage.setItem("vendor_id", vendorId);
        localStorage.setItem("user", JSON.stringify(data.user));
        window.history.replaceState({}, document.title, "/");
        localStorage.setItem("vendor_verification_success", "true");
        setTimeout(() => {
          window.location.href = `/vendor/dashboard?vendor_id=${vendorId}`;
        }, 500);
      } else {
        clearAuth();
        setLoading(false);
      }
    } catch (error) {
      clearAuth();
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
    window.authContext = { setUser, setToken, user, token };
    return () => {
      delete window.authContext;
    };
  }, [user, token]);

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};
