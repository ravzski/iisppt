module = angular.module("Tooltip", [])

module.directive 'ngTooltip', ->
  (scope, element, attrs) ->
    element.on 'mouseenter', ->
      angular.element(element.querySelectorAll('.tooltip')[0]).addClass 'show'

    element.on 'mouseleave', ->
      angular.element(element.querySelectorAll('.tooltip')[0]).removeClass 'show'
