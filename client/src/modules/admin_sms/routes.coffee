angular.module('client').config [
  '$stateProvider',
  ($stateProvider) ->

    $stateProvider
      .state 'admin.sms',
        url: '/sms',
        controller: 'AdminSmsCtrl',
        templateUrl: 'modules/admin_sms/index.html'


]
