Ctrl = ($scope,$state,$timeout,$rootScope,Direction)->

  $scope.uiState =
    pagination: false
    page: 1
    modal: false

  Direction.getList(query: $scope.query, page: $scope.uiState.page).$promise
    .then (data)->
      processData(data)

  processData =(data)->
    NProgress.done()
    $scope.collection = data.collection
    $scope.metadata = data.metadata
    $scope.uiState.pagination  = if $scope.metadata.count > DEFAULT_PER_PAGE then true else false

  $scope.submitDestroy =(obj) ->
    swal DELETE_WARNING, ->
      destroy(obj)


Ctrl.$inject = ['$scope','$state','$timeout','$rootScope','Direction']
angular.module('client').controller('AdminDirectionsCtrl', Ctrl)
