module = ($resource)->

  Session = $resource "/api/session", null,
    {

      register:
        url: "/api/register"
        method: 'POST'

      login:
        method: 'POST'

      getCurrentUser:
        method: 'GET'
        isArray: false

      logout:
        method: 'DELETE'
    }

  Session



module.$inject = ['$resource']
angular.module('client').factory('Session', module)
