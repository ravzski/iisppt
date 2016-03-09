module = ($resource)->

  Alert = $resource "/api/alerts/", null,
    {
      index:
        method: 'GET'
        isArray: false
      getList:
        method: 'GET'
        isArray: false
      update:
        method: 'PATCH'
      search:
        method: 'GET'
        isArray: true
        url: "/api/users/search"
    }
  Alert



module.$inject = ['$resource']
angular.module('client').factory('Alert', module)
