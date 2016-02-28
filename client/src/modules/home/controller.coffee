Ctrl = ($scope,$state,Gmap,$http,$timeout,$rootScope)->

  $scope.expanded = false
  $scope.showOptions = false
  $rootScope.headerClass = "home-header"
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
    timeout = if !$scope.showOptions then 300 else 0
    $timeout (->
      $scope.showOptions = !$scope.showOptions
    ), timeout

  $scope.search = ->
    $scope.query =
      origin: $('#origin').val()
      destination: $('#destination').val()

    $state.go("site.result", $scope.query)


Ctrl.$inject = ['$scope','$state','Gmap','$http','$timeout','$rootScope']
angular.module('client').controller('HomeCtrl', Ctrl)
