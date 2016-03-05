Ctrl = ($scope,$state,$timeout,$rootScope,Marker)->

  $scope.info_types = angular.copy INFO_TYPE
  $scope.agency = angular.copy $state.$current.data.agency
  $scope.agency_scope =  $scope.agency.toLowerCase()
  $scope.uiState =
    submit: false

  if $state.$current.name.split(".")[2] == 'new'
    $scope.marker =
      created_at: moment(new Date()).format(DATE_FORMAT)
      agency: $scope.agency
      info_type: $scope.info_types[0].value
  else
    Marker.get({id: $state.params.id}).$promise
      .then (data)->
        $scope.marker = data
        $scope.marker.end_date = $scope.marker.end_date.formatDate() if !!$scope.marker.end_date
        $scope.marker.created_at = $scope.marker.created_at.formatDate() if !!$scope.marker.created_at

  $scope.submit =(form)->
    form.$submitted = true
    if form.$valid
      evalAction()
    else
      $.growl.error {message: MESSAGES.FORM_ERROR}

  $scope.submitDestroy =  ->
    swal DELETE_WARNING, ->
      destroy()

  evalAction = ->
    $scope.marker.place = $('#place').val()
    if !!$scope.marker.id
      update()
    else
      create()

  destroy = ->
    Marker.remove({id: $scope.marker.id}).$promise
      .then (data) ->
        $.growl.notice {message: MESSAGES.DELETE_SUCCESS}
        $state.go("admin.#{$scope.agency_scope}.index")

  create =(obj)->
    Marker.save(marker: $scope.marker).$promise
      .then (data) ->
        $.growl.notice {message: MESSAGES.CREATE_SUCCESS}
        $state.go("admin.#{$scope.agency_scope}.index")
      .finally ->
        $scope.uiState.submit = false

  update = ->
    Marker.update({id: $scope.marker.id}, marker: $scope.marker).$promise
      .then (data) ->
        $.growl.notice {message: MESSAGES.UPDATE_SUCCESS}
        $state.go("admin.#{$scope.agency_scope}.index")
      .finally ->
        $scope.uiState.submit = false


Ctrl.$inject = ['$scope','$state','$timeout','$rootScope','Marker']
angular.module('client').controller('AdminFormMarkersCtrl', Ctrl)
