class NewChallengeMapWidget extends BaseWidget
  init: ->
    @initMap()
    @initSearchField()
    @initMapZoom()
    @initHandlers()

  initMap: ->
    center = new google.maps.LatLng 51.531447323113106, -0.1547113037108816
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

    if 'geolocation' of navigator
      navigator.geolocation.getCurrentPosition (position) =>
        coords = position.coords
        center = new google.maps.LatLng coords.latitude, coords.longitude
        @map.setCenter center

  initSearchField: ->
    mapSearch = document.getElementById "map-search"
    @map.controls[google.maps.ControlPosition.TOP_LEFT].push(mapSearch)
    @mapSearchBox = new google.maps.places.SearchBox mapSearch
    google.maps.event.addListener @mapSearchBox, 'places_changed', () =>
      places = @mapSearchBox.getPlaces()
      if places.length > 0
        @map.setCenter places[0].geometry.location

  initMapZoom: ->
    zoomControlDiv = $ '<div />'
    zoomControlDiv.addClass "map-zoom"
    zoomControl = new ZoomControl(zoomControlDiv, @map)
    zoomControlDiv.index = 1;
    @map.controls[google.maps.ControlPosition.TOP_RIGHT].push(zoomControlDiv.get(0))

  initHandlers: ->
    google.maps.event.addListener @map, 'bounds_changed', () =>
      window.setTimeout =>
        if $('.map-container:visible').length > 0
          bounds = @map.getBounds()
          @mapSearchBox.setBounds bounds
          @waitForMapUpdate()
      , 300

  waitForMapUpdate: (event) ->
    clearTimeout(@mapUpdateInterval) if @mapUpdateInterval?
    @mapUpdateInterval = setTimeout () =>
      bounds = new google.maps.LatLngBounds()
      bounds = @map.getBounds()
      ne = bounds.getNorthEast()
      sw = bounds.getSouthWest()
      @boundsChangedHandler ne, sw
    , 500

  boundsChangedHandler: (ne, sw) ->
    el = $('.results-container', @element)
    url = "#{@options['search-url']}?bounds=#{sw.lat()},#{sw.lng()},#{ne.lat()},#{ne.lng()}"
    loading = $('.results-loading')
    el.hide()
    loading.show()
    el.load url, null, =>
      loading.hide()
      el.show()

  ZoomControl = (controlDiv, map) ->
    outBtn = $ '<div/>'
    outIcon = $ '<span class="glyphicon glyphicon-minus"/>'
    outBtn.append outIcon
    controlDiv.append outBtn
    google.maps.event.addDomListener outBtn.get(0), 'click', () ->
      map.setZoom(map.getZoom() - 1)

    inBtn = $ '<div />'
    inIcon = $ '<span class="glyphicon glyphicon-plus" />'
    inBtn.append inIcon
    controlDiv.append inBtn
    google.maps.event.addDomListener inBtn.get(0), 'click', () ->
      map.setZoom(map.getZoom() + 1)

Widgets.register 'new-challenge-map', NewChallengeMapWidget
