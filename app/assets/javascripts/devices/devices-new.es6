$(document).on('page:change', () => {
  if ($(".c-devices.a-new").length === 1) {
    const $CREATE_CHECKIN = $('#create_checkin');
    const $ADD_BUTTON = $('#add_button');
    const $PREVIEW = $('#preview');

    $CREATE_CHECKIN.change(() => {
      if ($CREATE_CHECKIN.prop('checked')) {
        $ADD_BUTTON.addClass('disabled').prop('disabled', true);
        if ($PREVIEW.hasClass("hide")) {
          $PREVIEW.css('display', 'block');
          navigator.geolocation.getCurrentPosition(showPosition, COPO.utility.geoLocationError);
        }
      } else {
        $(document).off('page:before-unload');
        $PREVIEW.fadeOut("fast", () => $PREVIEW.addClass("hide"));
        if (typeof map !== "undefined") {
          map.remove();
        }
        $ADD_BUTTON.removeClass('disabled').prop('disabled', false);
      }
    });

    function showPosition(position) {
      $ADD_BUTTON.removeClass("disabled").prop('disabled', false);
      $PREVIEW.removeClass("hide");

      const LOCATION = { lat: position.coords.latitude, lng: position.coords.longitude }
      updateLocation(LOCATION);

      COPO.maps.initMap({
        tileLayer: {
          continuousWorld: false,
          noWrap: true
        }
      });
      const MARKER_OPTIONS = {
        icon: L.mapbox.marker.icon({ 'marker-symbol' : 'marker', 'marker-color' : '#ff6900' }),
        draggable: true
      }
      const MARKER = L.marker([LOCATION.lat, LOCATION.lng], MARKER_OPTIONS);
      MARKER.addTo(map);
      map.once('ready', () => map.setView(MARKER.getLatLng(), 16));
      MARKER.on('dragend', e => updateLocation(e.target.getLatLng()));

      function updateLocation(loc) {
        $('#coordinates').html(`Latitude: ${loc.lat.toFixed(6)}<br />Longitude: ${loc.lng.toFixed(6)}`);
        const LATLON = `${loc.lng},${loc.lat}`;
        $('#location').attr("value", LATLON);
      }
    }
  }
});
