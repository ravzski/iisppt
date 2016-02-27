module = angular.module("SearchComponents", [])

module.directive 'mainSearch', ->
  restrict: 'A'
  replace: true
  templateUrl: 'modules/search_components/main_search.html'

module.directive 'expandedSearch', ->
  restrict: 'A'
  replace: true
  templateUrl: 'modules/search_components/expanded_search.html'
