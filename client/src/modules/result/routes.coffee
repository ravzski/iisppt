angular.module('client').config [
  '$stateProvider',
  ($stateProvider) ->

    $stateProvider
      .state 'site.result',
        url: 'result?from&to&departure_time&bus&rail&time&via',
        controller: 'ResultCtrl',
        templateUrl: 'modules/result/index.html'

]
