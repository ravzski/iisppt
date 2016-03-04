module = angular.module("ActiveSelect", [])

module.directive 'activeSelect', ->
  restrict: 'A'
  replace: true
  templateUrl: 'modules/active_select/template.html'
  scope:
    status: "="
    complete: "="

  link: ($scope, element) ->

    if $scope.complete
      $scope.obj =
        status: ''
      $scope.statusCollection = STATUS_COLLECTION_ALL
    else
      $scope.obj =
        status: if $scope.status then 'true' else 'false'
      $scope.statusCollection = STATUS_COLLECTION


    $scope.updateStatus =(selectedObj)->
      $scope.status =
        switch $scope.obj.status
          when 'true'
            true
          when 'false'
            false
          else
            ''
