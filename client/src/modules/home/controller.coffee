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

  # move this to a directive some other time
  $('.bg-slideshow').backstretch [
    '/images/slide2.jpg'
    '/images/slide3.jpg'
  ],{duration: 3000, fade: 750}

  initAutocomplete()

Ctrl.$inject = ['$scope','$state','Gmap','$http']
angular.module('client').controller('HomeCtrl', Ctrl)
