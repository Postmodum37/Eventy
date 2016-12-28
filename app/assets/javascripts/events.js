// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  // handler = Gmaps.build('Google');
  // handler.buildMap({
  //     provider: {
  //       disableDefaultUI: true,
  //       center: new google.maps.LatLng(54.8985, 23.9036),
  //       zoom: 9,
  //       zoomControl: true,
  //       zoomControlOptions: {
  //         style: google.maps.ZoomControlStyle.DEFAULT,
  //         position: google.maps.ControlPosition.RIGHT_CENTER
  //       },
  //       panControl: false,
  //       mapTypeControl: false,
  //       scaleControl: false,
  //       streetViewControl: false,
  //       overviewMapControl: false,
  //       rotateControl: false
  //     },
  //     internal: {
  //       id: 'map'
  //     }
  //   },
  //   function(){
  //     // handler.bounds.extendWith(markers);
  //     handler.fitMapToBounds();
  //   }
  // );
  if (($('.event-action-title').text() === 'Edit Event') || ($('.event-action-title').text() === 'Keisti Renginį')) {
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
    .bind("geocode:dragged", function(event, latLng){
      // console.log(latLng);
      // $("#event_address").trigger("geocode");
      // $("#event_address").geocomplete("find", latLng.lat() + ', ' + latLng.lng());
    });
  } else if (($('.event-action-title').text() === 'Create an Event') || ($('.event-action-title').text() === 'Sukurti Renginį')) {
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
    .bind("geocode:dragged", function(event, latLng){
      // console.log(latLng);
      // $("#event_address").trigger("geocode");
      // $("#event_address").geocomplete("find", latLng.lat() + ', ' + latLng.lng());
    });
  }
});
