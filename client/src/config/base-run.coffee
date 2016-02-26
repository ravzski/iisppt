angular.module('client').run [
  '$rootScope','$state',($rootScope,$state) ->
    $rootScope.clearSession = ->
      localStorage.removeItem("AuthToken")
      localStorage.removeItem("UserId")
      $rootScope.currentUser = null


]
