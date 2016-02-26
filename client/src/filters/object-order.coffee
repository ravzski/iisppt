angular.module('client').filter 'orderObjectBy', ->
  (input, attribute) ->
    if !angular.isObject(input)
      return input
    array = []
    for objectKey of input
      array.push input[objectKey]
    array.sort (a, b) ->
      a = parseInt(a[attribute])
      b = parseInt(b[attribute])
      a - b
    array
