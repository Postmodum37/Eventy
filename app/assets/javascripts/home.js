// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// function initMap(id) {
//   var handler = Gmaps.build('Google');
//   var lat = $('#' + id).parent().find('.map-marker-coordinates').find('#lat').val();
//   var lng = $('#' + id).parent().find('.map-marker-coordinates').find('#lng').val();
//   var title = $('#' + id).parent().find('.map-marker-coordinates').find('#address').val();
//   handler.buildMap({
//       provider: {
//         disableDefaultUI: true,
//         center: new google.maps.LatLng(parseFloat(lat), parseFloat(lng)),
//         zoom: 14,
//         zoomControl: true,
//         zoomControlOptions: {
//           style: google.maps.ZoomControlStyle.DEFAULT,
//           position: google.maps.ControlPosition.RIGHT_CENTER
//         },
//         panControl: false,
//         mapTypeControl: false,
//         scaleControl: false,
//         streetViewControl: false,
//         overviewMapControl: false,
//         rotateControl: false
//       },
//       internal: {
//         id: id
//       }
//     },
//     function(){
//       markers = handler.addMarkers([
//         {
//           "lat": lat,
//           "lng": lng,
//           "marker_title": title
//         }
//       ]);
//       handler.bounds.extendWith(markers);
//       // handler.fitMapToBounds();
//     }
//   );
// }
//
// function setMaps() {
//   $('.mini-event-map').each(function(index, el) {
//     var id = $(el).attr('id');
//     initMap(id);
//   });
// }
//
// $(document).ready(function() {
//
//
//   setMaps();
// });
