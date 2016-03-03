Ctrl = ($scope,$http,$timeout,$rootScope,User)->

  $scope.query =
    first_name: ""
    last_name: ""
    email: ""

  $scope.uiState =
    pagination: false
    page: 1

  User.getList(query: $scope.query, page: $scope.uiState.page).$promise
    .then (data)->
      processData(data)

  processData =(data)->
    NProgress.done()
    $scope.collection = data.collection
    $scope.metadata = data.metadata
    $scope.uiState.pagination  = if $scope.metadata.count > DEFAULT_PER_PAGE then true else false


Ctrl.$inject = ['$scope','$http','$timeout','$rootScope','User']
angular.module('client').controller('AdminUsersCtrl', Ctrl)
