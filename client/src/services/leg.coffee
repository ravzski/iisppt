module = ($resource)->

  Marker = $resource "/api/legs/:id", {id: '@id'},
    {
      index:
        method: 'GET'
        isArray: false
      getList:
        method: 'GET'
        isArray: false
      update:
        method: 'PATCH'
    }

  Marker



module.$inject = ['$resource']
angular.module('client').factory('Leg', module)
