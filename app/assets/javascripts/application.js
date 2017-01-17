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
//= require moment
//= require underscore
//= require jquery.geocomplete
//= require gmaps/google
//= require bootstrap-notify
//= require jquery.raty
//= require bootstrap-datetimepicker


function displayNotification(type, message) {
  $.notify({
  	message: message
  },{
    delay: 3000,
  	type: type,
    placement: {
  		from: "top",
  		align: "right",
	  },
    animate: {
  		enter: 'animated fadeInDown',
  		exit: 'animated fadeOutUp'
  	}
  });
}

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


$('a.event-registration-btn.already-registered').on('click', function(event) {
  displayNotification('info', 'Already registered to this event.');
  event.preventDefault();

});

$('a.event-registration-btn.not-signed-in').on('click', function(event) {
  displayNotification('info', 'Please sign in before registering to an event.');
  event.preventDefault();
});

$('a.event-registration-btn.event-over').on('click', function(event) {
  displayNotification('info', 'Registration to event is closed.');
  event.preventDefault();
});

$('a.btn.btn-info.not-available-for-edit').on('click', function(event) {
  displayNotification('info', 'Editing is not available. Event is starting in less than a day.');
  event.preventDefault();
});

$('a.event-registration-btn.registration-available').on('ajax:success', function(e, data, status, xhr) {
  $(this).attr({
    disabled: 'disabled'
  });
  $(this).removeAttr('data-remote').removeAttr('href').removeAttr('rel').removeAttr('data-method');
  $(this).removeClass('registration-available').addClass('already-registered');
  $(this).text('Pending')
  displayNotification('success', 'Successfully registered to an event.');
});

$('a.event-registration-btn').on('ajax:error', function(e, data, status, xhr) {
  displayNotification('warning', 'Something went wrong while registering to an event.');
});

$('.datetimepicker').datetimepicker({
  format: 'YYYY/MM/DD HH:mm'
});
