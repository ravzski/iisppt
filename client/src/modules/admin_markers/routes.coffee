angular.module('client').config [
  '$stateProvider',
  ($stateProvider) ->

    $stateProvider
      .state 'admin.pnp',
        url: '/pnp',
        abstract: true
        template: '<div ui-view=""></div>'
        data:
          agency: "PNP"


    $stateProvider
      .state 'admin.pnp.index',
        url: '',
        controller: 'AdminMarkersCtrl',
        templateUrl: 'modules/admin_markers/index.html'

    $stateProvider
      .state 'admin.pnp.new',
        url: '/new',
        controller: 'AdminFormMarkersCtrl',
        template: '<div marker-form=""></div>'

    $stateProvider
      .state 'admin.pnp.edit',
        url: '/:id/edit',
        controller: 'AdminFormMarkersCtrl',
        template: '<div marker-form=""></div>'


    $stateProvider
      .state 'admin.mmda',
        url: '/mmda',
        abstract: true
        template: '<div ui-view=""></div>'
        data:
          agency: "MMDA"


    $stateProvider
      .state 'admin.mmda.index',
        url: '',
        controller: 'AdminMarkersCtrl',
        templateUrl: 'modules/admin_markers/index.html'

    $stateProvider
      .state 'admin.mmda.new',
        url: '/new',
        controller: 'AdminFormMarkersCtrl',
        template: '<div marker-form=""></div>'

    $stateProvider
      .state 'admin.mmda.edit',
        url: '/:id/edit',
        controller: 'AdminFormMarkersCtrl',
        template: '<div marker-form=""></div>'


    $stateProvider
      .state 'admin.dot',
        url: '/dot',
        abstract: true
        template: '<div ui-view=""></div>'
        data:
          agency: "DOT"


    $stateProvider
      .state 'admin.dot.index',
        url: '',
        controller: 'AdminMarkersCtrl',
        templateUrl: 'modules/admin_markers/index.html'

    $stateProvider
      .state 'admin.dot.new',
        url: '/new',
        controller: 'AdminFormMarkersCtrl',
        template: '<div marker-form=""></div>'

    $stateProvider
      .state 'admin.dot.edit',
        url: '/:id/edit',
        controller: 'AdminFormMarkersCtrl',
        template: '<div marker-form=""></div>'
]
