module = angular.module("Login", [])

module.directive 'authModal', ->
  restrict: 'A'
  replace: true
  controller: "LoginCtrl"
  templateUrl: 'modules/auth_modal/template.html'


module.directive 'loginModal', ->
  restrict: 'A'
  replace: true
  templateUrl: 'modules/auth_modal/login_modal.html'

module.directive 'registerModal', ->
  restrict: 'A'
  replace: true
  templateUrl: 'modules/auth_modal/register_modal.html'

Ctrl = ($scope,$state,$http,$rootScope,Session,User)->

  $scope.user =
    email: ""
    first_name: ""
    password: ""
    last_name: ""

  $scope.login =(form)->
    form.$submitted = true
    $scope.disabledSubmit = true
    Session.login(credentials: $scope.credentials).$promise
      .then (data) ->
        localStorage.setItem("AuthToken", data.auth_token)
        localStorage.setItem("UserId", data.user_id)
        $scope.registerModal = false
        $rooScope.user = data
        $.growl.notice {message: MESSAGES.LOGIN_SUCCESS}
      .finally ->
        $scope.disabledSubmit = false

  $scope.register =(form)->
    form.$submitted = true
    $scope.disabledSubmit = true
    $scope.passwordErr = false
    $scope.emailErr = false

    if !!form.$error.required && form.$error.required.length > 0
      $.growl.error {message: MESSAGES.FORM_ERROR}
      return
    if !!form.$error.email && form.$error.email.length > 0
      $scope.emailErr = true
      $.growl.error {message: MESSAGES.INVALID_EMAIL}
      return
    if $scope.user.password != $scope.user.confirm_password
      $scope.passwordErr = true
      $.growl.error {message: MESSAGES.PASSWORD_NOT_MATCH}
      return


    User.save(user: $scope.user).$promise
      .then (data) ->
        localStorage.setItem("AuthToken", data.auth_token)
        localStorage.setItem("UserId", data.user_id)
        $.growl.notice {message: MESSAGES.LOGIN_SUCCESS}
        $rooScope.user = data
        $scope.registerModal = false
      .finally ->
        $scope.disabledSubmit = false

  $scope.toggleRegister = ->
    $rootScope.registerModal = !$rootScope.registerModal

  $scope.toggleLogin = ->
    $rootScope.loginModal = !$rootScope.loginModal

Ctrl.$inject = ['$scope','$state','$http','$rootScope','Session','User']
angular.module('Login').controller('LoginCtrl', Ctrl)
