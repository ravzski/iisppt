angular.module('client').config [
  '$stateProvider',
  ($stateProvider) ->

    $stateProvider
      .state 'site',
        url: '/',
        abstract: true,
        controller: 'SiteCtrl',
        templateUrl: 'modules/site/layout.html'

]
