module = angular.module("DatePicker", [])

module.directive 'datePicker', ->
  scope:
    dateFormat: "="
    isDisabled: "="
  link: ($scope, element, attrs) ->
    new Pikaday
      field: element[0]
      format: if $scope.dateFormat then $scope.dateFormat else DATE_FORMAT

    element.addClass('disabled') if !!$scope.isDisabled
