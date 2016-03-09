module = angular.module("SiteHeader", [])


module.directive 'siteHeader', [
  '$location','$rootScope'
  ($location,$rootScope) ->

    restrict: 'A'
    replace: true
    templateUrl: 'modules/site_header/template.html'

    link: ($scope, $element, $attrs) ->
      $scope.location = $location

      $scope.toggleSubMenu = ->
        $rootScope.userOptions = !$rootScope.userOptions

      $scope.toggleMenu =(section) ->
        $scope.activeRootUrl =
          if $scope.activeRootUrl == section
            $scope.activeRootUrl = ''
          else
            $scope.activeRootUrl = section
]
