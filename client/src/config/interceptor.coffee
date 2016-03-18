angular.module('client').factory('httpInterceptor', [
  '$q','$rootScope','$injector',
  ($q, $rootScope,$injector) ->
    {
      responseError: (response) ->
        title = response.data.message or 'Oops!'
        message = response.data.error or response.data.errors?.join("<br><br>") or 'Something went wrong'
        switch response.status
          when 403
            $.growl.error {message: message}
          when 401
            $.growl.error {message: message}
            $rootScope.clearSession()
            $injector.get('$state').go("site.home")
          when 500,422
            $.growl.error {message: message}

        $q.reject(response)

    }

]).config [
  '$httpProvider'
  ($httpProvider) ->
    $httpProvider.interceptors.push('httpInterceptor')
]
