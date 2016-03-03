module = angular.module("AdminSidebar", [])


module.directive 'adminSidebar', ->
  restrict: 'A'
  replace: true
  templateUrl: 'modules/admin_sidebar/template.html'
