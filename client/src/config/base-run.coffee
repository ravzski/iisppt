angular.module('client').run [
  '$rootScope','$state','Session','$http',($rootScope,$state,Session,$http) ->

    $rootScope.siteLogout = () ->
      authToken = localStorage.getItem('AuthToken')
      userId = localStorage.getItem('UserId')
      $http.defaults.headers.common.Authorization = authToken
      $http.defaults.headers.common.UserId = userId
      Session.logout().$promise.then (success) ->
        $rootScope.clearSession()
        $.growl.notice {message: MESSAGES.LOGOUT_SUCCESS}
        $state.go("site.home")


    $rootScope.clearSession = ->
      localStorage.removeItem("AuthToken")
      localStorage.removeItem("UserId")
      $rootScope.currentUser = null


]
