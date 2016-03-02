Ctrl = ($scope,$state,Gmap,$http,$rootScope)->

  $rootScope.headerClass = ""
  $scope.query =
    from: $state.params.from
    to: $state.params.to
    departure_time: $state.params.departure_time || moment().format(DATE_FORMAT)
    time: moment(new Date()).format("hh:mma")
    bus: if $state.params.bus == "true" then true else false
    rail: if $state.params.rail == "true" then true else false

  directionsDisplay = new (google.maps.DirectionsRenderer)
  directionsService = new (google.maps.DirectionsService)

  initMap = ->
    map = new (google.maps.Map)(document.getElementById('map'),
      zoom: 7
      center:
        lat: 41.85
        lng: -87.65)
    directionsDisplay.setMap map
    directionsDisplay.setPanel document.getElementById('direction-panel')
    calculateAndDisplayRoute()

    # $http.get("/api/search",{params: $scope.query}).
    #   success (data)->

  calculateAndDisplayRoute = ->
    time = moment(new Date("2016-03-05 12:45 am")).subtract(moment.duration("00:05:20"))
    directionsService.route {
      origin: $scope.query.from
      destination: $scope.query.to
      travelMode: google.maps.TravelMode.TRANSIT
      provideRouteAlternatives: true
      transitOptions:
        modes: getModes()
        departureTime: new Date(time)
    }, (response, status) ->
      if status == google.maps.DirectionsStatus.OK
        directionsDisplay.setDirections response
      else
        window.alert 'Directions request failed due to ' + status


  getModes = ->
    modes = []
    modes.push "BUS" if $scope.query.bus
    modes.push "RAIL" if $scope.query.rail
    modes

  initMap()

  $scope.search = ->
    $state.go("site.result", $scope.query)


Ctrl.$inject = ['$scope','$state','Gmap','$http','$rootScope']
angular.module('client').controller('ResultCtrl', Ctrl)
