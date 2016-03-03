angular.module('client').config [
  '$stateProvider',
  ($stateProvider) ->

    $stateProvider
      .state 'admin.login',
        url: '/login',
        controller: 'AdminLoginCtrl',
        templateUrl: 'modules/admin_login/index.html'
        data:
          unauthenticated: true

]
