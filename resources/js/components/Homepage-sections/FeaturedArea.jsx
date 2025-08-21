import React, { useEffect, useState } from 'react'
import { useLanguage } from '../../contexts/LanguageContext'
import { t } from 'i18next';
export const FeaturedArea = ({title,text}) => {
  const [feature1, setFeature1] = useState(null);
  const [feature2, setFeature2] = useState(null);
  const [features, setFeatures] = useState([]);
    const [loading, setLoading] = useState(true);
    const { currentLanguage } = useLanguage();
  const API_BASE_URL =
    window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
      ? import.meta.env.VITE_API_BASE_URL_LOCAL
      : import.meta.env.VITE_API_BASE_URL;

  useEffect(() => {
    const fetchImages = async () => {
      try {
        const routeResponse = await fetch(`${API_BASE_URL}/api/routes`);
        const routes = await routeResponse.json();
        const res = await fetch(routes.basicImages);
        const data = await res.json();
        if (data) {
          if (data.feature_section_image) {
            setFeature1(`${API_BASE_URL}/assets/img/homepage/${data.feature_section_image}`);
          }
          if (data.feature_section_image2) {
            setFeature2(`${API_BASE_URL}/assets/img/homepage/${data.feature_section_image2}`);
          }
        }
      } catch (e) {
      }
    };
    fetchImages();
  }, [API_BASE_URL]);
  useEffect(() => {
      const fetchFeatures = async () => {
        try {
          setLoading(true);
          const currentLangCode = currentLanguage?.code || 'en';
          const response = await fetch(`${API_BASE_URL}/api/features?lang=${currentLangCode}`);
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
          const featuresData = await response.json();
          setFeatures(featuresData)
        } catch (error) {
          fetchImagesFallback();
        } finally {
          setLoading(false);
        }
      };
  
      const fetchImagesFallback = async () => {
        try {
          const routeResponse = await fetch(`${API_BASE_URL}/api/routes`);
          const routes = await routeResponse.json();
          const res = await fetch(routes.basicImages);
          const data = await res.json();
          if (data) {
            if (data.feature_section_image) {
              setFeature1(`${API_BASE_URL}/assets/img/homepage/${data.feature_section_image}`);
            }
            if (data.feature_section_image2) {
              setFeature2(`${API_BASE_URL}/assets/img/homepage/${data.feature_section_image2}`);
            }
          }
        } catch (e) {
        }
      };
      fetchFeatures();
    }, [API_BASE_URL, currentLanguage]);
  
  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-3 px-4 md:px-8 bg-[#f7fbff] items-center">
      <div 
        data-aos="fade-right"
        data-aos-duration="800"
        data-aos-delay="100"
        className="flex flex-col justify-center h-full md:ml-[64px] mb-8 md:mb-[13rem] order-2 md:order-1"
      > 
        <p className="uppercase text-xs md:text-sm text-gray-500">{t('best_for_your_space')}</p>
        <h1 className="text-2xl sm:text-3xl md:text-[40px] font-semibold capitalize leading-tight mt-2">
         {title}
        </h1>
        <p className="text-gray-600 mt-4 text-sm md:text-base">
          {text}
        </p>

        <div className="mt-6 md:mt-8 space-y-3 md:space-y-4">
          <div 
            data-aos="fade-up"
            data-aos-duration="800"
            data-aos-delay="300"
            className="flex items-start bg-white p-3 md:p-4 rounded-2xl shadow gap-3 md:gap-4 w-full max-w-[392px]"
          >
            <div className="bg-black text-white p-2 rounded-xl flex-shrink-0">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="w-5 h-5 md:w-6 md:h-6"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth="1.5"
                stroke="currentColor"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M9 12h3.75M9 15h3.75M9 18h3.75m3 .75H18a2.25 2.25 0 0 0 2.25-2.25V6.108c0-1.135-.845-2.098-1.976-2.192a48.424 48.424 0 0 0-1.123-.08m-5.801 0c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75 2.25 2.25 0 0 0-.1-.664m-5.8 0A2.251 2.251 0 0 1 13.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m0 0H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V9.375c0-.621-.504-1.125-1.125-1.125H8.25Z"
                />
              </svg>
            </div>
            <div>
              <h1 className="text-base md:text-lg font-semibold">{features[0]?.title}</h1>
              <p className="text-gray-600 text-xs md:text-sm">
                {features[0]?.subtitle}
              </p>
            </div>
          </div>

          <div 
            data-aos="fade-up"
            data-aos-duration="800"
            data-aos-delay="500"
            className="flex items-start bg-white p-3 md:p-4 rounded-2xl shadow gap-3 md:gap-4 w-full max-w-[392px]"
          >
            <div className="bg-black text-white p-2 rounded-xl flex-shrink-0">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="w-5 h-5 md:w-6 md:h-6"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth="1.5"
                stroke="currentColor"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M9.568 3H5.25A2.25 2.25 0 0 0 3 5.25v4.318c0 .597.237 1.17.659 1.591l9.581 9.581c.699.699 1.78.872 2.607.33a18.095 18.095 0 0 0 5.223-5.223c.542-.827.369-1.908-.33-2.607L11.16 3.66A2.25 2.25 0 0 0 9.568 3Z"
                />
                <path strokeLinecap="round" strokeLinejoin="round" d="M6 6h.008v.008H6V6Z" />
              </svg>
            </div>
            <div>
              <h1 className="text-base md:text-lg font-semibold">{features[1]?.title}</h1>
              <p className="text-gray-600 text-xs md:text-sm">
                {features[1]?.subtitle}
              </p>
            </div>
          </div>
        </div>
      </div>

      <div className="block md:hidden order-3 col-span-1">
        <div className="space-y-6 mt-8">
          <div 
            data-aos="fade-up"
            data-aos-duration="800"
            data-aos-delay="200"
            className="text-center"
          >
            <img
              src={feature1 || '/images/placeholder.jpg'}
              alt="Office"
              className="w-full h-[300px] object-cover rounded-lg shadow-lg"
              onError={(e) => { e.currentTarget.src = '/images/placeholder.jpg'; }}
            />
          </div>

          <div 
            data-aos="fade-up"
            data-aos-duration="800"
            data-aos-delay="400"
            className="text-center"
          >
            <img
              src={feature2 || '/images/placeholder.jpg'}
              alt="Reception"
              className="w-full h-[300px] object-cover rounded-lg shadow-lg"
              onError={(e) => { e.currentTarget.src = '/images/placeholder.jpg'; }}
            />
          </div>
        </div>
      </div>

      {/* Desktop Layout - First Image */}
      <div 
        data-aos="fade-up"
        data-aos-duration="800"
        data-aos-delay="200"
        className="hidden md:block order-1 md:order-2"
      >
        <img
          src={feature1 || '/images/placeholder.jpg'}
          alt="Office"
          className="w-full md:w-[362.12px] h-[300px] md:h-[543.12px] md:ml-[2.75rem] mb-6 md:mb-[14rem] mt-4 md:mt-[138px] object-cover rounded-lg md:rounded-none"
          onError={(e) => { e.currentTarget.src = '/images/placeholder.jpg'; }}
        />
      </div>

      {/* Desktop Layout - Second Image */}
      <div 
        data-aos="fade-up"
        data-aos-duration="800"
        data-aos-delay="400"
        className="hidden md:block order-3"
      >
        <img
          src={feature2 || '/images/placeholder.jpg'}
          alt="Reception"
          className="w-full md:w-[362.12px] h-[300px] md:h-[543.12px] mb-6 md:mb-[9rem] mt-4 md:mt-[230px] object-cover rounded-lg md:rounded-none"
          onError={(e) => { e.currentTarget.src = '/images/placeholder.jpg'; }}
        />
      </div>
    </div>
  )
}
