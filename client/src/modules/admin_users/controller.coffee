Ctrl = ($scope,$http,$timeout,$rootScope,User)->

  $scope.query =
    first_name: ""
    last_name: ""
    email: ""

  $scope.uiState =
    pagination: false
    page: 1
    modal: false

  User.getList(query: $scope.query, page: $scope.uiState.page).$promise
    .then (data)->
      processData(data)

  processData =(data)->
    NProgress.done()
    $scope.collection = data.collection
    $scope.metadata = data.metadata
    $scope.uiState.pagination  = if $scope.metadata.count > DEFAULT_PER_PAGE then true else false

  $scope.toggleForm =(obj)->
    if !!obj
      $scope.uiState.modal = true
      $scope.obj = angular.copy obj
      $scope.currentIndex = $scope.collection.indexOf(obj)
    else
      $scope.uiState.modal = false

  $scope.submit =(form)->
    form.$submitted = true
    if form.$valid
      evalAction()
    else
      $.growl.error {message: MESSAGES.FORM_ERROR}

  $scope.submitDestroy =(obj) ->
    swal DELETE_WARNING, ->
      destroy(obj)

  evalAction = ->
    if $scope.obj.id
      update($scope.obj,$scope.currentIndex)
    else
      create($scope.obj)

  destroy =(obj) ->
    User.remove({id: obj.id}).$promise
      .then (data) ->
        $.growl.notice {message: MESSAGES.DELETE_SUCCESS}
        $scope.collection.splice($scope.collection.indexOf(obj),1)

  create =(obj)->
    obj = prepObj(obj)
    User.save(user: obj).$promise
      .then (data) ->
        $scope.collection.unshift data
        $.growl.notice {message: MESSAGES.CREATE_SUCCESS}
        $scope.uiState.modal = false
      .finally ->
        $scope.uiState.submit = false

  update =(obj,index)->
    User.update({id: obj.id}, user: obj).$promise
      .then (data) ->
        $scope.collection[index] = data
        $.growl.notice {message: MESSAGES.UPDATE_SUCCESS}
        $scope.uiState.modal = false
      .finally ->
        $scope.uiState.submit = false


Ctrl.$inject = ['$scope','$http','$timeout','$rootScope','User']
angular.module('client').controller('AdminUsersCtrl', Ctrl)
