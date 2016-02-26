angular.module("client").directive 'ngNumeric', ->
  {
    restrict: 'A'
    require: 'ngModel'
    scope: ngModel: '='
    link: (scope) ->
      scope.$watch 'ngModel', (newValue, oldValue) ->
        arr = String(newValue).split('')

        newValue = "" if newValue is undefined

        if arr.length == 0
          return
        if arr.length == 1 and (arr[0] == '-' or arr[0] == '.')
          return
        if arr.length == 2 and newValue == '-.'
          return
        if isNaN(newValue)
          scope.ngModel = oldValue
        return
      return

  }
