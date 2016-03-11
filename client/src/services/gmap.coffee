angular.module('client').factory 'Gmap',
  ['$resource','$rootScope','$window'
  ($resource, $rootScope, $window) ->


    google.maps.Map::drawCircle =(obj)->
      new (google.maps.Circle)(
        strokeColor: Gmap.getStrokeColor(obj.orientation)
        strokeOpacity: .1
        fillColor: Gmap.getFillColor(obj.orientation)
        fillOpacity: .7
        map: this
        center: {lat: obj.lat, lng: obj.lng}
        radius: Math.sqrt(obj.total_count) * 20)

    google.maps.Map::eventPanel =(obj)->
      events = ""
      for event in obj.events
        events+= @buildEvenList(event)
        @appendMarker(event,this)
      "<div class='event-panel'>
        <h4 class='title'>
          <i class='#{@buildEventIcon(obj.info_type)}'></i>
          #{obj.info_type}
        </h4>
        <ul class='event-list'>
          #{events}
        </ul>
      </div>"


    Gmap = $resource "https://maps.googleapis.com", {key: GMAP_API_KEY},
      {
        directions:
          method: 'GET'
          url: 'https://maps.googleapis.com/maps/api/directions/json'

      }

    Gmap.initMap = ->
      map = new (google.maps.Map)(document.getElementById('map'),
        zoom: 12
        center:
          lat: 14.5495
          lng: 121.027)
      map

    Gmap.initAdmiMap = ->
      map = new (google.maps.Map)(document.getElementById('admin-map'),
        zoom: 15
        center:
          lat: 14.5495
          lng: 121.027)
      map

    Gmap.getStrokeColor=(orientation)->
      if orientation then "#2dcb73" else "#337ab7"

    Gmap.getFillColor=(orientation)->
      if orientation then "#2dcb73" else "#337ab7"

    Gmap.appendMarker=(event,map)->
      image = new (google.maps.MarkerImage)("/images/#{@markerIcon(event.info_type)}", null, null, null, new (google.maps.Size)(22, 30))
      new (google.maps.Marker)(
        position:
          lat: event.lat
          lng: event.lng
        map: map
        icon: image)


    Gmap.markerIcon =(event)->
      switch event
        when "Crime Details"
          "crime_pin.png"
        when "Traffic Incident"
          "traffic_incident.png"
        else
          "tour.png"

    Gmap.buildEvenList =(event)->
      " <li>
        <div class='event-place'>
          #{event.place}
        </div>
        <div class='event-desc'>
          #{event.description}
        </div>
        <div class='event-date'>
          #{event.created_at.formatTimestamp()}
        </div>
      </li>"

    Gmap.buildEventIcon =(event)->
      switch event
        when "Crime Details"
          "icon-crime"
        when "Traffic Incident"
          "icon-traffic"
        else
          "icon-inst"
    Gmap
  ]
