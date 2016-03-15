Ctrl = ($scope,$state,$timeout,$rootScope,Direction,Gmap)->

  $scope.uiState =
    pagination: false
    page: 1
    modal: false
    searched: false

  $scope.query =
    from: ""
    to: ""

  $scope.form = {}
  $scope.legs = []

  initMap = ->
    map = Gmap.initAdmiMap()
    # $http.get("/api/searches").
    #   success (data)->
    #     $scope.collection = data
    #     for obj in data.from
    #       map.drawCircle(obj)
    #
    #     for obj in data.to
    #       map.drawCircle(obj)

  $scope.search = ->
    $scope.query.from = $('#origin').val()
    $scope.query.to = $('#destination').val()

    $scope.form.from = if $scope.query.from.trim() == ''  then true else false
    $scope.form.to = if $scope.query.to.trim() == '' then true else false

    if $scope.form.from || $scope.form.to
      $.growl.error {message: MESSAGES.FORM_ERROR}
      return

    Direction.get({id: 0}, from: $scope.query.from, to: $scope.query.to).$promise
      .then (data)->
        $scope.legs = data.legs
        $scope.uiState.searched = true

  initMap()


Ctrl.$inject = ['$scope','$state','$timeout','$rootScope','Direction','Gmap']
angular.module('client').controller('AdminDirectionsFormCtrl', Ctrl)
