class ChallengeMapDetailWidget extends BaseWidget
  init: ->
    @initMap()

  initMap: ->
    center = new google.maps.LatLng 51.531447323113106, -0.1547113037108816
    if @options.start_latlng and @options.end_latlng
      bounds = new google.maps.LatLngBounds()
      latlng = @options.start_latlng.split ','
      center = new google.maps.LatLng(latlng[0], latlng[1])



    @map = new google.maps.Map document.getElementById('map'),
      center:    center,
      zoom:      14,
      maxZoom:   17,
      disableDefaultUI: true,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      styles: [{
        featureType: 'poi',
        elementType: 'labels',
        stylers: [
          { visibility: 'off' }
        ]
      }]

    polyline = @options.polyline
    if polyline? and polyline != ""
      path = google.maps.geometry.encoding.decodePath polyline
      line = new google.maps.Polyline
        path: path
        strokeColor: "#cc0000",
        strokeWeight: 4
      window.x = line
      line.setMap @map

Widgets.register 'challenge-map-detail', ChallengeMapDetailWidget
