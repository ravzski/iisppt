Ctrl = ($scope,$state,Gmap,$http)->

  $scope.query =
    origin: $state.params.origin
    destination: $state.params.destination
    date: moment().format(DATE_FORMAT)
    time: ""
    departure: true
    arrival: false

  directionsDisplay = new (google.maps.DirectionsRenderer)
  directionsService = new (google.maps.DirectionsService)

  initMap = ->
    map = new (google.maps.Map)(document.getElementById('map'),
      zoom: 7
      center:
        lat: 41.85
        lng: -87.65)
    directionsDisplay.setMap map
    directionsDisplay.setPanel document.getElementById('right-panel')
    calculateAndDisplayRoute()


  calculateAndDisplayRoute = ->

    directionsService.route {
      origin: $scope.query.origin
      destination: $scope.query.destination
      travelMode: google.maps.TravelMode.DRIVING
    }, (response, status) ->

      if status == google.maps.DirectionsStatus.OK
        directionsDisplay.setDirections response
      else
        window.alert 'Directions request failed due to ' + status


  initMap()

  $scope.search = ->
    $state.go("site.result", $scope.query)


Ctrl.$inject = ['$scope','$state','Gmap','$http']
angular.module('client').controller('ResultCtrl', Ctrl)
