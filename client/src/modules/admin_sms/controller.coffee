Ctrl = ($scope,$http,$timeout,$rootScope,Alert)->

  $scope.query =
    first_name: ""
    last_name: ""
    email: ""

  $scope.uiState =
    pagination: false
    page: 1
    modal: false

  $scope.facility_types = FACILITY_TYPES
  $scope.facility_names = TRAIN_FACILITIES

  Alert.getList(query: $scope.query, page: $scope.uiState.page).$promise
    .then (data)->
      processData(data)

  processData =(data)->
    NProgress.done()
    $scope.collection = data.collection
    $scope.metadata = data.metadata
    $scope.uiState.pagination  = if $scope.metadata.count > DEFAULT_PER_PAGE then true else false

  $scope.changeFacility = ->
    $scope.facility_names =
      if $scope.alert.facility_types == 'Train'
        TRAIN_FACILITIES
      else
        BUS_FACILITIES
    $scope.alert.facility_name = $scope.facility_names[0].value

  $scope.toggleForm =(obj)->
    $scope.uiState.modal = !$scope.uiState.modal
    $scope.alert =
      facility_type: FACILITY_TYPES[0].value
      facility_name: TRAIN_FACILITIES[0].value
    $scope.facility_names = TRAIN_FACILITIES

  $scope.submit =(form)->
    form.$submitted = true
    if form.$valid
      evalAction()
    else
      $.growl.error {message: MESSAGES.FORM_ERROR}

  $scope.submitDestroy =(obj) ->
    swal DELETE_WARNING, ->
      destroy(obj)

  # evalAction = ->
  #   if $scope.obj.id
  #     update($scope.obj,$scope.currentIndex)
  #   else
  #     create($scope.obj)
  #
  # destroy =(obj) ->
  #   Alert.remove({id: obj.id}).$promise
  #     .then (data) ->
  #       $.growl.notice {message: MESSAGES.DELETE_SUCCESS}
  #       $scope.collection.splice($scope.collection.indexOf(obj),1)

  $scope.create =(form)->
    form.$submitted = true
    if form.$valid
      $scope.alert.creator_name = $rootScope.currentUser.fullName()
      $scope.collection.unshift $scope.alert
      Alert.save(alert: $scope.alert).$promise
      $.growl.notice {message: MESSAGES.CREATE_SUCCESS}
      $scope.uiState.modal = false
  
  # update =(obj,index)->
  #   Alert.update({id: obj.id}, Alert: obj).$promise
  #     .then (data) ->
  #       $scope.collection[index] = data
  #       $.growl.notice {message: MESSAGES.UPDATE_SUCCESS}
  #       $scope.uiState.modal = false
  #     .finally ->
  #       $scope.uiState.submit = false


Ctrl.$inject = ['$scope','$http','$timeout','$rootScope','Alert']
angular.module('client').controller('AdminSmsCtrl', Ctrl)
