module = angular.module("AdminMarker", [])

module.directive 'markerForm', ->
  restrict: 'A'
  replace: true
  templateUrl: 'modules/admin_markers/form.html'
