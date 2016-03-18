module = angular.module("StaticPages", [])

module.directive "staticFare", ->
  restrict: "A"
  replace: true
  templateUrl: 'modules/home/fares.html'

module.directive "staticAbout", ->
  restrict: "A"
  replace: true
  templateUrl: 'modules/home/about.html'

module.directive "staticContact", ->
  restrict: "A"
  replace: true
  templateUrl: 'modules/home/contact.html'
