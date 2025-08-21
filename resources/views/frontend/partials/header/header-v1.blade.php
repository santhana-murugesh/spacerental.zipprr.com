<!-- Header-area start -->
<header class="header-area header_v1">
  <!-- Start mobile menu -->
  <div class="mobile-menu">
    <div class="container">
      <div class="mobile-menu-wrapper"></div>
    </div>
  </div>
  <!-- End mobile menu -->

  <div class="main-responsive-nav">
    <div class="container">
      <!-- Mobile Logo -->
      <div class="logo">
        @if (!empty($websiteInfo->logo))
          <a href="{{ route('index') }}">
            <img src="{{ asset('assets/img/' . $websiteInfo->logo) }}" alt="logo">
          </a>
        @endif
      </div>
      <!-- Menu toggle button -->
      <button class="menu-toggler" type="button">
        <span></span>
        <span></span>
        <span></span>
      </button>
    </div>
  </div>

  <div class="main-navbar">
    <!-- Top Header Bar -->
   
    
    <!-- Main Navigation -->
    <div class="header-bottom bg-black shadow-lg">
      <div class="container">
        <nav class="navbar navbar-expand-lg py-3">
          <!-- Logo -->
          <a class="navbar-brand" href="{{ route('index') }}">
            @if (!empty($websiteInfo->logo))
              <img src="{{ asset('assets/img/' . $websiteInfo->logo) }}" alt="logo" height="50">
            @else
              <h3 class="mb-0 text-primary">{{ $websiteInfo->website_title ?? 'Space Rental' }}</h3>
            @endif
          </a>
          
          <!-- Mobile Toggle Button -->
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          
          <!-- Navigation Menu -->
          <div class="navbar-nav ms-auto">
            <!-- Search Button -->
            <div class="nav-item me-3">
              <button class="btn btn-outline-primary" type="button" data-bs-toggle="modal" data-bs-target="#searchModal">
                <i class="fas fa-search me-1"></i>{{ __('Search') }}
              </button>
            </div>
            
            <!-- Book Now Button -->
            <div class="nav-item">
              <a href="{{ route('frontend.rooms') }}" class="btn btn-primary">
                <i class="fas fa-calendar-check me-1"></i>{{ __('Book Now') }}
              </a>
            </div>
          </div>
        </nav>
      </div>
    </div>
  </div>
</header>
<!-- Header-area end -->

<!-- Search Modal -->
<div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="searchModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="searchModalLabel">{{ __('Search Rooms') }}</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="{{ route('frontend.search_room') }}" method="GET">
          <div class="row g-3">
            <div class="col-md-6">
              <label for="searchLocation" class="form-label">{{ __('Location') }}</label>
              <input type="text" class="form-control" id="searchLocation" name="location" placeholder="{{ __('Enter location') }}">
            </div>
            <div class="col-md-6">
              <label for="searchGuests" class="form-label">{{ __('Guests') }}</label>
              <select class="form-select" id="searchGuests" name="guests">
                <option value="">{{ __('Select guests') }}</option>
                <option value="1">1 {{ __('Guest') }}</option>
                <option value="2">2 {{ __('Guests') }}</option>
                <option value="3">3 {{ __('Guests') }}</option>
                <option value="4">4+ {{ __('Guests') }}</option>
              </select>
            </div>
            <div class="col-md-6">
              <label for="searchCheckIn" class="form-label">{{ __('Check-in Date') }}</label>
              <input type="date" class="form-control" id="searchCheckIn" name="check_in">
            </div>
            <div class="col-md-6">
              <label for="searchCheckOut" class="form-label">{{ __('Check-out Date') }}</label>
              <input type="date" class="form-control" id="searchCheckOut" name="check_out">
            </div>
            <div class="col-12">
              <button type="submit" class="btn btn-primary w-100">
                <i class="fas fa-search me-2"></i>{{ __('Search Rooms') }}
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<style>
/* Header Styles */
.header-area {
  position: relative;
  z-index: 1000;
}

.navbar-brand {
  color: #ffffff !important;
}

.navbar-brand h3 {
  color: #ffffff !important;
}

.navbar-toggler {
  border-color: rgba(255, 255, 255, 0.5);
}

.navbar-toggler-icon {
  background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.75%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
}

.header-top {
  background: linear-gradient(135deg, #0d6efd 0%, #6f42c1 100%) !important;
}

.header-top .contact-list a {
  text-decoration: none;
  transition: all 0.3s ease;
}

.header-top .contact-list a:hover {
  opacity: 0.8;
}

.social-links a {
  display: inline-block;
  width: 32px;
  height: 32px;
  line-height: 32px;
  text-align: center;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  transition: all 0.3s ease;
}

.social-links a:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: translateY(-2px);
}

.language-selector .form-select {
  background-color: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: white;
  font-size: 0.875rem;
}

.language-selector .form-select option {
  background-color: #0d6efd;
  color: white;
}

.header-bottom {
  border-bottom: 1px solid #333;
  background: #000000 !important;
}

.navbar-nav .nav-link {
  color: #ffffff !important;
  font-weight: 500;
  padding: 0.5rem 1rem;
  transition: all 0.3s ease;
  position: relative;
}

.navbar-nav .nav-link:hover {
  color: #ffffff !important;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 4px;
}

.navbar-nav .nav-link::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  width: 0;
  height: 2px;
  background: #ffffff;
  transition: all 0.3s ease;
  transform: translateX(-50%);
}

.navbar-nav .nav-link:hover::after {
  width: 100%;
}

.dropdown-menu {
  border: none;
  box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.3);
  border-radius: 0.5rem;
  background: #000000;
}

.dropdown-item {
  padding: 0.75rem 1rem;
  transition: all 0.3s ease;
  color: #ffffff;
}

.dropdown-item:hover {
  background-color: rgba(255, 255, 255, 0.1);
  color: #ffffff;
}

/* Responsive Design */
@media (max-width: 991.98px) {
  .header-top .header-left,
  .header-top .header-right {
    text-align: center;
    margin-bottom: 0.5rem;
  }
  
  .social-links {
    justify-content: center;
  }
  
  .navbar-nav {
    text-align: center;
    margin-top: 1rem;
  }
  
  .navbar-nav .nav-link {
    padding: 0.75rem 0;
  }
}

@media (max-width: 767.98px) {
  .header-top {
    padding: 0.5rem 0;
  }
  
  .contact-list {
    flex-direction: column;
    align-items: center;
  }
  
  .contact-list li {
    margin-bottom: 0.25rem;
  }
}
</style>
