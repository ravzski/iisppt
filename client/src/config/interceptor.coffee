angular.module('client').factory('httpInterceptor', [
  '$q','$rootScope','$injector',
  ($q, $rootScope,$injector) ->
    {
      responseError: (response) ->
        title = response.data.message or 'Oops!'
        message = response.data.error or response.data.errors?.join("<br><br>") or 'Something went wrong'
        switch response.status
          when 403
            $rootScope.growl.error  message
            $injector.get('$state').go("admin.dashboard")
          when 401
            $rootScope.growl.error  message
            $rootScope.clearSession()
            $injector.get('$state').go("login")
          when 500,422
            $rootScope.growl.error  message
        $q.reject(response)

    }

]).config [
  '$httpProvider'
  ($httpProvider) ->
    $httpProvider.interceptors.push('httpInterceptor')
]
