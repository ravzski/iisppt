module = angular.module("Timepicker", [])

module.directive 'timepicker', ->

  link: ($scope, element, attrs) ->
    $(element).timepicker()
    $(element).timepicker('setTime', new Date())
