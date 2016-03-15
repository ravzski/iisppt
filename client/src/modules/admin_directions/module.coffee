module = angular.module("AdminDirections", [])



module.directive "newLegForm", ->
  restrict: "A"
  replace: true
  templateUrl: 'modules/admin_directions/new_leg_form.html'
  #
  # link: ($scope, element, attrs) ->
  #   $scope.newLeg = {}
  #   $scope.facility_types = FACILITY_TYPES
  #   $scope.facility_types.push({label: "Walk", value: "Walk"})
  #   $scope.new_leg =
  #     transporation: $scope.facility_types[0].value
