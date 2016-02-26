Ctrl = ($scope)->

  $scope.query =
    from: ""
    to: ""
    date: moment().format(DATE_FORMAT)
    time: ""
    departure: true
    arrival: false


  # move this to a directive some other time
  $('.bg-slideshow').backstretch [
    '/images/slide2.jpg'
    '/images/slide3.jpg'
  ],{duration: 3000, fade: 750}

Ctrl.$inject = ['$scope']
angular.module('client').controller('HomeCtrl', Ctrl)
