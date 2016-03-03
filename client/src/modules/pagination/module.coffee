module = angular.module("ngPagination", [])

module.filter 'range', ->
  (input, total) ->
    total = parseInt(total)
    i = 0
    while i < total
      input.push i+1
      i++
    input


module.directive "ngPagination", ->
  restrict: "A"
  replace: true
  templateUrl: 'modules/pagination/template.html'
  scope:
    paginateCount: "="
    paginatePage: "="
    query: "&"

  link: ($scope, element, attrs) ->

    $scope.pageCount = Math.ceil($scope.paginateCount/DEFAULT_PER_PAGE)

    $scope.queryPage =(params)->
      if params == 'prev'
        $scope.paginatePage--
      else if params == 'next'
        $scope.paginatePage++
      else
        $scope.paginatePage = params
      $scope.query()
