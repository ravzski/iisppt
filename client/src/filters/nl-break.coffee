angular.module('client').filter 'breakNewLine', ->
  (text) ->
    if !!text
      text.replace(/\n/g, '<br />')
