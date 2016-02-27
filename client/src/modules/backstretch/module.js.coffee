module = angular.module("Backstretch", [])


module.directive 'homeBackstretch', ->
  link: ($scope, element) ->
    $('.bg-slideshow').backstretch [
      '/images/slide2.jpg'
      '/images/slide3.jpg'
    ],{duration: 3000, fade: 750}
