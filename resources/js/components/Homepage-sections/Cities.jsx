import React, { useState, useEffect } from 'react';
import { useLanguage } from '../../contexts/LanguageContext';

export const Cities = ({title,description}) => {
  const [cities, setCities] = useState(null);
  const [startIndex, setStartIndex] = useState(0); // Track which 4 are visible
  const { currentLanguage } = useLanguage();
   const API_BASE_URL =
        window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
            ? import.meta.env.VITE_API_BASE_URL_LOCAL
            : import.meta.env.VITE_API_BASE_URL;
  const itemsPerPage = 4;

  useEffect(() => {
    const fetchData = async () => {
      try {
        const routeResponse = await fetch(`${API_BASE_URL}/api/routes`);
        const routes = await routeResponse.json();

        const citiesResponse = await fetch(routes.cities);
        const citiesData = await citiesResponse.json();

        // Filter cities based on current language ID
        if (citiesData && currentLanguage) {
          // Use the language ID directly from currentLanguage
          let languageId = currentLanguage.id;

          if (languageId) {
            const filteredCities = Object.values(citiesData).filter(
              city => parseInt(city.language_id) === parseInt(languageId)
            );
            setCities(filteredCities);
          } else {
            setCities(citiesData);
          }
        } else {
          setCities(citiesData);
        }
      } catch (error) {
        console.error('Error fetching cities:', error);
      }
    };

    fetchData();
  }, [currentLanguage]);

  const handlePrev = () => {
    setStartIndex((prev) => Math.max(prev - itemsPerPage, 0));
  };

  const handleNext = () => {
    if (cities) {
      setStartIndex((prev) =>
        Math.min(prev + itemsPerPage, cities.length - itemsPerPage)
      );
    }
  };

  return (
    <>
      <div 
        data-aos="fade-up" 
        data-aos-duration="800"
        data-aos-delay="100"
        className="cities flex flex-col items-center justify-center text-center px-4 py-6 md:py-8"
      >
        <h1 className="mt-3 md:mt-5 text-2xl sm:text-3xl md:text-[40px] capitalize font-semibold max-w-[611px]">
         {title}
        </h1>
        <p className="text-xs md:text-[14px] mt-4 md:mt-8 lowercase max-w-[550px]">
          {description}
        </p>
      </div>

      {cities === null ? (
        <p 
          data-aos="fade-up"
          data-aos-duration="800"
          className="text-center"
        >
          Loading cities...
        </p>
      ) : Object.keys(cities).length > 0 ? (
        <>
          {/* Mobile Layout - Single Column */}
          <div className="block md:hidden px-4">
            <div className="space-y-4">
              {Object.values(cities)
                .slice(startIndex, startIndex + itemsPerPage)
                .map((city, index) => (
                  <div 
                    key={city.id} 
                    data-aos="fade-up"
                    data-aos-duration="800"
                    data-aos-delay={200 + (index * 150)}
                    className="relative"
                  >
                    <img
                      src={`${API_BASE_URL}/assets/img/location/city/${city.feature_image}`}
                      alt={city.name}
                      className="w-full h-[200px] object-cover rounded-lg"
                    />
                    <div className="absolute bottom-0 left-0 w-full h-[80px] md:h-[102px] bg-gradient-to-t from-black/90 to-transparent flex items-end justify-center rounded-b-lg">
                      <h1 className="text-white text-base md:text-lg font-semibold mb-3 md:mb-4">{city.name}</h1>
                    </div>
                  </div>
                ))}
            </div>
          </div>

          {/* Desktop Layout - Grid */}
          <div className="hidden md:flex justify-center mt-10">
            {Object.values(cities)
              .slice(startIndex, startIndex + itemsPerPage)
              .map((city, index) => (
                <div 
                  key={city.id} 
                  data-aos="fade-up"
                  data-aos-duration="800"
                  data-aos-delay={200 + (index * 150)}
                  className="relative mb-2"
                >
                  <img
                    src={`${API_BASE_URL}/assets/img/location/city/${city.feature_image}`}
                    alt={city.name}
                    className="w-[364.07px] h-[227.54px] object-cover"
                  />
                  <div className="absolute bottom-0 left-0 w-full h-[102px] bg-gradient-to-t from-black/90 to-transparent flex items-end justify-center ">
                    <h1 className="text-white text-lg font-semibold mb-4">{city.name}</h1>
                  </div>
                </div>
              ))}
          </div>
          
          <div 
            data-aos="fade-up"
            data-aos-duration="800"
            data-aos-delay="600"
            className="flex justify-center mt-4 md:mt-6 gap-3 md:gap-4 py-3 md:py-5 mb-4 md:mb-6"
          >
            <button
              onClick={handlePrev}
              disabled={startIndex === 0}
              className="px-3 md:px-4 py-2 rounded-full h-[40px] w-[40px] md:h-[48px] md:w-[48px] 
              flex items-center justify-center 
              border border-black 
              bg-black text-white
              disabled:bg-white disabled:text-black disabled:border-black
              text-sm md:text-base"
            >
              ←
            </button>
            <button
              onClick={handleNext}
              disabled={startIndex + itemsPerPage >= Object.values(cities).length}
              className="px-3 md:px-4 py-2 rounded-full h-[40px] w-[40px] md:h-[48px] md:w-[48px] 
              flex items-center justify-center 
              border border-black 
              bg-black text-white
              disabled:bg-white disabled:text-black disabled:border-black
              text-sm md:text-base"
            >
              →
            </button>
          </div>
        </>
      ) : (
        <p 
          data-aos="fade-up"
          data-aos-duration="800"
          className="text-center"
        >
          No cities found
        </p>
      )}
    </>
  );
};