Ctrl = ($scope,$state,Gmap,$http,$rootScope)->

  $rootScope.headerClass = ""
  $scope.uiState =
    noRoute: false
    showRating: false

  $scope.query =
    from: $state.params.from
    to: $state.params.to
    departure_time: $state.params.departure_time || moment().format(DATE_FORMAT)
    bus: if $state.params.bus == "true" then true else false
    rail: if $state.params.rail == "true" then true else false
    via: ''
    time: $state.params.time || new Date().valueOf()

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
    $scope.calculateAndDisplayRoute()

    # $http.get("/api/search",{params: $scope.query}).
    #   success (data)->

  $scope.calculateAndDisplayRoute = ->
    $scope.uiState.showRating = false
    waypts = []
    waypts.push {location: $scope.query.via, stopover: true} if $scope.query.via.trim() !=''
    # time = moment(new Date("2016-03-05 5:45 am")).toDate().getTime()

    time= new Date( moment("#{$scope.query.departure_time} #{$scope.query.time}", "M/D/YYYY H:mm").valueOf())

    directionsService.route {
      origin: $scope.query.from
      destination: $scope.query.to
      travelMode: google.maps.TravelMode.TRANSIT
      waypoints: waypts,
      optimizeWaypoints: true,
      provideRouteAlternatives: true
      transitOptions:
        modes: getModes()
        departureTime: time
    }, (response, status) ->
      if status == google.maps.DirectionsStatus.OK
        $scope.uiState.showRating = true
        $scope.$apply()
        directionsDisplay.setDirections response
      else
        $scope.uiState.noRoute = true
        $scope.$apply()


  getModes = ->
    modes = []
    modes.push "BUS" if $scope.query.bus
    modes.push "RAIL" if $scope.query.rail
    modes

  initMap()

  $scope.search = ->
    $scope.query.from = $('#origin').val()
    $scope.query.to = $('#destination').val()
    $scope.query.via = $('#via').val()
    $state.go("site.result", $scope.query)


Ctrl.$inject = ['$scope','$state','Gmap','$http','$rootScope']
angular.module('client').controller('ResultCtrl', Ctrl)
