Ctrl = ($scope,$state,Session)->

  NProgress.done()
  $scope.disabledSubmit = false

  $scope.login =(form)->
    form.$submitted = true
    $scope.disabledSubmit = true
    Session.login(credentials: $scope.credentials, timezone: moment().format("Z")).$promise
      .then (data) ->
        localStorage.setItem("AuthToken", data.auth_token)
        localStorage.setItem("UserId", data.user_id)
        localStorage.setItem("SearchApiLink", data.search_api_link)
        $.growl.notice {message: MESSAGES.LOGIN_SUCCESS}
        $state.go(ROOT_PATH)
      .finally ->
        $scope.disabledSubmit = false

Ctrl.$inject = ['$scope','$state','Session']
angular.module('client').controller('AdminLoginCtrl', Ctrl)
