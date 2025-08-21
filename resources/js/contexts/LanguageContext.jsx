import React, { createContext, useContext, useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { changeLanguage, isRTL, RTL_LANGUAGES } from '../i18n';
const LanguageContext = createContext();
export const useLanguage = () => {
  const context = useContext(LanguageContext);
  if (!context) {
    throw new Error('useLanguage must be used within a LanguageProvider');
  }
  return context;
};
export const LanguageProvider = ({ children }) => {
  const { i18n } = useTranslation();
  const [currentLanguage, setCurrentLanguage] = useState(null);
  const [languages, setLanguages] = useState([]);
  const [loading, setLoading] = useState(true);
  const [direction, setDirection] = useState('ltr');
  const API_BASE_URL =
    window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
      ? import.meta.env.VITE_API_BASE_URL_LOCAL
      : import.meta.env.VITE_API_BASE_URL;
  const fetchLanguages = async () => {
    try {
      const response = await fetch(`${API_BASE_URL}/api/languages`);
      const data = await response.json();
      if (data.success && data.data) {
        setLanguages(data.data);
        const savedLanguage = localStorage.getItem('selectedLanguage');
        if (savedLanguage) {
          try {
            const parsedLanguage = JSON.parse(savedLanguage);
            const validLanguage = data.data.find(lang => lang.code === parsedLanguage.code);
            if (validLanguage) {
              await setLanguageAndDirection(validLanguage);
              setLoading(false);
              return;
            }
          } catch (e) {
            console.error('Error parsing saved language:', e);
          }
        }
        const defaultLang = data.data.find(lang => lang.is_default === 1);
        if (defaultLang) {
          await setLanguageAndDirection(defaultLang);
        }
      }
    } catch (error) {
      console.error('Error fetching languages:', error);
    } finally {
      setLoading(false);
    }
  };
  const setLanguageAndDirection = async (language) => {
    const isRTLLang = language.direction === 1 || (language.direction === null && RTL_LANGUAGES.includes(language.code));
    const dir = isRTLLang ? 'rtl' : 'ltr';
    setCurrentLanguage(language);
    setDirection(dir);
    await changeLanguage(language.code, dir);
    document.documentElement.dir = dir;
    document.documentElement.lang = language.code;
    document.body.classList.remove('rtl', 'ltr');
    document.body.classList.add(dir);
    if (dir === 'rtl') {
      document.body.style.direction = 'rtl';
      document.body.style.textAlign = 'right';
    } else {
      document.body.style.direction = 'ltr';
      document.body.style.textAlign = 'left';
    }
  };
  const handleLanguageChange = async (language) => {
    try {
      await setLanguageAndDirection(language);
      const response = await fetch(`${API_BASE_URL}/api/change-language`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        credentials: 'include',
        body: JSON.stringify({ code: language.code })
      });
      if (response.ok) {
        const result = await response.json();
      } else {
        console.warn('Failed to sync language with backend, using fallback');
        try {
          await fetch(`/change-language?code=${language.code}`, {
            method: 'GET',
            credentials: 'include',
          });
        } catch (fallbackError) {
          console.error('Fallback language change also failed:', fallbackError);
        }
      }
      localStorage.setItem('selectedLanguage', JSON.stringify({
        code: language.code,
        name: language.name,
        direction: language.direction === 'rtl' || RTL_LANGUAGES.includes(language.code) ? 'rtl' : 'ltr'
      }));
      return true;
    } catch (error) {
      console.error('Error changing language:', error);
      return false;
    }
  };
  useEffect(() => {
    fetchLanguages();
  }, []);
  useEffect(() => {
    const handleLanguageChanged = (lng) => {
      const isRTLLang = RTL_LANGUAGES.includes(lng);
      const dir = isRTLLang ? 'rtl' : 'ltr';
      setDirection(dir);
      document.documentElement.dir = dir;
      document.documentElement.lang = lng;
      document.body.classList.remove('rtl', 'ltr');
      document.body.classList.add(dir);
    };
    i18n.on('languageChanged', handleLanguageChanged);
    return () => {
      i18n.off('languageChanged', handleLanguageChanged);
    };
  }, [i18n]);
  const value = {
    currentLanguage,
    languages,
    loading,
    direction,
    isRTL: direction === 'rtl',
    changeLanguage: handleLanguageChange,
    fetchLanguages
  };
  return (
    <LanguageContext.Provider value={value}>
      {children}
    </LanguageContext.Provider>
  );
};
export default LanguageContext;
