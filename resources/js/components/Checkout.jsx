import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { useAuth } from './AuthContext';
import { Footer } from './Homepage-sections/Footer';
import { Header } from './Homepage-sections/Header';

const Checkout = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const { user, loading: authLoading, token } = useAuth();
  const [formData, setFormData] = useState({
    booking_name: '',
    booking_phone: '',
    booking_email: '',
    booking_address: '',
    additional_services: [],
    gateway: '',
    coupon_code: ''
  });
  const [loading, setLoading] = useState(false);
  const [paymentProcessing, setPaymentProcessing] = useState(false);
  const [paymentError, setPaymentError] = useState('');
  const [paymentSuccess, setPaymentSuccess] = useState(false);
  const [errors, setErrors] = useState({});
  const [bookingInfo, setBookingInfo] = useState(null);
  const [dataLoading, setDataLoading] = useState(true);
  const [dataError, setDataError] = useState(null);
  const [paymentGateways, setPaymentGateways] = useState({
    online: [],
    offline: []
  });
  const [currencyInfo, setCurrencyInfo] = useState({});
  const [additionalServices, setAdditionalServices] = useState([]);
  const [selectedServices, setSelectedServices] = useState([]);
  const [couponDiscount, setCouponDiscount] = useState(0);
  const [couponApplied, setCouponApplied] = useState(false);
  
  const [iyzicoFields, setIyzicoFields] = useState({
    identity_number: '',
    zip_code: ''
  });
  const [authorizeNetFields, setAuthorizeNetFields] = useState({
    card_number: '',
    expiry_month: '',
    expiry_year: '',
    card_code: ''
  });
  const [stripeToken, setStripeToken] = useState('');
  const [stripeErrors, setStripeErrors] = useState('');
  const [anetErrors, setAnetErrors] = useState([]);
  const [opaqueDataValue, setOpaqueDataValue] = useState('');
  const [opaqueDataDescriptor, setOpaqueDataDescriptor] = useState('');
  const [showSuccessMessage, setShowSuccessMessage] = useState(false);
  const [successData, setSuccessData] = useState({});
  
  // Stripe and payment gateway states
  const [stripe, setStripe] = useState(null);
  const [cardElement, setCardElement] = useState(null);
  const [gatewayConfig, setGatewayConfig] = useState({});

  const API_BASE_URL = window.location.origin;

  useEffect(() => {
    fetchBookingData();
    fetchPaymentGateways();
    fetchCurrencyInfo();
    loadExternalScripts();
  }, []);

  useEffect(() => {
    if (bookingInfo && additionalServices.length > 0) {
      const preSelectedServices = bookingInfo.additional_services || [];
      setSelectedServices(preSelectedServices.map(service => service.id));
    }
  }, [bookingInfo, additionalServices]);

  useEffect(() => {
    return () => {
      const storedData = localStorage.getItem('bookingData');
      if (storedData) {
        const bookingData = JSON.parse(storedData);
        const oneHourAgo = Date.now() - (60 * 60 * 1000);
        if (bookingData.timestamp < oneHourAgo) {
          localStorage.removeItem('bookingData');
        }
      }
    };
  }, []);

  useEffect(() => {
    handleGatewayFieldVisibility();
  }, [formData.gateway, paymentGateways]);

  useEffect(() => {
    if (formData.gateway === 'stripe' && stripe && !cardElement) {
      initializeStripeElement();
    }
  }, [formData.gateway, stripe]);

  const fetchBookingData = async () => {
    try {
      setDataLoading(true);
      setDataError(null);
      
      const storedBookingData = localStorage.getItem('bookingData');
      if (!storedBookingData) {
        setDataError('No booking data found. Please start a new booking.');
        setDataLoading(false);
        return;
      }

      const bookingData = JSON.parse(storedBookingData);
      
      const oneHourAgo = Date.now() - (60 * 60 * 1000);
      if (bookingData.timestamp < oneHourAgo) {
        localStorage.removeItem('bookingData');
        setDataError('Booking data has expired. Please start a new booking.');
        setDataLoading(false);
        return;
      }

      const API_BASE_URL = window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
        ? import.meta.env.VITE_API_BASE_URL_LOCAL
        : import.meta.env.VITE_API_BASE_URL;

      const response = await fetch(`${API_BASE_URL}/api/room/get-checkout-data-from-params`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: JSON.stringify(bookingData)
      });

      if (response.ok) {
        const data = await response.json();
        setBookingInfo(data.booking);
        setAdditionalServices(data.additionalServices || []);
        setCurrencyInfo(data.currencyInfo);
        
        if (data.authUser) {
          setFormData(prev => ({
            ...prev,
            booking_name: data.authUser.name || '',
            booking_phone: data.authUser.phone || '',
            booking_email: data.authUser.email || '',
            booking_address: data.authUser.address || ''
          }));
        }
      } else {
        const errorData = await response.json();
        setDataError(errorData.error || 'Failed to load booking data');
      }
    } catch (error) {
      console.error('Error fetching booking data:', error);
      setDataError('Network error occurred while loading booking data');
    } finally {
      setDataLoading(false);
    }
  };

  const fetchPaymentGateways = async () => {
    try {
      const API_BASE_URL = window.location.origin;

      const response = await fetch(`${API_BASE_URL}/api/payment/gateways`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
      });

      if (response.ok) {
        const data = await response.json();
        setPaymentGateways(data);
        
        // Store gateway configuration for later use
        const config = {};
        data.online.forEach(gateway => {
          if (gateway.information) {
            try {
              config[gateway.keyword] = JSON.parse(gateway.information);
            } catch (e) {
              console.error('Error parsing gateway config:', e);
            }
          }
        });
        setGatewayConfig(config);
      } else {
        console.error('Failed to fetch payment gateways:', response.status);
      }
    } catch (error) {
      console.error('Error fetching payment gateways:', error);
    }
  };

  const fetchCurrencyInfo = async () => {
    try {
      const API_BASE_URL = window.location.origin;

      const response = await fetch(`${API_BASE_URL}/api/settings`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
      });

      if (response.ok) {
        const data = await response.json();
        setCurrencyInfo(data.currencyInfo);
      }
    } catch (error) {
      console.error('Error fetching currency info:', error);
    }
  };

  const loadExternalScripts = async () => {
    if (!window.Stripe) {
      const script = document.createElement('script');
      script.src = 'https://js.stripe.com/v3/';
      script.onload = () => {
      };
      document.head.appendChild(script);
    }
    
  };

  const initializeStripeElement = () => {
    if (!window.Stripe) {
      console.error('Stripe.js not loaded');
      return;
    }

    const stripeConfig = gatewayConfig.stripe;
    if (!stripeConfig || !stripeConfig.key) {
      console.error('Stripe configuration not found');
      return;
    }

    try {
      const stripeInstance = window.Stripe(stripeConfig.key);
      setStripe(stripeInstance);

      const elements = stripeInstance.elements();
      const cardElementInstance = elements.create('card', {
        style: {
          base: {
            iconColor: '#454545',
            color: '#454545',
            fontWeight: '500',
            lineHeight: '50px',
            fontSmoothing: 'antialiased',
            backgroundColor: '#f2f2f2',
            ':-webkit-autofill': {
              color: '#454545',
            },
            '::placeholder': {
              color: '#454545',
            },
          }
        },
      });

      // Mount the card element
      const stripeElementDiv = document.getElementById('stripe-card-element');
      if (stripeElementDiv) {
        cardElementInstance.mount('#stripe-card-element');
        setCardElement(cardElementInstance);
        
        // Listen for errors
        cardElementInstance.on('change', ({error}) => {
          const displayError = document.getElementById('stripe-errors');
          if (error) {
            setStripeErrors(error.message);
          } else {
            setStripeErrors('');
          }
        });
      }
    } catch (error) {
      console.error('Error initializing Stripe:', error);
      setStripeErrors('Failed to initialize Stripe payment');
    }
  };

  const loadAuthorizeNetScript = () => {
    const anetConfig = gatewayConfig['authorize.net'];
    if (!anetConfig) return;

    const scriptSrc = anetConfig.sandbox_check == 1 
      ? 'https://jstest.authorize.net/v1/Accept.js'
      : 'https://js.authorize.net/v1/Accept.js';

    if (!document.querySelector(`script[src="${scriptSrc}"]`)) {
      const script = document.createElement('script');
      script.src = scriptSrc;
      script.onload = () => {
      };
      document.head.appendChild(script);
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
    
    if (errors[name]) {
      setErrors(prev => ({
        ...prev,
        [name]: ''
      }));
    }
  };

  const handleGatewayChange = (e) => {
    const { value } = e.target;
    
    setFormData(prev => ({
      ...prev,
      gateway: value
    }));
    
    if (errors.gateway) {
      setErrors(prev => ({
        ...prev,
        gateway: ''
      }));
    }
    
    setStripeErrors('');
    setAnetErrors([]);
    
    // Load specific scripts based on gateway selection
    if (value === 'stripe') {
      setTimeout(() => {
        if (window.Stripe && gatewayConfig.stripe) {
          initializeStripeElement();
        }
      }, 100);
    } else if (value === 'authorize.net') {
      loadAuthorizeNetScript();
    }
  };

  const handleGatewayFieldVisibility = () => {
    if (!formData.gateway || !paymentGateways.online.length) return;

    const value = formData.gateway;
    const dataType = parseInt(value);

    if (isNaN(dataType)) {
      if (value === 'authorize.net') {
        document.getElementById('tab-anet')?.classList.remove('hidden');
      } else {
        document.getElementById('tab-anet')?.classList.add('hidden');
      }

      if (value === 'stripe') {
        document.getElementById('stripe-element')?.classList.remove('hidden');
        document.querySelector('.iyzico-element')?.classList.add('hidden');
      } else if (value === 'iyzico') {
        document.querySelector('.iyzico-element')?.classList.remove('hidden');
        document.getElementById('stripe-element')?.classList.add('hidden');
      } else {
        document.getElementById('stripe-element')?.classList.add('hidden');
        document.querySelector('.iyzico-element')?.classList.add('hidden');
      }
    } else {
      document.getElementById('stripe-element')?.classList.add('hidden');
      document.querySelector('.iyzico-element')?.classList.add('hidden');
      document.getElementById('tab-anet')?.classList.add('hidden');

      document.querySelectorAll('.offline-gateway-info').forEach(el => {
        el.classList.add('hidden');
      });
      document.getElementById(`offline-gateway-${value}`)?.classList.remove('hidden');
    }
  };

  const handleIyzicoFieldChange = (field, value) => {
    setIyzicoFields(prev => ({
      ...prev,
      [field]: value
    }));
  };

  const handleAuthorizeNetFieldChange = (field, value) => {
    setAuthorizeNetFields(prev => ({
      ...prev,
      [field]: value
    }));
  };

  const handleServiceToggle = (serviceId) => {
    setSelectedServices(prev => {
      if (prev.includes(serviceId)) {
        return prev.filter(id => id !== serviceId);
      } else {
        return [...prev, serviceId];
      }
    });
  };

  const applyCoupon = async () => {
    if (!formData.coupon_code.trim()) return;

    try {
      setLoading(true);
      const API_BASE_URL = window.location.origin;

      const response = await fetch(`${API_BASE_URL}/api/room/apply-coupon`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        credentials: 'include',
        body: JSON.stringify({
          coupon: formData.coupon_code,
          room_id: bookingInfo.room.id,
          price: bookingInfo.price
        })
      });

      const data = await response.json();

      if (response.ok) {
        setCouponDiscount(data.discount || 0);
        setCouponApplied(true);
        setErrors(prev => ({ ...prev, coupon: '' }));
      } else {
        setErrors(prev => ({ ...prev, coupon: data.error || 'Invalid coupon code' }));
        setCouponDiscount(0);
        setCouponApplied(false);
      }
    } catch (error) {
      setErrors(prev => ({ ...prev, coupon: 'Network error occurred' }));
    } finally {
      setLoading(false);
    }
  };

  const validateGatewayFields = () => {
    const newErrors = {};
    
    if (formData.gateway === 'iyzico') {
      if (!iyzicoFields.identity_number.trim()) {
        newErrors.identity_number = 'Identity number is required for Iyzico';
      }
      if (!iyzicoFields.zip_code.trim()) {
        newErrors.zip_code = 'Zip code is required for Iyzico';
      }
    } else if (formData.gateway === 'authorize.net') {
      if (!authorizeNetFields.card_number.trim()) {
        newErrors.card_number = 'Card number is required';
      }
      if (!authorizeNetFields.expiry_month || !authorizeNetFields.expiry_year) {
        newErrors.expiry = 'Expiry date is required';
      }
      if (!authorizeNetFields.card_code.trim()) {
        newErrors.card_code = 'Card code is required';
      }
    }
    
    return newErrors;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setPaymentError('');
    setPaymentSuccess(false);

    try {
      const storedBookingData = localStorage.getItem('bookingData');
      if (!storedBookingData) {
        setPaymentError('No booking data found. Please go back and try again.');
        setLoading(false);
        return;
      }

      const bookingData = JSON.parse(storedBookingData);

      if (!bookingData.room_id || !bookingData.price || !bookingData.checkInDate || !bookingData.checkInTime) {
        setPaymentError('Incomplete booking data. Please go back and try again.');
        setLoading(false);
        return;
      }

      if (formData.gateway !== 'offline' && !token) {
        setPaymentError('Please login to use online payment methods.');
        setLoading(false);
        return;
      }

      if (!formData.booking_name || !formData.booking_email || !formData.booking_phone) {
        setPaymentError('Please fill in all required fields (name, email, phone).');
        setLoading(false);
        return;
      }

      const submitFormData = new FormData();
      submitFormData.append('gateway', formData.gateway);
      submitFormData.append('booking_name', formData.booking_name);
      submitFormData.append('booking_phone', formData.booking_phone);
      submitFormData.append('booking_email', formData.booking_email);
      submitFormData.append('booking_address', formData.booking_address || '');
      submitFormData.append('room_id', bookingData.room_id);
      submitFormData.append('hour_id', bookingData.hour_id || '');
      submitFormData.append('price', bookingData.price);
      submitFormData.append('checkInDate', bookingData.checkInDate);
      submitFormData.append('checkInTime', bookingData.checkInTime);
      submitFormData.append('adult', bookingData.adult || 1);
      submitFormData.append('children', bookingData.children || 0);
      
      if (selectedServices && selectedServices.length > 0) {
        selectedServices.forEach((serviceId, index) => {
          submitFormData.append(`additional_services[${index}]`, serviceId);
        });
      }
      if (formData.gateway === 'stripe') {
        if (!stripe || !cardElement) {
          setPaymentError('Stripe not initialized. Please try again.');
          setLoading(false);
          return;
        }

        setPaymentProcessing(true);
        const { token: stripeToken, error } = await stripe.createToken(cardElement);
        
        if (error) {
          setPaymentError(`Stripe error: ${error.message}`);
          setPaymentProcessing(false);
          setLoading(false);
          return;
        }

        submitFormData.append('stripeToken', stripeToken.id);
        const response = await fetch('/api/room/online-booking', {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${token}`,
            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          },
          body: submitFormData
        });

        const result = await response.json();
        
        if (result.success) {
          setPaymentSuccess(true);
          localStorage.removeItem('bookingData');
          window.location.href = result.redirect_url || '/booking-success';
        } else {
          setPaymentError(result.message || 'Payment failed. Please try again.');
        }
      } else if (formData.gateway === 'authorize.net') {
        setPaymentProcessing(true);
        const authNetToken = await processAuthorizeNetPayment();
        
        if (!authNetToken) {
          setPaymentError('Failed to process Authorize.net payment.');
          setPaymentProcessing(false);
          setLoading(false);
          return;
        }

        submitFormData.append('authorizeNetToken', authNetToken);
        
        const response = await fetch('/api/room/online-booking', {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${token}`,
            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          },
          body: submitFormData
        });

        const result = await response.json();
        
        if (result.success) {
          setPaymentSuccess(true);
          localStorage.removeItem('bookingData');
          window.location.href = result.redirect_url || '/booking-success';
        } else {
          setPaymentError(result.message || 'Payment failed. Please try again.');
        }
      } else if (formData.gateway === 'offline') {
        setPaymentSuccess(true);
        localStorage.removeItem('bookingData');
        window.location.href = '/booking-success';
      } else {
        const response = await fetch('/api/room/online-booking', {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${token}`,
            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
          },
          body: submitFormData
        });

        const result = await response.json();
        
        if (result.success) {
          setPaymentSuccess(true);
          localStorage.removeItem('bookingData');
          window.location.href = result.redirect_url || '/booking-success';
        } else {
          setPaymentError(result.message || 'Payment failed. Please try again.');
        }
      }
    } catch (error) {
      console.error('Payment error:', error);
      setPaymentError('An error occurred during payment processing. Please try again.');
    } finally {
      setLoading(false);
      setPaymentProcessing(false);
    }
  };

  const processBookingSubmission = async (stripeTokenId = null) => {
    try {
      setLoading(true);
      const API_BASE_URL = window.location.origin;

      const storedBookingData = localStorage.getItem('bookingData');
      const bookingData = JSON.parse(storedBookingData);

      let paymentData = {
        ...formData,
        additional_services: selectedServices,
        ...bookingData
      };
      

      if (formData.gateway === 'iyzico') {
        paymentData.identity_number = iyzicoFields.identity_number;
        paymentData.zip_code = iyzicoFields.zip_code;
      } else if (formData.gateway === 'authorize.net') {
        paymentData.opaqueDataValue = opaqueDataValue;
        paymentData.opaqueDataDescriptor = opaqueDataDescriptor;
      } else if (formData.gateway === 'stripe') {
        paymentData.stripeToken = stripeTokenId || stripeToken;
      }

      if (isOnlineGateway(formData.gateway)) {
        
        try {
          const response = await fetch(`${API_BASE_URL}/api/room/online-booking`, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': `Bearer ${token}`,
            },
            body: JSON.stringify(paymentData)
          });

          
          const data = await response.json();

          if (response.ok && data.success) {
            localStorage.setItem('onlineBookingData', JSON.stringify({
              ...data.payment_data,
              timestamp: Date.now()
            }));
            
            const queryParams = new URLSearchParams();
            
            queryParams.append('gateway', formData.gateway);
            queryParams.append('booking_id', data.booking_id);
            queryParams.append('order_number', data.order_number);
            queryParams.append('amount', data.payment_data.total_amount);
            queryParams.append('currency', data.payment_data.currency);
            queryParams.append('customer_name', data.payment_data.customer_name);
            queryParams.append('customer_email', data.payment_data.customer_email);
            queryParams.append('customer_phone', data.payment_data.customer_phone);
            queryParams.append('room_id', data.payment_data.room_id);
            queryParams.append('check_in_date', data.payment_data.check_in_date);
            queryParams.append('check_in_time', data.payment_data.check_in_time);
            queryParams.append('adult', data.payment_data.adult);
            queryParams.append('children', data.payment_data.children);
            
            if (data.payment_data.additional_services && data.payment_data.additional_services.length > 0) {
              queryParams.append('additional_services', JSON.stringify(data.payment_data.additional_services));
            }
            
            queryParams.append('tax_amount', data.payment_data.tax_amount);
            
            const redirectUrl = `${API_BASE_URL}/room/room-booking?${queryParams.toString()}`;
            window.location.href = redirectUrl;
          } else {
            setErrors(data.errors || { general: data.message || 'Online booking failed' });
          }
        } catch (error) {
          console.error('Online booking API call failed:', error);
          setErrors({ general: 'Network error occurred while processing online booking: ' + error.message });
        }
        return;
      } else {
        
        const response = await fetch(`${API_BASE_URL}/api/room/booking`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': `Bearer ${token}`,
          },
          body: JSON.stringify(paymentData)
        });

        const data = await response.json();

        if (response.ok && data.success) {
          localStorage.removeItem('bookingData');
          
          setSuccessData({
            message: data.message,
            booking_id: data.booking_id,
            order_number: data.order_number
          });
          setShowSuccessMessage(true);
          
          setTimeout(() => {
            setShowSuccessMessage(false);
            if (data.redirect_url) {
              window.location.href = data.redirect_url;
            } else {
              window.location.href = '/';
            }
          }, 5000);
        } else {
          setErrors(data.errors || { general: data.message || 'Booking failed' });
        }
      }
    } catch (error) {
      console.error('Booking submission error:', error);
      setErrors({ general: 'Network error occurred: ' + error.message });
    } finally {
      setLoading(false);
    }
  };

  const formatPrice = (price) => {
    if (!currencyInfo || !price) return `$${price}`;
    
    const { base_currency_symbol, base_currency_symbol_position } = currencyInfo;
    const symbol = base_currency_symbol || '$';
    
    if (base_currency_symbol_position === 'left') {
      return `${symbol}${price}`;
    } else {
      return `${price}${symbol}`;
    }
  };

  const isOnlineGateway = (gatewayValue) => {
    if (!gatewayValue) {
      return false;
    }
    
    const onlineGateway = paymentGateways.online.find(g => g.keyword === gatewayValue);
    if (onlineGateway) {
      return true;
    }
    
    const offlineGateway = paymentGateways.offline.find(g => g.id == gatewayValue);
    if (offlineGateway) {
      return false;
    }
    
    if (!isNaN(gatewayValue) && gatewayValue !== '') {
      return false;
    }
    
    if (typeof gatewayValue === 'string' && gatewayValue.length > 0) {
      return true;
    }
    
    return true;
  };

  const processAuthorizeNetPayment = async () => {
    const anetConfig = gatewayConfig['authorize.net'];
    if (!anetConfig || !window.Accept) {
      setErrors({ authorize: 'Authorize.net payment system not initialized' });
      return;
    }

    const authData = {};
    authData.clientKey = anetConfig.public_key;
    authData.apiLoginID = anetConfig.login_id;

    const cardData = {};
    cardData.cardNumber = authorizeNetFields.card_number;
    cardData.month = authorizeNetFields.expiry_month;
    cardData.year = authorizeNetFields.expiry_year;
    cardData.cardCode = authorizeNetFields.card_code;

    const secureData = {};
    secureData.authData = authData;
    secureData.cardData = cardData;

    return new Promise((resolve, reject) => {
      window.Accept.dispatchData(secureData, (response) => {
        if (response.messages.resultCode === "Error") {
          const errorMessages = response.messages.message.map(msg => msg.text);
          setAnetErrors(errorMessages);
          reject(new Error(errorMessages.join(', ')));
        } else {
          setOpaqueDataDescriptor(response.opaqueData.dataDescriptor);
          setOpaqueDataValue(response.opaqueData.dataValue);
          setAnetErrors([]);
          
          // Process booking with opaque data
          processBookingSubmission().then(resolve).catch(reject);
        }
      });
    });
  };

  if (dataLoading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-gray-600">Loading checkout information...</p>
        </div>
      </div>
    );
  }

  if (dataError || !bookingInfo) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <div className="text-red-500 mb-4">
            <svg className="w-16 h-16 mx-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z" />
            </svg>
          </div>
          <h2 className="text-xl font-semibold text-gray-900 mb-2">Unable to Load Checkout</h2>
          <p className="text-gray-600 mb-4">{dataError || 'Booking information is missing or invalid'}</p>
          <button
            onClick={() => window.location.href = '/'}
            className="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700"
          >
            Return to home
          </button>
        </div>
      </div>
    );
  }

  return (
    <>
    <Header bgColor="bg-black" />
        <div className="min-h-screen bg-gray-50 py-8 pt-24">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900">Checkout</h1>
          <p className="text-gray-600 mt-2">Complete your booking and payment</p>
        </div>

        {showSuccessMessage && (
          <div className="mb-6 bg-green-50 border border-green-200 rounded-lg p-6">
            <div className="flex items-center">
              <div className="flex-shrink-0">
                <svg className="h-8 w-8 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </div>
              <div className="ml-3">
                <h3 className="text-lg font-medium text-green-800">Booking Successful!</h3>
                <div className="mt-2 text-sm text-green-700">
                  <p>{successData.message}</p>
                  <div className="mt-2 space-y-1">
                    <p><strong>Booking ID:</strong> {successData.booking_id}</p>
                    <p><strong>Order Number:</strong> {successData.order_number}</p>
                  </div>
                  <p className="mt-2 text-xs">Redirecting in a few seconds...</p>
                </div>
              </div>
            </div>
          </div>
        )}

        {/* Payment Status Messages */}
        {paymentSuccess && (
          <div className="mb-6 p-4 bg-green-100 border border-green-400 text-green-700 rounded">
            <p className="font-medium">Payment Successful!</p>
            <p>Redirecting to success page...</p>
          </div>
        )}

        {paymentError && (
          <div className="mb-6 p-4 bg-red-100 border border-red-400 text-red-700 rounded">
            <p className="font-medium">Payment Error</p>
            <p>{paymentError}</p>
          </div>
        )}

        {paymentProcessing && (
          <div className="mb-6 p-4 bg-blue-100 border border-blue-400 text-blue-700 rounded">
            <p className="font-medium">Processing Payment...</p>
            <p>Please wait while we process your payment.</p>
          </div>
        )}

        <form onSubmit={handleSubmit} className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <div className="lg:col-span-2 space-y-6">
            <div className="bg-white rounded-lg shadow p-6">
              <h2 className="text-xl font-semibold text-gray-900 mb-4">Personal Information</h2>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Full Name *
                  </label>
                  <input
                    type="text"
                    name="booking_name"
                    value={formData.booking_name}
                    onChange={handleInputChange}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      errors.booking_name ? 'border-red-500' : 'border-gray-300'
                    }`}
                    placeholder="Enter your full name"
                  />
                  {errors.booking_name && (
                    <p className="mt-1 text-sm text-red-600">{errors.booking_name}</p>
                  )}
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Phone Number *
                  </label>
                  <input
                    type="tel"
                    name="booking_phone"
                    value={formData.booking_phone}
                    onChange={handleInputChange}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      errors.booking_phone ? 'border-red-500' : 'border-gray-300'
                    }`}
                    placeholder="Enter phone number"
                  />
                  {errors.booking_phone && (
                    <p className="mt-1 text-sm text-red-600">{errors.booking_phone}</p>
                  )}
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Email Address *
                  </label>
                  <input
                    type="email"
                    name="booking_email"
                    value={formData.booking_email}
                    onChange={handleInputChange}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      errors.booking_email ? 'border-red-500' : 'border-gray-300'
                    }`}
                    placeholder="Enter email address"
                  />
                  {errors.booking_email && (
                    <p className="mt-1 text-sm text-red-600">{errors.booking_email}</p>
                  )}
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Address *
                  </label>
                  <input
                    type="text"
                    name="booking_address"
                    value={formData.booking_address}
                    onChange={handleInputChange}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      errors.booking_address ? 'border-red-500' : 'border-gray-300'
                    }`}
                    placeholder="Enter your address"
                  />
                  {errors.booking_address && (
                    <p className="mt-1 text-sm text-red-600">{errors.booking_address}</p>
                  )}
                </div>
              </div>
            </div>

            {additionalServices.length > 0 && (
              <div className="bg-white rounded-lg shadow p-6">
                <h2 className="text-xl font-semibold text-gray-900 mb-4">Additional Services</h2>
                <div className="space-y-3">
                  {additionalServices.map((service) => (
                    <div key={service.id} className="flex items-center justify-between p-3 border rounded-lg">
                      <div className="flex items-center space-x-3">
                        <input
                          type="checkbox"
                          id={`service-${service.id}`}
                          checked={selectedServices.includes(service.id)}
                          onChange={() => handleServiceToggle(service.id)}
                          className="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                        />
                        <label htmlFor={`service-${service.id}`} className="text-sm font-medium text-gray-700">
                          {service.title}
                        </label>
                      </div>
                      <span className="text-sm font-medium text-gray-900">
                        {formatPrice(service.charge)}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            )}

            <div className="bg-white rounded-lg shadow p-6">
              <h2 className="text-xl font-semibold text-gray-900 mb-4">Coupon Code</h2>
              <div className="flex space-x-3">
                <input
                  type="text"
                  name="coupon_code"
                  value={formData.coupon_code}
                  onChange={handleInputChange}
                  className={`flex-1 px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                    errors.coupon ? 'border-red-500' : 'border-gray-300'
                  }`}
                  placeholder="Enter coupon code"
                />
                <button
                  type="button"
                  onClick={applyCoupon}
                  disabled={loading || !formData.coupon_code.trim()}
                  className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  Apply
                </button>
              </div>
              {errors.coupon && (
                <p className="mt-2 text-sm text-red-600">{errors.coupon}</p>
              )}
              {couponApplied && (
                <p className="mt-2 text-sm text-green-600">Coupon applied successfully!</p>
              )}
            </div>

            <div className="bg-white rounded-lg shadow p-6">
              <h2 className="text-xl font-semibold text-gray-900 mb-4">Payment Method</h2>
              <div className="space-y-4">
                <select
                  name="gateway"
                  value={formData.gateway}
                  onChange={handleGatewayChange}
                  className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                    errors.gateway ? 'border-red-500' : 'border-gray-300'
                  }`}
                >
                  <option value="">Choose a Payment Method</option>
                  {paymentGateways.online.filter(gateway => gateway.status == 1).map((gateway) => (
                    <option key={gateway.keyword} value={gateway.keyword}>
                      {gateway.name} (Online)
                    </option>
                  ))}
                  {paymentGateways.offline.filter(gateway => gateway.status == 1).map((gateway) => (
                    <option key={gateway.id} value={gateway.id}>
                      {gateway.name} (Offline)
                    </option>
                  ))}
                </select>
                {errors.gateway && (
                  <p className="text-sm text-red-600">{errors.gateway}</p>
                )}

                <div className="iyzico-element hidden">
                  <div className="space-y-4">
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-2">
                        Identity Number *
                      </label>
                      <input
                        type="text"
                        name="identity_number"
                        value={iyzicoFields.identity_number}
                        onChange={(e) => handleIyzicoFieldChange('identity_number', e.target.value)}
                        className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                          errors.identity_number ? 'border-red-500' : 'border-gray-300'
                        }`}
                        placeholder="Identity Number"
                      />
                      {errors.identity_number && (
                        <p className="mt-1 text-sm text-red-600">{errors.identity_number}</p>
                      )}
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-2">
                        Zip Code *
                      </label>
                      <input
                        type="text"
                        name="zip_code"
                        value={iyzicoFields.zip_code}
                        onChange={(e) => handleIyzicoFieldChange('zip_code', e.target.value)}
                        className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                          errors.zip_code ? 'border-red-500' : 'border-gray-300'
                        }`}
                        placeholder="Zip Code"
                      />
                      {errors.zip_code && (
                        <p className="mt-1 text-sm text-red-600">{errors.zip_code}</p>
                      )}
                    </div>
                  </div>
                </div>

                <div id="stripe-element" className="mb-2 hidden">
                  <div id="stripe-card-element" className="p-3 border border-gray-300 rounded-md min-h-[40px] bg-gray-50">
                    {/* Stripe card element will be mounted here */}
                  </div>
                </div>
                <div id="stripe-errors" role="alert" className={stripeErrors ? '' : 'hidden'}>
                  {stripeErrors && <p className="text-red-600 text-sm">{stripeErrors}</p>}
                </div>

                <div className="row gateway-details pt-3 hidden" id="tab-anet">
                  <div className="grid grid-cols-2 gap-4">
                    <div className="col-span-2">
                      <div className="form-group mb-3">
                        <input
                          className="form-control w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                          type="text"
                          id="anetCardNumber"
                          placeholder="Card Number"
                          value={authorizeNetFields.card_number}
                          onChange={(e) => handleAuthorizeNetFieldChange('card_number', e.target.value)}
                        />
                        {errors.card_number && (
                          <p className="mt-1 text-sm text-red-600">{errors.card_number}</p>
                        )}
                      </div>
                    </div>
                    <div className="col-span-1">
                      <div className="form-group mb-3">
                        <input
                          className="form-control w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                          type="text"
                          id="anetExpMonth"
                          placeholder="Expire Month"
                          value={authorizeNetFields.expiry_month}
                          onChange={(e) => handleAuthorizeNetFieldChange('expiry_month', e.target.value)}
                        />
                      </div>
                    </div>
                    <div className="col-span-1">
                      <div className="form-group mb-3">
                        <input
                          className="form-control w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                          type="text"
                          id="anetExpYear"
                          placeholder="Expire Year"
                          value={authorizeNetFields.expiry_year}
                          onChange={(e) => handleAuthorizeNetFieldChange('expiry_year', e.target.value)}
                        />
                      </div>
                    </div>
                    <div className="col-span-2">
                      <div className="form-group mb-3">
                        <input
                          className="form-control w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                          type="text"
                          id="anetCardCode"
                          placeholder="Card Code"
                          value={authorizeNetFields.card_code}
                          onChange={(e) => handleAuthorizeNetFieldChange('card_code', e.target.value)}
                        />
                        {errors.card_code && (
                          <p className="mt-1 text-sm text-red-600">{errors.card_code}</p>
                        )}
                      </div>
                    </div>
                  </div>
                  <input type="hidden" name="opaqueDataValue" id="opaqueDataValue" value={opaqueDataValue} />
                  <input type="hidden" name="opaqueDataDescriptor" id="opaqueDataDescriptor" value={opaqueDataDescriptor} />
                  <ul id="anetErrors" className={anetErrors.length > 0 ? '' : 'hidden'}>
                    {anetErrors.map((error, index) => (
                      <li key={index} className="text-danger">{error}</li>
                    ))}
                  </ul>
                </div>

                {paymentGateways.offline.filter(gateway => gateway.status == 1).map((offlineGateway) => (
                  <div
                    key={offlineGateway.id}
                    className="offline-gateway-info hidden"
                    id={`offline-gateway-${offlineGateway.id}`}
                  >
                    {offlineGateway.short_description && (
                      <div className="form-group mb-3">
                        <label className="block text-sm font-medium text-gray-700 mb-2">Description</label>
                        <p className="text-gray-600">{offlineGateway.short_description}</p>
                      </div>
                    )}
                    {offlineGateway.instructions && (
                      <div className="form-group mb-3">
                        <label className="block text-sm font-medium text-gray-700 mb-2">Instructions</label>
                        <div className="text-gray-600" dangerouslySetInnerHTML={{ __html: offlineGateway.instructions }} />
                      </div>
                    )}
                    {offlineGateway.has_attachment == 1 && (
                      <div className="form-group mb-3">
                        <label className="block text-sm font-medium text-gray-700 mb-2">Attachment *</label>
                        <br />
                        <input
                          type="file"
                          name="attachment"
                          className="w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                        />
                        {errors.attachment && (
                          <p className="mt-1 text-sm text-red-600">{errors.attachment}</p>
                        )}
                      </div>
                    )}
                  </div>
                ))}

                <div className="text-center pt-4">
                  <button
                    type="submit"
                    disabled={loading || paymentProcessing}
                    className={`w-full py-3 px-6 rounded-lg font-medium text-white transition-colors ${
                      loading || paymentProcessing
                        ? 'bg-gray-400 cursor-not-allowed'
                        : 'bg-blue-600 hover:bg-blue-700'
                    }`}
                  >
                    {loading ? 'Loading...' : paymentProcessing ? 'Processing Payment...' : 'Book Now'}
                  </button>
                  {errors.general && (
                    <p className="mt-2 text-sm text-red-600 text-center">{errors.general}</p>
                  )}
                </div>
              </div>
            </div>
          </div>

          <div className="space-y-6">
            <div className="bg-white rounded-lg shadow p-6">
              <h2 className="text-xl font-semibold text-gray-900 mb-4">Booking Summary</h2>
              <div className="space-y-3">
                <div className="flex justify-between">
                  <span className="text-gray-600">Room</span>
                  <span className="font-medium">{bookingInfo.room?.title}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-600">Check-in Date</span>
                  <span className="font-medium">{bookingInfo.checkInDate}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-600">Check-in Time</span>
                  <span className="font-medium">{bookingInfo.checkInTime}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-600">Duration</span>
                  <span className="font-medium">{bookingInfo.hour} Hours</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-600">Guests</span>
                  <span className="font-medium">
                    {bookingInfo.adult} Adult{bookingInfo.adult > 1 ? 's' : ''}
                    {bookingInfo.children > 0 && `, ${bookingInfo.children} Child${bookingInfo.children > 1 ? 'ren' : ''}`}
                  </span>
                </div>
              </div>
            </div>

            <div className="bg-white rounded-lg shadow p-6">
              <h2 className="text-xl font-semibold text-gray-900 mb-4">Payment Summary</h2>
              <div className="space-y-3">
                <div className="flex justify-between">
                  <span className="text-gray-600">Room Price</span>
                  <span className="font-medium">{formatPrice(bookingInfo.price)}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-gray-600">Base Service Charge</span>
                  <span className="font-medium">{formatPrice(bookingInfo.serviceCharge || 0)}</span>
                </div>
                {selectedServices.length > 0 && (
                  <div className="flex justify-between">
                    <span className="text-gray-600">Additional Services</span>
                    <span className="font-medium">
                      {formatPrice(selectedServices.reduce((total, serviceId) => {
                        const service = additionalServices.find(s => s.id == serviceId);
                        return total + (parseFloat(service?.charge) || 0);
                      }, 0))}
                    </span>
                  </div>
                )}
                {couponApplied && (
                  <div className="flex justify-between text-green-600">
                    <span>Coupon Discount</span>
                    <span>-{formatPrice(couponDiscount)}</span>
                  </div>
                )}
                <div className="flex justify-between">
                  <span className="text-gray-600">Tax ({(bookingInfo.tax || 0)}%)</span>
                  <span className="font-medium">
                    {formatPrice((parseFloat(bookingInfo.price || 0) + parseFloat(bookingInfo.serviceCharge || 0) + selectedServices.reduce((total, serviceId) => {
                      const service = additionalServices.find(s => s.id == serviceId);
                      return total + (parseFloat(service?.charge) || 0);
                    }, 0) - couponDiscount) * (parseFloat(bookingInfo.tax || 0) / 100))}
                  </span>
                </div>
                <hr className="my-3" />
                <div className="flex justify-between text-lg font-semibold">
                  <span>Total</span>
                  <span>
                    {formatPrice(
                      parseFloat(bookingInfo.price || 0) + 
                      parseFloat(bookingInfo.serviceCharge || 0) + 
                      selectedServices.reduce((total, serviceId) => {
                        const service = additionalServices.find(s => s.id == serviceId);
                        return total + (parseFloat(service?.charge) || 0);
                      }, 0) - 
                      couponDiscount + 
                      ((parseFloat(bookingInfo.price || 0) + parseFloat(bookingInfo.serviceCharge || 0) + selectedServices.reduce((total, serviceId) => {
                        const service = additionalServices.find(s => s.id == serviceId);
                        return total + (parseFloat(service?.charge) || 0);
                      }, 0) - couponDiscount) * (parseFloat(bookingInfo.tax || 0) / 100))
                    )}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    <Footer />
    </>

  );
};

export default Checkout;
