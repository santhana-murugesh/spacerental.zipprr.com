import React, { useEffect, useState } from 'react'
import { Header } from './Homepage-sections/Header'

export const AboutUs = () => {
  const [aboutData, setAboutData] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  const API_BASE_URL = 
    window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1"
      ? import.meta.env.VITE_API_BASE_URL_LOCAL
      : import.meta.env.VITE_API_BASE_URL

  useEffect(() => {
    fetch(`${API_BASE_URL}/api/about-us`)
      .then(res => res.json())
      .then(data => {
        setAboutData(data)
        setLoading(false)
      })
      .catch(err => {
        console.error('Error fetching about-us data:', err)
        setError(err.message)
        setLoading(false)
      })
  }, [API_BASE_URL])

  if (loading) return <div className="text-center py-8">Loading...</div>
  if (error) return <div className="text-center py-8 text-red-600">Error: {error}</div>
  if (!aboutData) return <div className="text-center py-8">No data found</div>

  const { about, images, features, testimonials, counters, after_about } = aboutData

  return (
    <>
    <Header bgColor="bg-black" />
      <div className="min-h-screen bg-gray-50 pt-20">
     
     <div className="bg-gradient-to-r from-blue-600 to-purple-600 text-white py-16">
       <div className="container mx-auto px-4 text-center">
         <h1 className="text-4xl md:text-6xl font-bold mb-4">
           {about?.title || 'About Us'}
         </h1>
         <p className="text-xl md:text-2xl opacity-90">
           {about?.subtitle || 'Discover our story and mission'}
         </p>
       </div>
     </div>

     {/* Main Content */}
     <div className="container mx-auto px-4 py-16">
       <div className="grid md:grid-cols-2 gap-12 items-center">
         {/* Image */}
         <div className="order-2 md:order-1">
           {images?.about_section_image && (
             <img 
               src={`${API_BASE_URL}/assets/img/homepage/${images.about_section_image}`}
               alt="About Us"
               className="w-full h-96 object-cover rounded-lg shadow-lg"
             />
           )}
         </div>

         {/* Text Content */}
         <div className="order-1 md:order-2">
           <h2 className="text-3xl font-bold text-gray-800 mb-6">
             {about?.title || 'Our Story'}
           </h2>
           <div 
             className="text-gray-600 text-lg leading-relaxed mb-6"
             dangerouslySetInnerHTML={{ __html: about?.text || 'Content coming soon...' }}
           />
           {about?.button_text && about?.button_url && (
             <a 
               href={about.button_url}
               className="inline-block bg-blue-600 text-white px-8 py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors"
             >
               {about.button_text}
             </a>
           )}
         </div>
       </div>
     </div>

     {/* Features Section */}
     {features && features.length > 0 && (
       <div className="bg-white py-16">
         <div className="container mx-auto px-4">
           <h2 className="text-3xl font-bold text-center text-gray-800 mb-12">Our Features</h2>
           <div className="grid md:grid-cols-3 gap-8">
             {features.map((feature, index) => (
               <div key={index} className="text-center p-6">
                 <div className="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
                   <i className="fas fa-star text-blue-600 text-xl"></i>
                 </div>
                 <h3 className="text-xl font-semibold text-gray-800 mb-3">
                   {feature.title}
                 </h3>
                 <p className="text-gray-600">
                   {feature.text}
                 </p>
               </div>
             ))}
           </div>
         </div>
       </div>
     )}

     {/* Counters Section */}
     {counters && counters.length > 0 && (
       <div className="bg-gray-800 text-white py-16">
         <div className="container mx-auto px-4">
           <div className="grid md:grid-cols-4 gap-8 text-center">
             {counters.map((counter, index) => (
               <div key={index}>
                 <div className="text-4xl font-bold text-blue-400 mb-2">
                   {counter.number}
                 </div>
                 <div className="text-gray-300">
                   {counter.title}
                 </div>
               </div>
             ))}
           </div>
         </div>
       </div>
     )}

     {testimonials && testimonials.length > 0 && (
       <div className="bg-white py-16">
         <div className="container mx-auto px-4">
           <h2 className="text-3xl font-bold text-center text-gray-800 mb-12">What Our Clients Say</h2>
           <div className="grid md:grid-cols-3 gap-8">
             {testimonials.map((testimonial, index) => (
               <div key={index} className="bg-gray-50 p-6 rounded-lg">
                 <div className="flex items-center mb-4">
                   {testimonial.image && (
                     <img 
                     src={`${API_BASE_URL}/assets/img/clients/${testimonial.image}`}
                       alt={testimonial.name}
                       className="w-12 h-12 rounded-full mr-4"
                     />
                   )}
                   <div>
                     <h4 className="font-semibold text-gray-800">{testimonial.name}</h4>
                     <p className="text-gray-600 text-sm">{testimonial.occupation}</p>
                   </div>
                 </div>
                 <p className="text-gray-600 italic">"{testimonial.comment}"</p>
               </div>
             ))}
           </div>
         </div>
       </div>
     )}

     {/* Custom Sections */}
     {after_about && after_about.length > 0 && (
       <div className="bg-gray-50 py-16">
         <div className="container mx-auto px-4">
           {after_about.map((section, index) => (
             <div key={index} className="mb-12">
               <h2 className="text-3xl font-bold text-center text-gray-800 mb-8">
                 {section.section_name}
               </h2>
               <div 
                 className="text-gray-600 text-lg leading-relaxed max-w-4xl mx-auto text-center"
                 dangerouslySetInnerHTML={{ __html: section.content }}
               />
             </div>
           ))}
         </div>
       </div>
     )}
   </div>
    </>
  
  )
}
