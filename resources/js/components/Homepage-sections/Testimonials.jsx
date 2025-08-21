import React, { useEffect, useState } from "react";
import { useTranslation } from 'react-i18next';
import { useLanguage } from '../../contexts/LanguageContext';
export const Testimonials = ({ title, subtitle, description }) => {
    const [testimonials, setTestimonials] = useState(null);
    const [startIndex, setStartIndex] = useState(0);
    const API_BASE_URL =
        window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
            ? import.meta.env.VITE_API_BASE_URL_LOCAL
            : import.meta.env.VITE_API_BASE_URL;
    const itemsPerPage = 3;
    const { t } = useTranslation();
    const { currentLanguage, languages, changeLanguage, isRTL, direction } = useLanguage();
    useEffect(() => {
        const fetchData = async () => {
            try {
                const routeResponse = await fetch(`${API_BASE_URL}/api/routes`);
                const routes = await routeResponse.json();
                const testimonialsResponse = await fetch(routes.testimonials);
                const testimonialsData = await testimonialsResponse.json();
                if (testimonialsData && currentLanguage) {
                    let languageId = null;
                    if (currentLanguage.id) {
                        languageId = currentLanguage.id;
                    } else if (currentLanguage.language_id) {
                        languageId = currentLanguage.language_id;
                    }
                    if (!languageId) {
                        languageId = currentLanguage.id;
                    }
                    if (languageId) {
                        const filteredTestimonials = Object.values(testimonialsData).filter(
                            testimonial => {
                                return parseInt(testimonial.language_id) === parseInt(languageId);
                            }
                        );
                        setTestimonials(filteredTestimonials);
                    } else {
                        setTestimonials(Object.values(testimonialsData));
                    }
                } else {
                    setTestimonials(testimonialsData ? Object.values(testimonialsData) : []);
                }
            } catch (error) {
                console.error('Error fetching testimonials:', error);
            }
        };
        fetchData();
    }, [currentLanguage]);
    const handlePrev = () => {
        setStartIndex((prev) => Math.max(prev - itemsPerPage, 0));
    };
    const handleNext = () => {
        if (testimonials) {
            setStartIndex((prev) =>
                Math.min(prev + itemsPerPage, testimonials.length - itemsPerPage)
            );
        }
    };
    return (
        <div className="bg-[#F3F9FF] py-8 md:py-12 px-4 md:px-6 lg:px-16">
            <div className="grid grid-cols-1 lg:grid-cols-4 gap-6 md:gap-8 mt-[20px] md:mt-[29px]">
                <div
                    data-aos="fade-right"
                    data-aos-duration="800"
                    data-aos-delay="100"
                    className="col-span-1 text-center lg:text-left"
                >
                    <span className="uppercase text-xs md:text-sm tracking-wide">{t('member_testimonial')}</span>
                    <h1 className="text-2xl sm:text-3xl md:text-[40px] font-semibold capitalize mt-2 leading-tight">
                        {title}
                    </h1>
                    <p className="font-semibold mt-4 md:mt-6 text-sm md:text-base">
                        {subtitle}
                    </p>
                    <p className="mt-3 md:mt-4 text-gray-600 text-sm md:text-base">
                        {description}
                    </p>
                    <p className="mt-3 md:mt-4 text-pink-500 cursor-pointer text-sm md:text-base">• {t('all_testimonials')}</p>
                </div>
                <div className="col-span-1 lg:col-span-3 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-6 mt-4 md:mt-[8px]">
                    {testimonials == null ? (
                        <p
                            data-aos="fade-up"
                            data-aos-duration="800"
                        >
                            {t('loading_testimonials')}
                        </p>
                    ) : testimonials.length > 0 ? (
                        testimonials
                            .slice(startIndex, startIndex + itemsPerPage)
                            .map((testimonial, index) => (
                                <div
                                    key={index}
                                    data-aos="fade-up"
                                    data-aos-duration="800"
                                    data-aos-delay={200 + (index * 150)}
                                    className="bg-white shadow-sm overflow-hidden rounded-lg"
                                >
                                    <div className="relative">
                                        <img
                                            src={`${API_BASE_URL}/assets/img/clients/${testimonial.image}`}
                                            alt={testimonial.name}
                                            className="w-full h-[180px] md:h-[196px] object-cover"
                                        />
                                        <div className="absolute -bottom-5 left-3 md:left-5 bg-black text-white rounded-full p-2 md:p-3">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                                                viewBox="0 0 24 24" strokeWidth="1.5" stroke="currentColor"
                                                className="size-5 md:size-6">
                                                <path strokeLinecap="round" strokeLinejoin="round"
                                                    d="M6.633 10.25c.806 0 1.533-.446 2.031-1.08a9.041 9.041 0 0 1 2.861-2.4c.723-.384 1.35-.956 1.653-1.715a4.498 4.498 0 0 0 .322-1.672V2.75a.75.75 0 0 1 .75-.75 2.25 2.25 0 0 1 2.25 2.25c0 1.152-.26 2.243-.723 3.218-.266.558.107 1.282.725 1.282m0 0h3.126c1.026 0 1.945.694 2.054 1.715.045.422.068.85.068 1.285a11.95 11.95 0 0 1-2.649 7.521c-.388.482-.987.729-1.605.729H13.48c-.483 0-.964-.078-1.423-.23l-3.114-1.04a4.501 4.501 0 0 0-1.423-.23H5.904m10.598-9.75H14.25M5.904 18.5c.083.205.173.405.27.602.197.4-.078.898-.523.898h-.908c-.889 0-1.713-.518-1.972-1.368a12 12 0 0 1-.521-3.507c0-1.553.295-3.036.831-4.398C3.387 9.953 4.167 9.5 5 9.5h1.053c.472 0 .745.556.5.96a8.958 8.958 0 0 0-1.302 4.665c0 1.194.232 2.333.654 3.375Z" />
                                            </svg>
                                        </div>
                                    </div>
                                    <div className="p-4 md:p-6 pt-8 md:pt-10">
                                        <p className="text-gray-600 mb-3 md:mb-4 text-sm md:text-base">
                                            {testimonial.comment}
                                        </p>
                                        <p className="font-bold text-sm md:text-base">{testimonial.name}</p>
                                        <p className="text-gray-500 text-xs md:text-sm">{testimonial.occupation}</p>
                                    </div>
                                </div>
                            ))
                    ) : (
                        <p
                            data-aos="fade-up"
                            data-aos-duration="800"
                        >
                            {t('no_testimonials_available')}
                        </p>
                    )}
                </div>
            </div>
            <div
                data-aos="fade-up"
                data-aos-duration="800"
                data-aos-delay="600"
                className="flex justify-center space-x-3 mt-6 md:mt-8 ml-0 md:ml-[25%] lg:ml-[35%]"
            >
                <button
                    onClick={handlePrev}
                    disabled={startIndex === 0}
                    className="px-3 md:px-4 py-2 rounded h-[40px] w-[40px] md:h-[48px] md:w-[48px] 
                    flex items-center justify-center 
                    border border-black 
                    bg-black text-white
                    disabled:bg-white disabled:text-black disabled:border-black"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5 md:size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
                    </svg>
                </button>
                <button
                    onClick={handleNext}
                    disabled={
                        !testimonials ||
                        startIndex + itemsPerPage >= testimonials.length
                    }
                    className="px-3 md:px-4 py-2 rounded h-[40px] w-[40px] md:h-[48px] md:w-[48px] 
                    flex items-center justify-center 
                    border border-black 
                    bg-black text-white
                    disabled:bg-white disabled:text-black disabled:border-black"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5 md:size-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                    </svg>
                </button>
            </div>
        </div>
    );
};
