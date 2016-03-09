angular.module('client').config [
  '$stateProvider',
  ($stateProvider) ->

    $stateProvider
      .state 'site.profile',
        url: 'profile',
        controller: 'ProfileCtrl',
        templateUrl: 'modules/profile/index.html'
]
