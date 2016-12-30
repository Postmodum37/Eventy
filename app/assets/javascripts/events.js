// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var editEventTitleLT = 'Redaguoti Renginį';
var editEventTitleEN = 'Edit Event';
var newEventTitleLT = 'Sukurti Renginį';
var newEventTitleEN = 'Create an Event';

function triggerChange() {
  $('#event_city').trigger("change");
  $('#event_street').trigger("change");
  $('#event_street_number').trigger("change");
  $('#event_postal_code').trigger("change");
}

$(document)
  .on('change', '#event_paid', function(event) {
    if($(this).is(":checked")) {
      $('.paid-checkbox-wrapper').show();
      $('#event_price').attr({required: 'required'});
    } else {
      $('.paid-checkbox-wrapper').hide();
      $('#event_price').removeAttr('required')
      $('#event_price').val('');
    }
  });

$(document).ready(function() {
  if (($('.event-action-title').text() === editEventTitleEN) || ($('.event-action-title').text() === editEventTitleLT)) {
    $("#event_address")
    .geocomplete({
      country: 'LT',
      map: '#map',
      details: 'form',
      detailsAttribute: "data-geo",
      types: ['geocode'],
      autoselect: true,
      bounds: true,
      location: [$('#event_lat').val(), $('#event_lng').val()],
      mapOptions: {
        disableDefaultUI: true,
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
      markerOptions: {
        draggable: false
      }
    })
    .bind("geocode:result", function(event, result){
      triggerChange();
    });
  } else if (($('.event-action-title').text() === newEventTitleEN) || ($('.event-action-title').text() === newEventTitleLT)) {
    $("#event_address")
    .geocomplete({
      country: 'LT',
      map: '#map',
      details: 'form',
      detailsAttribute: "data-geo",
      types: ['geocode'],
      autoselect: true,
      bounds: true,
      // location: [$('#event_lat').val(), $('#event_lng').val()],
      mapOptions: {
        disableDefaultUI: true,
        center: new google.maps.LatLng(54.8985, 23.9036),
        zoom: 9,
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
      markerOptions: {
        draggable: false
      }
    })
    .bind("geocode:result", function(event, result){
      triggerChange();
    });

  } else {
    console.log('Check Titles.');
  }
  // $("#event_address").removeAttr('placeholder');
});
