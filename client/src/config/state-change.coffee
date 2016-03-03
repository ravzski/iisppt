angular.module('client').run [
  '$rootScope','$location','$state','$window','$http','Session','User', ($rootScope,$location,$state,$window,$http,Session,User) ->

    # authenticator flag serves as
    # a flagger if on state change, the token is still valid
    $rootScope.authenticatorFlag = true
    $rootScope.polling = false


    $rootScope.toggleModal =(state)->
      if state == 'login'
        $rootScope.loginModal = true
        $rootScope.registerModal = false
      else
        $rootScope.loginModal = false
        $rootScope.registerModal = true

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->



]
