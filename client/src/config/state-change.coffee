angular.module('client').run [
  '$rootScope','$location','$state','$window','$http','Session','User', ($rootScope,$location,$state,$window,$http,Session,User) ->

    # authenticator flag serves as
    # a flagger if on state change, the token is still valid
    $rootScope.authenticatorFlag = true
    $rootScope.toggleModal =(state)->
      if state == 'login'
        $rootScope.loginModal = true
        $rootScope.registerModal = false
      else
        $rootScope.loginModal = false
        $rootScope.registerModal = true

    $rootScope.toggleHeaderPage =(current)->
      $rootScope.headerPage = current

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
      # this will happen if there is already a cookie
      # and if the user just refreshes the page
      # thus clearing the rootScope.currentUser
      authToken = localStorage.getItem('AuthToken')
      userId = localStorage.getItem('UserId')
      $rootScope.userOptions = false

      if $rootScope.authenticatorFlag
        event.preventDefault()
        $rootScope.authenticatorFlag = false
        $http.defaults.headers.common.Authorization = authToken
        $http.defaults.headers.common.UserId = userId
        if !!authToken && !!userId
          Session.getCurrentUser().$promise
            .then (data) ->
              $rootScope.currentUser = new User(data)
              evalState toState,toParams
            .catch (err) ->
              unless err.message == "transition prevented"
                $rootScope.authenticatorFlag = true
                localStorage.removeItem('AuthToken')
                localStorage.removeItem('UserId')
        else
          evalState toState,toParams

    # Refactor?
    # this works perfectly though
    evalState =(toState,toParams)->
      if toState.data.admin
        if  (!!$rootScope.currentUser &&  !$rootScope.currentUser.admin) || !$rootScope.currentUser
          $state.go("site.home")
          return
        evalAdmin(toState,toParams)
      else
        evalSite(toState,toParams)

    evalAdmin =(toState,toParams)->
      if !!toState.data.authenticated && !!$rootScope.currentUser &&  !!$rootScope.currentUser.admin
        $state.go(toState.name, toParams)
      else if !!toState.data.unauthenticated && !!$rootScope.currentUser &&  !!$rootScope.currentUser.admin
        $state.go("admin.dashboard")
      else if !!toState.data.unauthenticated && !$rootScope.currentUser
        $state.go(toState.name, toParams)
      else
        $state.go("admin.dashboard")

    evalSite =(toState,toParams)->
      if !!toState.data.authenticated && !!$rootScope.currentUser
        $state.go(toState.name, toParams)
      else if !!toState.data.unauthenticated && !!$rootScope.currentUser
        $state.go("site.home")
      else if !!toState.data.unauthenticated && !$rootScope.currentUser
        $state.go(toState.name, toParams)
      else
        $state.go("site.home")

    # resets the authenticator flag
    # so that it will go authentication on every state change (if state is authenticable)
    $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
      $rootScope.authenticatorFlag = true

]
