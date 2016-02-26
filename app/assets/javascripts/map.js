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
