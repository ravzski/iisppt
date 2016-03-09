Ctrl = ($scope,$rootScope,User,$http,$state)->

  $state.go("site.home") unless !!$rootScope.currentUser

  $scope.updateForm = {}
  $scope.settingsForm = {}
  $scope.password = {}

  $rootScope.userOptions = false
  $scope.uiState =
    state: "personal"

  $scope.changeState =(state)->
    $scope.uiState.state = state

  $scope.update =(form)->
    form.$submitted = true
    unless form.$valid
      $.growl.error {message: MESSAGES.FORM_ERROR}
      return
    User.update({id: $rootScope.currentUser},user: $rootScope.currentUser).$promise
    $.growl.notice {message: MESSAGES.UPDATE_SUCCESS}

  $scope.deactive = ->
    User.update({id: $rootScope.currentUser},user: {is_active: false})
    $.growl.notice {message: MESSAGES.UPDATE_SUCCESS}
    $rootScope.logout()

  $scope.changePassword =(form)->
    form.$submitted = true
    unless form.$valid
      $.growl.error {message: MESSAGES.FORM_ERROR}
      return
    if $scope.password.new == $scope.password.confirm
      User.update({id: $rootScope.currentUser},user: {password: $scope.password.new})
      $.growl.notice {message: MESSAGES.UPDATE_SUCCESS}
      $rootScope.logout()
    else
      $.growl.error {message: MESSAGES.PASSWORD_NOT_MATCH}

Ctrl.$inject = ['$scope','$rootScope','User','$http','$state']
angular.module('client').controller('ProfileCtrl', Ctrl)
