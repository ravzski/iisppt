angular.module('client').config [
  '$stateProvider',
  ($stateProvider) ->

    $stateProvider
      .state 'site.result',
        url: 'result?destination&origin',
        controller: 'ResultCtrl',
        templateUrl: 'modules/result/index.html'

]
