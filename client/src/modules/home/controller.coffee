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

  $scope.form = {}
  $scope.annexState = 'a'
  $scope.toggleMoreOptions = ->
    $scope.expanded = !$scope.expanded
    timeout = if !$scope.showOptions then 300 else 0
    $timeout (->
      $scope.showOptions = !$scope.showOptions
    ), timeout

  $scope.changeAnnexState =(current)->
    $scope.annexState = current

  $scope.search = ->
    $scope.query.from = $('#origin').val()
    $scope.query.to = $('#destination').val()

    $scope.form.from = if $scope.query.from.trim() == ''  then true else false
    $scope.form.to = if $scope.query.to.trim() == '' then true else false

    if $scope.form.from || $scope.form.to
      $.growl.error {message: MESSAGES.FORM_ERROR}
      return

    if !$scope.query.bus && !$scope.query.rail
      $scope.toggleMoreOptions() unless $scope.expanded
      $.growl.error {message: MESSAGES.INVALID_TRANSIT}
      return

    $state.go("site.result", $scope.query)



Ctrl.$inject = ['$scope','$state','Gmap','$http','$timeout','$rootScope']
angular.module('client').controller('HomeCtrl', Ctrl)
