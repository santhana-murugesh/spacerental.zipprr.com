"use strict";
var markers = [],
  map, marker_clusterer;

$(document).ready(function () {
  const featured_content = featured_contents;
  const hotel_content = hotel_contentss;
  mapInitialize(featured_content, hotel_content);
});
var timerMap, ad_galleries, firstSet = !1,
  mapRefresh = !0,
  loadOnTab = !0,
  zoomOnMapSearch = 22,
  clusterConfig = null,
  markerOptions = null,
  mapDisableAutoPan = !1,
  rent_inc_id = '55',
  scrollWheelEnabled = !1,
  myLocationEnabled = !0,
  rectangleSearchEnabled = !0,
  mapSearchbox = !0,
  mapRefresh = !0,
  map_main, styles, mapStyle = [{
    'featureType': 'landscape',
    'elementType': 'geometry.fill',
    'stylers': [{
      'color': '#fcf4dc'
    }]
  }, {
    'featureType': 'landscape',
    'elementType': 'geometry.stroke',
    'stylers': [{
      'color': '#c0c0c0'
    }, {
      'visibility': 'on'
    }]
  }];

let clusters = L.markerClusterGroup({
  spiderfyOnMaxZoom: !0,
  showCoverageOnHover: !1,
  zoomToBoundsOnClick: !0
});

var jpopup_customOptions = {
  'maxWidth': 'initial',
  'width': 'initial',
  'className': 'popupCustom'
};

// Helper function to create enhanced popup content
function createHotelPopupContent(element, address) {
  var roomCount = element.room_count || 0;
  var reviewCount = element.hotel_reviews_count || 0;
  var rating = element.average_rating || 0;
  var stars = element.stars || 0;
  
  var popupContent = '<div class="product-default p-0">' +
    '<figure class="product-img">' +
      '<a href="hotel/' + element.slug + '/' + element.id + '" class="lazy-container ratio ratio-5-3">' +
        '<img class="lazyload" src="assets/img/hotel/logo/' + element.logo + '" data-src="assets/img/hotel/logo/' + element.logo + '" alt="Product">' +
      '</a>' +
    '</figure>' +
    '<div class="product-details">' +
      '<h6 class="product-title">' +
        '<a href="hotel/' + element.slug + '/' + element.id + '">' + element.title + '</a>' +
      '</h6>' +
      '<div class="product-info_list">' +
        '<div class="ratings">' +
          '<span class="rate">' + rating.toFixed(1) + '</span>' +
          '<span class="rating-icon">';
  
  // Add stars
  for (var i = 0; i < stars; i++) {
    popupContent += '<i class="fas fa-star"></i>';
  }
  
  popupContent += '</span>' +
        '<span class="ratings-total">(' + reviewCount + ')</span>' +
      '</div>' +
      '<span class="room-count">' + roomCount + ' Rooms Available</span>' +
    '</div>' +
    '<span class="product-location icon-start">' +
      '<i class="fal fa-map-marker-alt"></i>' + address +
    '</span>' +
    '<a href="hotel/' + element.slug + '/' + element.id + '" class="btn">View Details</a>' +
  '</div></div>';
  
  return popupContent;
}

function mapInitialize(featured_content, hotel_content) {

  var l = !0,
    p = mapStyle,
    o = !0;
  if ($('#main-map').length) {
    map = L.map('main-map', {
      center: [105.931426295101, 160.020130352685],
      minZoom: 0,
      maxZoom: 22,
      scrollWheelZoom: o,
      tap: !L.Browser.mobile,
      fullscreenControl: true,
      fullscreenControlOptions: {
        position: 'topleft'
      }
    });

    var t = L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', {

      maxZoom: 22
    }).addTo(map);

    // Assuming dd is your data array
    featured_content.forEach(function (element) {

      var jpopup_customOptions = {};

      var latitude = element.latitude;
      var longitude = element.longitude;
      var cityId = element.city_id;
      var stateId = element.state_id;
      var countryId = element.country_id;

      var a = L.marker([latitude, longitude], {
        icon: L.divIcon({
          html: '<div class="marker-container"><div class="marker-card"><div class="front face"><i class="fa fa-hotel"></i></div><div class="marker-arrow"></div></div></div>',
          className: 'open_street_map_marker google_marker',
          iconSize: [40, 46],
          popupAnchor: [1, -35],
          iconAnchor: [20, 46],
        })
      });
      $.ajax({
        url: getAddress,
        method: 'GET',
        data: {
          city_id: cityId,
          state_id: stateId,
          country_id: countryId
        },
        success: function (response) {
          var address = response;
          var popupContent = createHotelPopupContent(element, address);
          a.bindPopup(popupContent, jpopup_customOptions);
        },
        error: function (xhr, status, error) {
          // Handle error here if needed
        }
      });

      clusters.addLayer(a);
      markers.push(a);
      map.addLayer(clusters);
    });

    // Normalize room_content
    if (!Array.isArray(hotel_content)) {
      hotel_content = Object.values(hotel_content);
    }

    hotel_content.forEach(function (element) {
      var jpopup_customOptions = {};

      var latitude = element.latitude;
      var longitude = element.longitude;
      var cityId = element.city_id;
      var stateId = element.state_id;
      var countryId = element.country_id;
      var a = L.marker([latitude, longitude], {
        icon: L.divIcon({
          html: '<div class="marker-container"><div class="marker-card"><div class="front face"><i class="fa fa-hotel"></i></div><div class="marker-arrow"></div></div></div>',
          className: 'open_street_map_marker google_marker',
          iconSize: [40, 46],
          popupAnchor: [1, -35],
          iconAnchor: [20, 46],
        })
      });

      // Perform AJAX request
      $.ajax({
        url: getAddress,
        method: 'GET',
        data: {
          city_id: cityId,
          state_id: stateId,
          country_id: countryId
        },
        success: function (response) {
          var address = response;
          var popupContent = createHotelPopupContent(element, address);
          a.bindPopup(popupContent, jpopup_customOptions);
        },
        error: function (xhr, status, error) {
          // Handle error here if needed
        }
      });

      clusters.addLayer(a);
      markers.push(a);
      map.addLayer(clusters);
    });


    if (markers.length) {
      var e = [];
      for (var i in markers) {
        if (typeof markers[i]['_latlng'] == 'undefined') continue;
        var c = [markers[i].getLatLng()];
        e.push(c)
      };
      var r = L.latLngBounds(e);
      map.fitBounds(r)
    };
    if (!markers.length) { }
  }
}
