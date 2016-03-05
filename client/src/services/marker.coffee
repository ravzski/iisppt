module = ($resource)->

  Marker = $resource "/api/markers/:id", {id: '@id'},
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

  Marker



module.$inject = ['$resource']
angular.module('client').factory('Marker', module)
