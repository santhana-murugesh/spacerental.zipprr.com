import React, { useState, useEffect } from 'react';
import vectorimg from '../../assets/Vector.png';
import vectorimg1 from '../../assets/Vector1.png';
import vectorimg2 from '../../assets/Vector2.png';
import vectorimg3 from '../../assets/Vector3.png';
import vectorimg4 from '../../assets/Vector4.png';
import { useTranslation } from 'react-i18next';
import { useLanguage } from '../../contexts/LanguageContext';
export const Partners = () => {
  const [counter, setcountersection] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const { t } = useTranslation();
  const { currentLanguage, languages, changeLanguage, isRTL, direction } = useLanguage();
  const API_BASE_URL =
    window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
      ? import.meta.env.VITE_API_BASE_URL_LOCAL
      : import.meta.env.VITE_API_BASE_URL;
  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        setError(null);
        const currentLangCode = currentLanguage?.code || 'en';
        const apiUrl = `${API_BASE_URL}/api/countersection?lang=${currentLangCode}`;
        const countersection = await fetch(apiUrl);
        if (!countersection.ok) {
          throw new Error(`HTTP error! status: ${countersection.status}`);
        }
        const countersectiondata = await countersection.json();
        if (!Array.isArray(countersectiondata)) {
          console.error('API response is not an array:', typeof countersectiondata, countersectiondata);
          throw new Error('Countersection API did not return an array');
        }
        const transformedData = countersectiondata.map((item, index) => ({
          id: item.id || index + 1,
          stat: item.amount ? `${item.amount.toLocaleString()}` : '0',
          title: item.title || 'portfolio increase in 2 years',
          description: item.description || item.title || 'portfolio increase in 2 years', // Use description field if available, fallback to title
          buttonText: 'Learn More',
          buttonLink: item.button_link || null,
          buttonColor: ['bg-green-200', 'bg-pink-200', 'bg-green-200', 'bg-blue-200', 'bg-yellow-200'][index % 5],
          icon: ['▶️', '☰', '▶️', '▶️', '▶️'][index % 5],
          image: item.image || null
        }));
        setcountersection(transformedData);
      } catch (error) {
        console.error('Error fetching countersection:', error);
        setError(`Failed to load counter data: ${error.message}`);
        setcountersection(null);
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, [API_BASE_URL, currentLanguage]);
  return (
    <div className="bg-white py-8 md:py-16 px-4 md:px-8">
      <div className="max-w-7xl mx-auto">
        <div
          data-aos="fade-up"
          data-aos-duration="800"
          data-aos-delay="100"
          className="flex flex-col lg:flex-row justify-between items-start mb-8 md:mb-16 gap-6"
        >
          <div className="w-full lg:w-1/2">
            <p className="text-xs md:text-sm uppercase text-gray-500 mb-2">{t('real_voice_real_results')}</p>
            <h1 className="text-2xl md:text-3xl lg:text-4xl font-bold text-gray-800 leading-tight">
              {t('hear_from_property_professionals')}
            </h1>
          </div>
          <div className="w-full lg:w-1/3">
            <p className="text-sm text-gray-500 leading-relaxed">
              {t('fueled_by_exploration_and_innovation')}
            </p>
          </div>
        </div>
        <div className="relative">
          {!loading && !error && counter && (
            <>
              <div className="block lg:hidden">
                <div className="flex flex-col items-center space-y-6">
                  <div
                    data-aos="fade-up"
                    data-aos-duration="800"
                    data-aos-delay="200"
                    className="relative"
                  >
                    <img className='w-full max-w-[300px] h-auto' src={vectorimg} alt="" />
                    <div className="absolute inset-0 flex flex-col justify-center items-center p-4 text-center">
                      <div className="text-3xl font-bold text-gray-800 mb-2">{counter[0]?.stat || '0'}</div>
                      <div className="text-xs text-gray-600 mb-2">{counter[0]?.title || 'portfolio increase in 2 years'}</div>
                      {counter[0]?.buttonLink ? (
                        <a
                          href={counter[0].buttonLink}
                          target="_blank"
                          rel="noopener noreferrer"
                          className={`${counter[0]?.buttonColor || 'bg-green-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white inline-block`}
                        >
                          <span className="text-white">{counter[0]?.icon || '▶️'}</span>
                          {counter[0]?.buttonText || 'Learn More'}
                        </a>
                      ) : (
                        <button className={`${counter[0]?.buttonColor || 'bg-green-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white`}>
                          <span className="text-white">{counter[0]?.icon || '▶️'}</span>
                          {counter[0]?.buttonText || 'Learn More'}
                        </button>
                      )}
                      <div className="text-xs text-gray-600 mb-2">{counter[0]?.description || 'portfolio increase in 2 years'}</div>
                    </div>
                  </div>
                  <div
                    data-aos="fade-up"
                    data-aos-duration="800"
                    data-aos-delay="300"
                    className="relative"
                  >
                    <img className='w-full max-w-[250px] h-auto' src={vectorimg1} alt="" />
                    <div className="absolute inset-0 flex flex-col justify-center items-center p-3 text-center">
                      <div className="text-2xl font-bold text-gray-800 mb-1">{counter[1]?.stat || '0'}</div>
                      <div className="text-xs text-gray-600 mb-2">{counter[1]?.title || 'portfolio increase in 2 years'}</div>
                      {counter[1]?.buttonLink ? (
                        <a
                          href={counter[1].buttonLink}
                          target="_blank"
                          rel="noopener noreferrer"
                          className={`${counter[1]?.buttonColor || 'bg-pink-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white inline-block`}
                        >
                          <span className="text-white">{counter[1]?.icon || '☰'}</span>
                          {counter[1]?.buttonText || 'Learn More'}
                        </a>
                      ) : (
                        <button className={`${counter[1]?.buttonColor || 'bg-pink-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white`}>
                          <span className="text-white">{counter[1]?.icon || '☰'}</span>
                          {counter[1]?.buttonText || 'Learn More'}
                        </button>
                      )}
                    </div>
                  </div>
                  <div
                    data-aos="fade-up"
                    data-aos-duration="800"
                    data-aos-delay="400"
                    className="relative"
                  >
                    <img className='w-full max-w-[250px] h-auto' src={vectorimg2} alt="" />
                    <div className="absolute inset-0 flex flex-col justify-center items-center p-3 text-center">
                      <div className="text-2xl font-bold text-gray-800 mb-1">{counter[2]?.stat || '0'}</div>
                      <div className="text-xs text-gray-600 mb-2">{counter[2]?.title || 'portfolio increase in 2 years'}</div>
                      {counter[2]?.buttonLink ? (
                        <a
                          href={counter[2].buttonLink}
                          target="_blank"
                          rel="noopener noreferrer"
                          className={`${counter[2]?.buttonColor || 'bg-green-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white inline-block`}
                        >
                          <span className="text-white">{counter[2]?.icon || '▶️'}</span>
                          {counter[2]?.buttonText || 'Learn More'}
                        </a>
                      ) : (
                        <button className={`${counter[2]?.buttonColor || 'bg-green-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white`}>
                          <span className="text-white">{counter[2]?.icon || '▶️'}</span>
                          {counter[2]?.buttonText || 'Learn More'}
                        </button>
                      )}
                    </div>
                  </div>
                  <div
                    data-aos="fade-up"
                    data-aos-duration="800"
                    data-aos-delay="500"
                    className="relative"
                  >
                    <img className='w-full max-w-[250px] h-auto' src={vectorimg3} alt="" />
                    <div className="absolute inset-0 flex flex-col justify-center items-center p-3 text-center">
                      <div className="text-2xl font-bold text-gray-800 mb-1">{counter[3]?.stat || '0'}</div>
                      <div className="text-xs text-gray-600 mb-2">{counter[3]?.title || 'portfolio increase in 2 years'}</div>
                      {counter[3]?.buttonLink ? (
                        <a
                          href={counter[3].buttonLink}
                          target="_blank"
                          rel="noopener noreferrer"
                          className={`${counter[3]?.buttonColor || 'bg-green-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white inline-block`}
                        >
                          <span className="text-white">{counter[3]?.icon || '▶️'}</span>
                          {counter[3]?.buttonText || 'Learn More'}
                        </a>
                      ) : (
                        <button className={`${counter[3]?.buttonColor || 'bg-green-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white`}>
                          <span className="text-white">{counter[3]?.icon || '▶️'}</span>
                          {counter[3]?.buttonText || 'Learn More'}
                        </button>
                      )}
                    </div>
                  </div>
                  <div
                    data-aos="fade-up"
                    data-aos-duration="800"
                    data-aos-delay="600"
                    className="relative"
                  >
                    <img className='w-full max-w-[250px] h-auto' src={vectorimg4} alt="" />
                    <div className="absolute inset-0 flex flex-col justify-center items-center p-3 text-center">
                      <div className="text-2xl font-bold text-gray-800 mb-1">{counter[4]?.stat || '0'}</div>
                      <div className="text-xs text-gray-600 mb-2">{counter[4]?.title || 'portfolio increase in 2 years'}</div>
                      {counter[4]?.buttonLink ? (
                        <a
                          href={counter[4].buttonLink}
                          target="_blank"
                          rel="noopener noreferrer"
                          className={`${counter[4]?.buttonColor || 'bg-yellow-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white inline-block`}
                        >
                          <span className="text-white">{counter[4]?.buttonText || 'Learn More'}</span>
                        </a>
                      ) : (
                        <button className={`${counter[4]?.buttonColor || 'bg-yellow-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white`}>
                          <span className="text-white">{counter[4]?.buttonText || 'Learn More'}</span>
                        </button>
                      )}
                    </div>
                  </div>
                </div>
              </div>
              <div className='hidden lg:flex justify-center items-center gap-4'>
                <div
                  data-aos="fade-up"
                  data-aos-duration="800"
                  data-aos-delay="200"
                  className="relative"
                >
                  <img className='border-black w-[393.98577880859375px] h-[503.0354309082031px]' src={vectorimg} alt="" />
                  <div className="absolute inset-0 flex flex-col justify-center items-center p-4 text-center">
                    <div className="text-[64px] md:text-3xl font-bold text-gray-800 mb-2">{counter[0]?.stat || '0'}</div>
                    <div className="text-xs md:text-sm text-gray-600 mb-3">{counter[0]?.title || 'portfolio increase in 2 years'}</div>
                    {counter[0]?.buttonLink ? (
                      <a
                        href={counter[0].buttonLink}
                        target="_blank"
                        rel="noopener noreferrer"
                        className={`${counter[0]?.buttonColor || 'bg-green-200'} px-3 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white inline-block`}
                      >
                        <span className="text-white">{counter[0]?.icon || '▶️'}</span>
                        {counter[0]?.buttonText || 'Learn More'}
                      </a>
                    ) : (
                      <button className={`${counter[0]?.buttonColor || 'bg-green-200'} px-3 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white`}>
                        <span className="text-white">{counter[0]?.icon || '▶️'}</span>
                        {counter[0]?.buttonText || 'Learn More'}
                      </button>
                    )}
                    <div className="text-xs md:text-sm text-gray-600 mb-3">{counter[0]?.description || 'portfolio increase in 2 years'}</div>
                    {counter[0]?.quote && (
                      <p className="text-xs text-gray-700 leading-relaxed mt-2">{counter[0].quote}</p>
                    )}
                  </div>
                </div>
                <div
                  data-aos="fade-up"
                  data-aos-duration="800"
                  data-aos-delay="400"
                  className='flex flex-col justify-center items-center'
                >
                  <div className="relative">
                    <img className='border-black' src={vectorimg1} alt="" />
                    <div className="absolute inset-0 flex flex-col justify-center items-center p-2 text-center">
                      <div className="text-[64px] font-bold text-gray-800 mb-1">{counter[1]?.stat || '0'}</div>
                      <div className="text-xs text-gray-600 mb-2">{counter[1]?.title || 'portfolio increase in 2 years'}</div>
                      {counter[1]?.buttonLink ? (
                        <a
                          href={counter[1].buttonLink}
                          target="_blank"
                          rel="noopener noreferrer"
                          className={`${counter[1]?.buttonColor || 'bg-pink-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white inline-block`}
                        >
                          <span className="text-white">{counter[1]?.icon || '☰'}</span>
                          {counter[1]?.buttonText || 'Learn More'}
                        </a>
                      ) : (
                        <button className={`${counter[1]?.buttonColor || 'bg-pink-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white`}>
                          <span className="text-white">{counter[1]?.icon || '☰'}</span>
                          {counter[1]?.buttonText || 'Learn More'}
                        </button>
                      )}
                    </div>
                  </div>
                  <div className="relative mt-4">
                    <img className='border-black' src={vectorimg2} alt="" />
                    <div className="absolute inset-0 flex flex-col justify-center items-center p-2 text-center">
                      <div className="text-[64px] font-bold text-gray-800 mb-1">{counter[2]?.stat || '0'}</div>
                      <div className="text-xs text-gray-600 mb-2">{counter[2]?.title || 'portfolio increase in 2 years'}</div>
                      {counter[2]?.buttonLink ? (
                        <a
                          href={counter[2].buttonLink}
                          target="_blank"
                          rel="noopener noreferrer"
                          className={`${counter[2]?.buttonColor || 'bg-green-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white inline-block`}
                        >
                          <span className="text-white">{counter[2]?.icon || '▶️'}</span>
                          {counter[2]?.buttonText || 'Learn More'}
                        </a>
                      ) : (
                        <button className={`${counter[2]?.buttonColor || 'bg-green-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white`}>
                          <span className="text-white">{counter[2]?.icon || '▶️'}</span>
                          {counter[2]?.buttonText || 'Learn More'}
                        </button>
                      )}
                    </div>
                  </div>
                </div>
                <div
                  data-aos="fade-up"
                  data-aos-duration="800"
                  data-aos-delay="600"
                  className='flex flex-col justify-center items-center'
                >
                  <div className="relative">
                    <img className='border-black' src={vectorimg3} alt="" />
                    <div className="absolute inset-0 flex flex-col justify-center items-center p-2 text-center">
                      <div className="text-[64px] font-bold text-gray-800 mb-1">{counter[3]?.stat || '0'}</div>
                      <div className="text-xs text-gray-600 mb-2">{counter[3]?.title || 'portfolio increase in 2 years'}</div>
                      {counter[3]?.buttonLink ? (
                        <a
                          href={counter[3].buttonLink}
                          target="_blank"
                          rel="noopener noreferrer"
                          className={`${counter[3]?.buttonColor || 'bg-green-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white inline-block`}
                        >
                          <span className="text-white">{counter[3]?.icon || '▶️'}</span>
                          {counter[3]?.buttonText || 'Learn More'}
                        </a>
                      ) : (
                        <button className={`${counter[3]?.buttonColor || 'bg-green-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white`}>
                          <span className="text-white">{counter[3]?.icon || '▶️'}</span>
                          {counter[3]?.buttonText || 'Learn More'}
                        </button>
                      )}
                    </div>
                  </div>
                  <div className="relative mt-4">
                    <img className='border-black' src={vectorimg4} alt="" />
                    <div className="absolute inset-0 flex flex-col justify-center items-center p-2 text-center">
                      <div className="text-[64px] font-bold text-gray-800 mb-1">{counter[4]?.stat || '0'}</div>
                      <div className="text-xs text-gray-600 mb-2">{counter[4]?.title || 'portfolio increase in 2 years'}</div>
                      {counter[4]?.buttonLink ? (
                        <a
                          href={counter[4].buttonLink}
                          target="_blank"
                          rel="noopener noreferrer"
                          className={`${counter[4]?.buttonColor || 'bg-yellow-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white inline-block`}
                        >
                          <span className="text-white">{counter[4]?.buttonText || 'Learn More'}</span>
                        </a>
                      ) : (
                        <button className={`${counter[4]?.buttonColor || 'bg-yellow-200'} px-2 py-1 rounded-full text-xs font-medium flex items-center gap-1 text-white`}>
                          <span className="text-white">{counter[4]?.buttonText || 'Learn More'}</span>
                        </button>
                      )}
                    </div>
                  </div>
                </div>
              </div>
            </>
          )}
        </div>
      </div>
    </div>
  );
};
