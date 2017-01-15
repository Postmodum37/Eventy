// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var editEventTitleLT = 'Redaguoti Renginį';
var editEventTitleEN = 'Edit Event';
var newEventTitleLT = 'Sukurti Renginį';
var newEventTitleEN = 'Create an Event';
var showEventTitleLT = 'Renginio Peržiūra';
var showEventTitleEN = 'Show Event';

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

  } else if (true) {
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
    });
  } else {
    console.log('Check Titles.');
  }
  // $("#event_address").removeAttr('placeholder');
});

$('a.deny-event-registration').on('ajax:success', function(e, data, status, xhr) {
  displayNotification('success', 'Successfully denied registration.');

  var pendingTextValue;
  var approvedTextValue;
  var deniedTextValue;

  $(e.target).parent().parent().parent().parent().appendTo('.denied-list');
  $lastRegistration = $('.denied-list').children().last();
  $lastRegistration.find('.least-content').text('less than a minute');
  $lastRegistration.find('.btn-group').remove();
  $lastRegistration.find('.list-group-item-text').addClass('text-danger').text('Requested denied to join this event.');
  pendingTextValue = Number($('.pending-count').text());
  deniedTextValue = Number($('.denied-count').text());

  $('.denied-count').text((deniedTextValue + 1).toString());
  $('.pending-count').text((pendingTextValue - 1).toString());

  if (deniedTextValue === 0) {
    $('.denied-list').find('p.text-center').remove();
  }

  if ((pendingTextValue - 1) === 0) {
    $('#pending').find('.list-group').append('<p class="text-center">No pending requests.</p>');
  }
});

$('a.deny-event-registration').on('ajax:error', function(e, data, status, xhr) {
  displayNotification('warning', 'Something went wrong while denying registration.');
});

$('a.approve-event-registration').on('ajax:success', function(e, data, status, xhr) {
  displayNotification('success', 'Successfully approved registration.');

  var pendingTextValue;
  var approvedTextValue;
  var deniedTextValue;

  $(e.target).parent().parent().parent().parent().appendTo('.approved-list');
  $lastRegistration = $('.approved-list').children().last();
  $lastRegistration.find('.least-content').text('less than a minute');
  $lastRegistration.find('.btn-group').remove();
  $lastRegistration.find('.list-group-item-text').addClass('text-success').text('Requested approved to join this event.');
  pendingTextValue = Number($('.pending-count').text());
  approvedTextValue = Number($('.approved-count').text());

  $('.approved-count').text((approvedTextValue + 1).toString());
  $('.pending-count').text((pendingTextValue - 1).toString());

  if (approvedTextValue === 0) {
    $('.approved-list').find('p.text-center').remove();
  }

  if ((pendingTextValue - 1) === 0) {
    $('#pending').find('.list-group').append('<p class="text-center">No pending requests.</p>');
  }
});

$('a.approve-event-registration').on('ajax:error', function(e, data, status, xhr) {
  displayNotification('warning', 'Something went wrong while approving registration.');
});

$('#star-rating').raty({
    // path: '/assets/',
    scoreName: 'review[rating]'
});

$('.review-rating').raty({
    // path: '/assets/',
    readOnly: true,
    score: function() {
        return $(this).attr('data-score');
  }
});
