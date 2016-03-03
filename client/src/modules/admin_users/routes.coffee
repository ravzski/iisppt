angular.module('client').config [
  '$stateProvider',
  ($stateProvider) ->

    $stateProvider
      .state 'admin.users',
        url: '/users',
        controller: 'AdminUsersCtrl',
        templateUrl: 'modules/admin_users/index.html'


]
