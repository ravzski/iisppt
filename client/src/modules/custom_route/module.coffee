module = angular.module("CustomRoute", [])

module.directive "customRoute", ->
  restrict: "A"
  replace: true
  templateUrl: 'modules/custom_route/template.html'
