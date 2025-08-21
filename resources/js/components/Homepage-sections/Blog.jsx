import React, { useEffect, useState } from 'react'
import { useTranslation } from 'react-i18next';
import { useLanguage } from '../../contexts/LanguageContext';
export const Blog = ({blog_title,buttonText}) => {
    const [blogs, setBlogs] = useState([]);
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
                const routeResponse = await fetch(`${API_BASE_URL}/api/routes`);
                const routes = await routeResponse.json();

                const blogsResponse = await fetch(routes.blogs);
                const blogsData = await blogsResponse.json();
                
                if (blogsData && currentLanguage) {
                    let languageId = currentLanguage.id;

                    if (languageId) {
                        const filteredBlogs = blogsData.filter(
                            blog => parseInt(blog.language_id) === parseInt(languageId)
                        );
                        setBlogs(filteredBlogs.slice(0, 6));
                    } else {
                        setBlogs(blogsData.slice(0, 6));
                    }
                } else {
                    setBlogs(blogsData.slice(0, 6));
                }
            } catch (error) {
                setError('Failed to load blogs');
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, [currentLanguage]);

    if (loading) {
        return (
            <div className='mt-[60px] md:mt-[90px] text-center px-4'>
                <div className='uppercase flex flex-col justify-center items-center'>
                    <span className="text-xs md:text-sm">{t('from_our_blog')}</span>
                    <h1 className='text-2xl sm:text-3xl md:text-[40px] mt-3 md:mt-5 capitalize font-semibold w-full md:w-[315px] h-auto md:h-[101.64px]'>{blog_title}</h1>
                </div>
                <div className="flex justify-center items-center h-32">
                    <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
                </div>
            </div>
        );
    }

    if (error) {
        return (
            <div className='mt-[60px] md:mt-[90px] text-center px-4'>
                <div className='uppercase flex flex-col justify-center items-center'>
                    <span className="text-xs md:text-sm">{t('from_our_blog')}</span>
                    <h1 className='text-2xl sm:text-3xl md:text-[40px] mt-3 md:mt-5 capitalize font-semibold w-full md:w-[315px] h-auto md:h-[101.64px]'>{blog_title}</h1>
                </div>
                <div className="text-red-600 text-center mt-8">
                    <p className="text-lg font-semibold">{error}</p>
                    <p className="text-sm">{t('please_try_again_later')}</p>
                </div>
            </div>
        );
    }

    return (
        <>
            <div 
                data-aos="fade-up" 
                data-aos-duration="800"
                data-aos-delay="100"
                className='mt-[60px] md:mt-[90px] text-center px-4'
            >
                <div className='uppercase flex flex-col justify-center items-center'>
                    <span className="text-xs md:text-sm">{t('from_our_blog')}</span>
                    <h1 className='text-2xl sm:text-3xl md:text-[40px] mt-3 md:mt-5 capitalize font-semibold w-full md:w-[315px] h-auto md:h-[101.64px]'>{blog_title}</h1>
                </div>
            </div>
            
            {/* Mobile Layout - Single Column */}
            <div className="block md:hidden px-4 mt-6 md:mt-10 mb-8 md:mb-[10rem]">
                <div className="space-y-6">
                    {blogs && blogs.length > 0 ? (
                        blogs.slice(0, 3).map((post, index) => (
                            <div
                                key={post.id || index}
                                data-aos="fade-up"
                                data-aos-duration="800"
                                data-aos-delay={200 + (index * 150)}
                                className="relative w-full h-[350px] md:h-[450px] overflow-hidden group rounded-lg"
                            >
                                <img
                                    src={`${API_BASE_URL}/assets/img/blogs/${post.image}`}
                                    alt={post.title}
                                    className="w-full h-full object-cover"
                                    onError={(e) => {
                                        e.target.src = '/images/placeholder.jpg';
                                    }}
                                />
                                <div className="absolute top-2 left-3 md:left-5 bg-white text-black px-2 md:px-3 py-1 md:py-2 z-30 text-center rounded">
                                    <p className="text-base md:text-lg font-bold leading-none">
                                        {new Date(post.created_at).getDate()}
                                    </p>
                                    <p className="text-xs uppercase">
                                        {new Date(post.created_at).toLocaleDateString('en-US', { month: 'short' })}
                                    </p>
                                </div>
                                <div className="absolute bottom-0 left-0 w-full">
                                    <div className="absolute bottom-0 left-0 w-full h-[12rem] md:h-[14rem] bg-gradient-to-t from-black/100 to-transparent"></div>

                                    <div className="relative p-4 md:p-5 text-white">
                                        <span className="border border-red-500 text-red-500 px-2 md:px-3 py-1 text-xs inline-block mb-2">
                                            {post.categoryName || 'Blog'}
                                        </span>
                                        <h2 className="text-base md:text-lg font-semibold">{post.title}</h2>
                                        <p className="mt-2 text-red-500 text-xs md:text-sm cursor-pointer">
                                           {buttonText}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        ))
                    ) : (
                        <div 
                            data-aos="fade-up"
                            data-aos-duration="800"
                            className="text-center py-8"
                        >
                            <p className="text-gray-500">{t('no_blog_posts_found')}</p>
                        </div>
                    )}
                </div>
            </div>

            {/* Desktop Layout - Grid */}
            <div className="hidden md:flex flex-wrap justify-center gap-6 mt-10 mb-[10rem]">
                {blogs && blogs.length > 0 ? (
                    blogs.slice(0, 3).map((post, index) => (
                        <div
                            key={post.id || index}
                            data-aos="fade-up"
                            data-aos-duration="800"
                            data-aos-delay={200 + (index * 150)}
                            className="relative w-[350px] h-[450px] overflow-hidden group"
                        >
                            <img
                                src={`${API_BASE_URL}/assets/img/blogs/${post.image}`}
                                alt={post.title}
                                className="w-full h-full object-cover"
                                onError={(e) => {
                                    e.target.src = '/images/placeholder.jpg';
                                }}
                            />
                            <div className="absolute top-[-6px] left-5 bg-white text-black px-3 py-2 z-30 text-center">
                                <p className="text-lg font-bold leading-none">
                                    {new Date(post.created_at).getDate()}
                                </p>
                                <p className="text-xs uppercase">
                                    {new Date(post.created_at).toLocaleDateString('en-US', { month: 'short' })}
                                </p>
                            </div>
                            <div className="absolute bottom-0 left-0 w-full">
                                <div className="absolute bottom-0 left-0 w-full h-[14rem] bg-gradient-to-t from-black/100 to-transparent"></div>

                                <div className="relative p-5 text-white">
                                    <span className="border border-red-500 text-red-500 px-3 py-1 text-xs inline-block mb-2">
                                        {post.categoryName || 'Blog'}
                                    </span>
                                    <h2 className="text-lg font-semibold">{post.title}</h2>
                                    <p className="mt-2 text-red-500 text-sm cursor-pointer">
                                       {buttonText}
                                    </p>
                                </div>
                            </div>
                        </div>
                    ))
                ) : (
                    <div 
                        data-aos="fade-up"
                        data-aos-duration="800"
                        className="text-center py-8"
                    >
                        <p className="text-gray-500">{t('no_blog_posts_found')}</p>
                    </div>
                )}
            </div>
        </>
    )
}
