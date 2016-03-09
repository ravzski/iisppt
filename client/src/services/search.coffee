module = ($resource)->

  Search = $resource "/api/searches/", null,
    {

    }

  Search



module.$inject = ['$resource']
angular.module('client').factory('Search', module)
