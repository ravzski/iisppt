Ctrl = ($scope,$state,Gmap,$http,$timeout)->

  $scope.expanded = false
  $scope.showOptions = false

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
    if !$scope.showOptions
      $timeout (->
        $scope.showOptions = !$scope.showOptions
      ), 300
    else
      $scope.showOptions = !$scope.showOptions

  $scope.search = ->
    $scope.query =
      origin: $('#origin').val()
      destination: $('#destination').val()

    $state.go("site.result", $scope.query)


Ctrl.$inject = ['$scope','$state','Gmap','$http','$timeout']
angular.module('client').controller('HomeCtrl', Ctrl)
