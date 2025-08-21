import React, { useEffect, useState } from 'react'

export const CallToAction = ({ link, btn_name, title }) => {
  const [bgImage, setBgImage] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const API_BASE_URL =
    window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
      ? import.meta.env.VITE_API_BASE_URL_LOCAL
      : import.meta.env.VITE_API_BASE_URL;

  useEffect(() => {
    const fetchImages = async () => {
      try {
        setLoading(true);
        const routeResponse = await fetch(`${API_BASE_URL}/api/routes`);
        const routes = await routeResponse.json();
        const res = await fetch(routes.basicImages);
        const data = await res.json();
        if (data && data.call_to_action_section_image) {
          setBgImage(`${API_BASE_URL}/assets/img/homepage/${data.call_to_action_section_image}`);
        }
      } catch (e) {
        setError('Failed to load CTA image');
      } finally {
        setLoading(false);
      }
    };
    fetchImages();
  }, [API_BASE_URL]);
  
  return (
    <>
      <div className="mt-[10px] relative">
        <div 
          data-aos="fade-up"
          data-aos-duration="800"
          data-aos-delay="100"
          className="flex justify-center"
        >
          <div
            className="h-[300px] sm:h-[350px] md:h-[430px] w-full bg-gray-200 flex items-center justify-center"
            style={{
              backgroundImage: bgImage ? `url(${bgImage})` : 'none',
              backgroundSize: 'cover',
              backgroundPosition: 'center'
            }}
          >
            {!bgImage && (
              <div className="text-gray-500 text-center">
                <div className="text-4xl mb-2">🖼️</div>
                <p className="text-sm">Image not available</p>
              </div>
            )}
          </div>
        </div>

        <div className="absolute inset-0 bg-black bg-opacity-50"></div>

        <div 
          data-aos="fade-up"
          data-aos-duration="800"
          data-aos-delay="300"
          className="absolute inset-0 flex flex-col items-center justify-center text-white text-center px-4 z-10"
        >
          <span className="uppercase tracking-widest text-xs md:text-sm mb-2">
            Schedule a tour
          </span>
          <h1 className="capitalize text-xl sm:text-2xl md:text-3xl font-semibold w-full md:w-[397px] px-4 md:px-0">
            {title}
          </h1>
          <button className="bg-white mt-3 text-black font-bold py-2 px-4 md:px-6 rounded text-sm md:text-base hover:bg-gray-100 transition-colors">
            <a href={link}>{btn_name}</a>
          </button>
        </div>
      </div>
    </>
  );
};
