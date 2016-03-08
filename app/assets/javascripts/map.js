$(function() {

  var load_map = function() {

    var lat = parseFloat($('#latitude').val())
    var lon = parseFloat($('#longitude').val())
    $('#map').locationpicker({
      location: {latitude: lat || 53.348864, longitude: lon || -6.2502467},
      radius: 0,
      enableAutocomplete: true,
      inputBinding: {
        latitudeInput: $('#latitude'),
        longitudeInput: $('#longitude'),
        locationNameInput: $('#address')
      }
    });
  }

  if($('#map').length) load_map();

});

$(function() {

  var location_search = function() {

    var autocomplete = new google.maps.places.Autocomplete(document.getElementById('search_location'));
    google.maps.event.addListener(autocomplete, 'place_changed', function () {
      var place = autocomplete.getPlace();
      document.getElementById('latitude').value = place.geometry.location.lat();
      document.getElementById('longitude').value = place.geometry.location.lng();
  });
  }

  if($('#locationSearch').length) location_search();

});
