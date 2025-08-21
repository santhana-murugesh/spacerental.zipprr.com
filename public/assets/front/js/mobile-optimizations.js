// Mobile Optimizations and Interactions
document.addEventListener('DOMContentLoaded', function() {
    
    // Prevent zoom on input focus for iOS
    const inputs = document.querySelectorAll('input, select, textarea');
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            if (window.innerWidth <= 768) {
                this.style.fontSize = '16px';
            }
        });
        
        input.addEventListener('blur', function() {
            if (window.innerWidth <= 768) {
                this.style.fontSize = '';
            }
        });
    });

    // Smooth scrolling for mobile
    const smoothScrollLinks = document.querySelectorAll('a[href^="#"]');
    smoothScrollLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);
            
            if (targetElement) {
                targetElement.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Touch-friendly navigation
    let touchStartX = 0;
    let touchEndX = 0;
    
    document.addEventListener('touchstart', function(e) {
        touchStartX = e.changedTouches[0].screenX;
    });
    
    document.addEventListener('touchend', function(e) {
        touchEndX = e.changedTouches[0].screenX;
        handleSwipe();
    });
    
    function handleSwipe() {
        const swipeThreshold = 50;
        const diff = touchStartX - touchEndX;
        
        if (Math.abs(diff) > swipeThreshold) {
            if (diff > 0) {
                // Swipe left - could be used for next/forward
                console.log('Swiped left');
            } else {
                // Swipe right - could be used for previous/back
                console.log('Swiped right');
            }
        }
    }

    // Mobile menu toggle with animation
    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
    const mobileMenu = document.querySelector('.mobile-menu');
    
    if (mobileMenuToggle && mobileMenu) {
        mobileMenuToggle.addEventListener('click', function() {
            const isOpen = mobileMenu.classList.contains('open');
            
            if (isOpen) {
                mobileMenu.classList.remove('open');
                mobileMenuToggle.setAttribute('aria-expanded', 'false');
            } else {
                mobileMenu.classList.add('open');
                mobileMenuToggle.setAttribute('aria-expanded', 'true');
            }
        });
    }

    // Close mobile menu when clicking outside
    document.addEventListener('click', function(e) {
        if (mobileMenu && !mobileMenu.contains(e.target) && !mobileMenuToggle.contains(e.target)) {
            mobileMenu.classList.remove('open');
            mobileMenuToggle.setAttribute('aria-expanded', 'false');
        }
    });

    // Handle orientation change
    window.addEventListener('orientationchange', function() {
        setTimeout(function() {
            // Recalculate heights and positions after orientation change
            const vh = window.innerHeight * 0.01;
            document.documentElement.style.setProperty('--vh', `${vh}px`);
        }, 100);
    });

    // Set initial viewport height
    function setVH() {
        const vh = window.innerHeight * 0.01;
        document.documentElement.style.setProperty('--vh', `${vh}px`);
    }
    
    setVH();
    window.addEventListener('resize', setVH);

    // Mobile-friendly form validation
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            const requiredFields = form.querySelectorAll('[required]');
            let isValid = true;
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    field.classList.add('error');
                    
                    // Show mobile-friendly error message
                    showMobileError(field, 'This field is required');
                } else {
                    field.classList.remove('error');
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                // Scroll to first error
                const firstError = form.querySelector('.error');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        });
    });

    function showMobileError(field, message) {
        // Remove existing error message
        const existingError = field.parentNode.querySelector('.mobile-error');
        if (existingError) {
            existingError.remove();
        }
        
        // Create new error message
        const errorDiv = document.createElement('div');
        errorDiv.className = 'mobile-error';
        errorDiv.textContent = message;
        errorDiv.style.cssText = 'color: #dc3545; font-size: 12px; margin-top: 4px;';
        
        field.parentNode.appendChild(errorDiv);
        
        // Auto-remove error after 3 seconds
        setTimeout(() => {
            if (errorDiv.parentNode) {
                errorDiv.remove();
            }
        }, 3000);
    }

    // Mobile-friendly image lazy loading
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.classList.remove('lazy');
                    imageObserver.unobserve(img);
                }
            });
        });

        const lazyImages = document.querySelectorAll('img[data-src]');
        lazyImages.forEach(img => imageObserver.observe(img));
    }

    // Mobile-friendly tooltips
    const tooltipElements = document.querySelectorAll('[data-tooltip]');
    tooltipElements.forEach(element => {
        element.addEventListener('touchstart', function(e) {
            e.preventDefault();
            showMobileTooltip(this, this.dataset.tooltip);
        });
    });

    function showMobileTooltip(element, text) {
        // Remove existing tooltip
        const existingTooltip = document.querySelector('.mobile-tooltip');
        if (existingTooltip) {
            existingTooltip.remove();
        }
        
        // Create tooltip
        const tooltip = document.createElement('div');
        tooltip.className = 'mobile-tooltip';
        tooltip.textContent = text;
        tooltip.style.cssText = `
            position: fixed;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 14px;
            z-index: 10000;
            max-width: 200px;
            text-align: center;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            pointer-events: none;
        `;
        
        document.body.appendChild(tooltip);
        
        // Auto-remove after 2 seconds
        setTimeout(() => {
            if (tooltip.parentNode) {
                tooltip.remove();
            }
        }, 2000);
    }

    // Mobile-friendly scroll indicators
    function addScrollIndicators() {
        const scrollableElements = document.querySelectorAll('.scroll-container, .overflow-auto, .overflow-scroll');
        
        scrollableElements.forEach(element => {
            if (element.scrollHeight > element.clientHeight) {
                // Add scroll indicator
                const indicator = document.createElement('div');
                indicator.className = 'scroll-indicator';
                indicator.innerHTML = '↓ Scroll for more';
                indicator.style.cssText = `
                    position: absolute;
                    bottom: 10px;
                    right: 10px;
                    background: rgba(0, 0, 0, 0.7);
                    color: white;
                    padding: 4px 8px;
                    border-radius: 12px;
                    font-size: 12px;
                    pointer-events: none;
                    opacity: 0.8;
                    z-index: 10;
                `;
                
                element.style.position = 'relative';
                element.appendChild(indicator);
                
                // Hide indicator when scrolled to bottom
                element.addEventListener('scroll', function() {
                    if (this.scrollTop + this.clientHeight >= this.scrollHeight - 10) {
                        indicator.style.opacity = '0';
                    } else {
                        indicator.style.opacity = '0.8';
                    }
                });
            }
        });
    }
    
    addScrollIndicators();

    // Mobile-friendly keyboard navigation
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            // Close mobile menu on escape
            if (mobileMenu && mobileMenu.classList.contains('open')) {
                mobileMenu.classList.remove('open');
                mobileMenuToggle.setAttribute('aria-expanded', 'false');
            }
        }
    });

    // Performance optimizations for mobile
    if (window.innerWidth <= 768) {
        // Reduce animations on mobile
        document.documentElement.style.setProperty('--transition-duration', '0.2s');
        
        // Optimize images for mobile
        const images = document.querySelectorAll('img');
        images.forEach(img => {
            if (img.dataset.mobileSrc) {
                img.src = img.dataset.mobileSrc;
            }
        });
    }

    // Mobile-friendly focus management
    const focusableElements = document.querySelectorAll('a, button, input, select, textarea, [tabindex]:not([tabindex="-1"])');
    
    focusableElements.forEach(element => {
        element.addEventListener('focus', function() {
            this.classList.add('mobile-focus');
        });
        
        element.addEventListener('blur', function() {
            this.classList.remove('mobile-focus');
        });
    });

    // Add mobile-specific CSS classes
    function addMobileClasses() {
        if (window.innerWidth <= 768) {
            document.body.classList.add('mobile-device');
        } else {
            document.body.classList.remove('mobile-device');
        }
    }
    
    addMobileClasses();
    window.addEventListener('resize', addMobileClasses);
});

// Mobile-specific utility functions
window.mobileUtils = {
    // Check if device is mobile
    isMobile: function() {
        return window.innerWidth <= 768;
    },
    
    // Check if device supports touch
    isTouchDevice: function() {
        return 'ontouchstart' in window || navigator.maxTouchPoints > 0;
    },
    
    // Get device pixel ratio
    getPixelRatio: function() {
        return window.devicePixelRatio || 1;
    },
    
    // Check if device is iOS
    isIOS: function() {
        return /iPad|iPhone|iPod/.test(navigator.userAgent);
    },
    
    // Check if device is Android
    isAndroid: function() {
        return /Android/.test(navigator.userAgent);
    },
    
    // Vibrate device (if supported)
    vibrate: function(pattern) {
        if ('vibrate' in navigator) {
            navigator.vibrate(pattern);
        }
    },
    
    // Show mobile-friendly notification
    showNotification: function(message, duration = 3000) {
        const notification = document.createElement('div');
        notification.className = 'mobile-notification';
        notification.textContent = message;
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            font-size: 14px;
            z-index: 10000;
            max-width: 90%;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        `;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            if (notification.parentNode) {
                notification.remove();
            }
        }, duration);
    }
};
