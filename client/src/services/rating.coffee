module = ($resource)->

  Rating = $resource "/api/route_ratings/", null,
    {

    }

  Rating



module.$inject = ['$resource']
angular.module('client').factory('Rating', module)
