// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require material
//= require ripples
//= require underscore
//= require jquery.geocomplete
//= require gmaps/google

function initMap(id) {
  var handler = Gmaps.build('Google');
  var lat = $('#' + id).parent().find('.map-marker-coordinates').find('#lat').val();
  var lng = $('#' + id).parent().find('.map-marker-coordinates').find('#lng').val();
  var title = $('#' + id).parent().find('.map-marker-coordinates').find('#address').val();
  handler.buildMap({
      provider: {
        disableDefaultUI: true,
        center: new google.maps.LatLng(parseFloat(lat), parseFloat(lng)),
        zoom: 14,
        zoomControl: true,
        zoomControlOptions: {
          style: google.maps.ZoomControlStyle.DEFAULT,
          position: google.maps.ControlPosition.RIGHT_CENTER
        },
        panControl: false,
        mapTypeControl: false,
        scaleControl: false,
        streetViewControl: false,
        overviewMapControl: false,
        rotateControl: false
      },
      internal: {
        id: id
      }
    },
    function(){
      markers = handler.addMarkers([
        {
          "lat": lat,
          "lng": lng,
          "marker_title": title
        }
      ]);
      handler.bounds.extendWith(markers);
      // handler.fitMapToBounds();
    }
  );
}

function setMaps() {
  $('.mini-event-map').each(function(index, el) {
    var id = $(el).attr('id');
    initMap(id);
  });
}


$(document).ready(function() {
  $.material.init();

  setMaps();
});

$('#menu-toggle').click(function(event) {
  event.preventDefault();
  $('#wrapper').toggleClass('toggled');
});

$('ul.nav.navbar-nav.navbar-right li').hover(function() {
  $(this).addClass('active');
}, function() {
  $(this).removeClass('active');
});
