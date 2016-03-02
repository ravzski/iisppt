module = angular.module("Login", [])

module.directive 'loginModal', ->
  restrict: 'A'
  replace: true
  controller: "LoginCtrl"
  templateUrl: 'modules/login/template.html'


Ctrl = ($scope,$state,Gmap,$http,$rootScope)->


Ctrl.$inject = ['$scope','$state','Gmap','$http','$rootScope']
angular.module('Login').controller('LoginCtrl', Ctrl)
