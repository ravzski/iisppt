Ctrl = ($scope,$state,Gmap,$http)->

  $scope.expanded = false

  $scope.query =
    origin: ""
    destination: ""
    date: moment().format(DATE_FORMAT)
    time: ""
    departure: true
    arrival: false
    bike: true
    train: true
    car: true
    walk: true

  $scope.toggleMoreOptions = ->
    $scope.expanded = !$scope.expanded

  $scope.search = ->
    $scope.query =
      origin: $('#origin').val()
      destination: $('#destination').val()

    $state.go("site.result", $scope.query)


Ctrl.$inject = ['$scope','$state','Gmap','$http']
angular.module('client').controller('HomeCtrl', Ctrl)
