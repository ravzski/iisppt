Ctrl = ($scope,$state,Gmap,$http)->

  $scope.query =
    origin: ""
    destination: ""
    date: moment().format(DATE_FORMAT)
    time: ""
    departure: true
    arrival: false

  initAutocomplete = ->
    new (google.maps.places.Autocomplete)(document.getElementById('origin'), types: [ 'geocode' ])
    new (google.maps.places.Autocomplete)(document.getElementById('destination'), types: [ 'geocode' ])

  $scope.search = ->
    $scope.query =
      origin: $('#origin').val()
      destination: $('#destination').val()

    $state.go("site.result", $scope.query)



  initAutocomplete()

Ctrl.$inject = ['$scope','$state','Gmap','$http']
angular.module('client').controller('HomeCtrl', Ctrl)
