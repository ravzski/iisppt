angular.module('client').run [
  '$rootScope', ($rootScope) ->

    $rootScope.startLoading = ->
      NProgress.start()
      $rootScope.loading = true

    $rootScope.stopLoading = ->
      $rootScope.loading = false
      NProgress.done()

]
