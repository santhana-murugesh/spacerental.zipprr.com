// Global map style and popup options
var mapStyle = [{
    'featureType': 'landscape',
    'elementType': 'geometry.fill',
    'stylers': [{ 'color': '#fcf4dc' }]
}, {
    'featureType': 'landscape',
    'elementType': 'geometry.stroke',
    'stylers': [{ 'color': '#c0c0c0' }, { 'visibility': 'on' }]
}];

var jpopup_customOptions = {
    maxWidth: 'initial',
    width: 'initial',
    className: 'popupCustom'
};

$(document).ready(function () {
    mapInitialize(properties);
});

function mapInitialize(properties) {
    // Remove previous map instance if it exists
    if (window.activeMap) {
        window.activeMap.remove();
    }

    var markers = [];
    var defaultCoordinates = [51.505, -0.09]; // Fallback view (e.g. London)
    var defaultZoom = 3;

    if ($('#main-map').length) {
        var map = L.map('main-map', {
            scrollWheelZoom: true,
            tap: !L.Browser.mobile,
            renderer: L.canvas({ padding: 0.5 }) // Better rendering
        });

        window.activeMap = map; // Store active map globally

        // Add basemap
        L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
            attribution: '&copy; OpenStreetMap &copy; CartoDB',
            subdomains: 'abcd',
            maxZoom: 19
        }).addTo(map);

        // Cluster group setup
        var clusters = L.markerClusterGroup({
            spiderfyOnMaxZoom: true,
            showCoverageOnHover: false,
            zoomToBoundsOnClick: true,
            disableClusteringAtZoom: 16
        });

        if (Array.isArray(properties) && properties.length > 0) {
            properties.forEach(element => {
                if (!element.latitude || !element.longitude) return;

                var iconHTML = `
                    <div class="marker-container">
                        <div class="marker-card">
                            <div class="front face">
                                <i class="fal fa-${element.type === 'commercial' ? 'building' : 'home'}"></i>
                            </div>
                            <div class="marker-arrow"></div>
                        </div>
                    </div>`;

                var marker = L.marker([element.latitude, element.longitude], {
                    icon: L.divIcon({
                        html: iconHTML,
                        className: 'open_steet_map_marker google_marker retina-marker',
                        iconSize: [40, 46],
                        popupAnchor: [1, -35],
                        iconAnchor: [20, 46],
                    })
                });

                var propertyUrl = baseURL + '/property/' + element.slug;
                var popupContent = `
                    <div class="product-default p-0">
                        <figure class="product-img">
                            <a href="${propertyUrl}" class="lazy-container ratio ratio-1-1">
                                <img class="lazyload" src="assets/images/placeholder.png" data-src="${baseURL}/assets/img/property/featureds/${element.featured_image}" alt="Product">
                            </a>
                        </figure>
                        <div class="product-details">
                            <h6 class="product-title"><a href="${propertyUrl}">${element.title}</a></h6>
                            <span class="product-location icon-start"><i class="fal fa-map-marker-alt"></i>${element.address}</span>
                        </div>
                        <span class="label text-capitalize">${element.purpose}</span>
                    </div>`;

                marker.bindPopup(popupContent, jpopup_customOptions);
                clusters.addLayer(marker);
                markers.push(marker);
            });

            // Add cluster group after all markers added
            map.addLayer(clusters);

            // Fit map to marker bounds
            if (markers.length) {
                var bounds = L.latLngBounds(markers.map(m => m.getLatLng()));
                map.fitBounds(bounds);
            } else {
                map.setView(defaultCoordinates, defaultZoom);
            }

        } else {
            map.setView(defaultCoordinates, defaultZoom);
        }

        // Fix rendering on resize (especially for macOS Retina displays)
        $(window).on('resize', function () {
            map.invalidateSize();
        });
    }
}
