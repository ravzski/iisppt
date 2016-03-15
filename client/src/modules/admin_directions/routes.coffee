angular.module('client').config [
  '$stateProvider',
  ($stateProvider) ->

    $stateProvider
      .state 'admin.directions',
        url: '/directions',
        abstract: true
        template: '<div ui-view=""></div>'


    $stateProvider
      .state 'admin.directions.index',
        url: '',
        controller: 'AdminDirectionsCtrl',
        templateUrl: 'modules/admin_directions/index.html'

    $stateProvider
      .state 'admin.directions.form',
        url: '/form?from&to&from_lat&from_lng&to_lat&to_lng',
        controller: 'AdminDirectionsFormCtrl'
        templateUrl: 'modules/admin_directions/form.html'

]
