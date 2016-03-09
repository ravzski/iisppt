Ctrl = ($scope,$rootScope,User,$http,$state)->

  $state.go("site.home") unless !!$rootScope.currentUser

  $scope.updateForm = {}
  $scope.settingsForm = {}
  $scope.password = {}
  $scope.train = {}
  $scope.bus = {}
  $scope.alerts = []

  $rootScope.userOptions = false
  $scope.uiState =
    state: "personal"

  $scope.changeState =(state)->
    $scope.uiState.state = state
    if state == 'notifications'
      User.get({id: $rootScope.currentUser.id}).$promise
        .then (data)->
          $scope.alerts = data.alerts

  $scope.update =(form)->
    form.$submitted = true
    unless form.$valid
      $.growl.error {message: MESSAGES.FORM_ERROR}
      return
    User.update({id: $rootScope.currentUser.id},user: $rootScope.currentUser).$promise
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
      User.update({id: $rootScope.currentUser.id},user: {password: $scope.password.new})
      $.growl.notice {message: MESSAGES.UPDATE_SUCCESS}
      $rootScope.logout()
    else
      $.growl.error {message: MESSAGES.PASSWORD_NOT_MATCH}

  $scope.updateNotif =(type,name)->
    existing = false

    for obj,i in $scope.alerts
      if obj.facility_type == type && obj.facility_name == name
        $scope.alerts.splice(i,1)
        existing = true
        break
        return
    if !existing
      $scope.alerts.push {facility_type: type, facility_name: name}

  $scope.isAlertExisiting =(type,name)->
    bol = false
    for obj,i in $scope.alerts
      if obj.facility_type == type && obj.facility_name == name
        bol = true
        break
    bol

  $scope.saveNotifs = ->
    User.updateAlerts(alerts: $scope.alerts).$promise
    $.growl.notice {message: MESSAGES.UPDATE_SUCCESS}

Ctrl.$inject = ['$scope','$rootScope','User','$http','$state']
angular.module('client').controller('ProfileCtrl', Ctrl)
