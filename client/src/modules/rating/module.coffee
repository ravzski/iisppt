module = angular.module("Rating", [])


module.filter 'range', ->
  (input, total) ->
    total = parseInt(total)
    i = 0
    while i < total
      input.push i+1
      i++
    input

module.directive "routeRating", ->
  restrict: "A"
  replace: true
  templateUrl: 'modules/rating/template.html'
  scope:
    avg: "="
    count: "="
    fare: "="

  link: ($scope, element, attrs) ->
    $scope.max_rating = 5
    if $scope.avg == 0
      $scope.whole_no = 0
    else
      $scope.whole_no = Math.round($scope.avg)
    $scope.floating = $scope.avg%$scope.whole_no

    $scope.totalText = ->
      label = if $scope.count == 1 then "User" else "Users"
      "#{$scope.count} #{label} Rated"

    $scope.getClass =(n)->
      if n == $scope.whole_no && $scope.floating > 0
        "icon-star-half"
      else if $scope.whole_no >= n
        "icon-star-two"
      else
        "icon-star"

module.directive "routeRatingAction",
['$rootScope','Rating'
($rootScope,Rating) ->

  restrict: "A"
  replace: true
  templateUrl: 'modules/rating/action.html'
  scope:
    rating: "="
    from: "="
    to: "="
    index: "="

  link: ($scope, element, attrs) ->
    $scope.max_rating = 5


    $scope.rate =(rating)->
      $rootScope.openRate = true
      if !!$rootScope.currentUser
        $scope.rating = rating
        Rating.save(from: $scope.from, to: $scope.to, route_index: $scope.index, rating: rating).$promise
      else
        $rootScope.toggleModal('login')
        $.growl.error {message: MESSAGES.MUST_BE_LOGGED_IN}

]
