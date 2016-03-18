Ctrl = ($scope, $state, Session,$rootScope)->

  $rootScope.bodyClass = "admin-body"
  $scope.logout = () ->
    Session.logout().$promise.then (success) ->
      $rootScope.clearSession()
      $.growl.notice {message: MESSAGES.LOGOUT_SUCCESS}
      $state.go("site.home")

Ctrl.$inject = ['$scope', '$state', 'Session','$rootScope']
angular.module('client').controller('AdminCtrl', Ctrl)
