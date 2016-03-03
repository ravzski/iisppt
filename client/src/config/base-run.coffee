angular.module('client').run [
  '$rootScope','$state','Session',($rootScope,$state,Session) ->

    $rootScope.logout = () ->
      Session.logout().$promise.then (success) ->
        $rootScope.clearSession()
        $.growl.notice {message: MESSAGES.LOGOUT_SUCCESS}
        $state.go("site.home")


    $rootScope.clearSession = ->
      localStorage.removeItem("AuthToken")
      localStorage.removeItem("UserId")
      $rootScope.currentUser = null


]
