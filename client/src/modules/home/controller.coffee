Ctrl = ($scope,$state,Gmap,$http,$timeout,$rootScope)->

  $scope.expanded = false
  $scope.showOptions = false
  $rootScope.headerClass = "home-header"
  $scope.query =
    origin: ""
    destination: ""
    departure_time: moment(new Date()).format(DATE_FORMAT)
    time: moment(new Date()).format("hh:mma")
    departure: true
    arrival: false
    bus: true
    rail: true

  $scope.toggleMoreOptions = ->
    $scope.expanded = !$scope.expanded
    timeout = if !$scope.showOptions then 300 else 0
    $timeout (->
      $scope.showOptions = !$scope.showOptions
    ), timeout

  $scope.search = ->
    $scope.query.from = $('#origin').val()
    $scope.query.to = $('#destination').val()

    $state.go("site.result", $scope.query)



Ctrl.$inject = ['$scope','$state','Gmap','$http','$timeout','$rootScope']
angular.module('client').controller('HomeCtrl', Ctrl)
