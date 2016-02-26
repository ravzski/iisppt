angular.module('client').config [
  '$stateProvider',
  ($stateProvider) ->

    $stateProvider
      .state 'site.home',
        url: '',
        controller: 'HomeCtrl',
        templateUrl: 'modules/home/index.html'

]
