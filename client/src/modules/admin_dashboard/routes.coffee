angular.module('client').config [
  '$stateProvider',
  ($stateProvider) ->

    $stateProvider
      .state 'admin.dashboard',
        url: '',
        controller: 'AdminDashboardCtrl',
        templateUrl: 'modules/admin_dashboard/index.html'

]
