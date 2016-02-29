angular.module('client').config [
  '$stateProvider',
  ($stateProvider) ->

    $stateProvider
      .state 'site.result',
        url: 'result?destination&origin&departure_time&bus',
        controller: 'ResultCtrl',
        templateUrl: 'modules/result/index.html'

]
