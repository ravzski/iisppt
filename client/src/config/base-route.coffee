angular.module('client').config [
  '$locationProvider', '$urlRouterProvider',
  ($locationProvider, $urlRouterProvider) ->

    $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise('/')

]
