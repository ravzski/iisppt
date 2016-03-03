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

Ctrl = ($scope,$state,Gmap,$http,$rootScope,Session)->

  $scope.login =(form)->
    form.$submitted = true
    $scope.disabledSubmit = true
    Session.login(credentials: $scope.credentials).$promise
      .then (data) ->
        localStorage.setItem("AuthToken", data.auth_token)
        localStorage.setItem("UserId", data.user_id)
        $.growl.notice {message: MESSAGES.LOGIN_SUCCESS}
      .finally ->
        $scope.disabledSubmit = false

  $scope.toggleRegister = ->
    $rootScope.registerModal = !$rootScope.registerModal

  $scope.toggleLogin = ->
    $rootScope.loginModal = !$rootScope.loginModal

Ctrl.$inject = ['$scope','$state','Gmap','$http','$rootScope','Session']
angular.module('Login').controller('LoginCtrl', Ctrl)
