module = angular.module("Profile", [])


module.directive "profileForm", ->
  restrict: "A"
  replace: true
  templateUrl: 'modules/profile/personal_form.html'


module.directive "settingsForm", ->
  restrict: "A"
  replace: true
  templateUrl: 'modules/profile/settings_form.html'


module.directive "notificationsForm", ->
  restrict: "A"
  replace: true
  templateUrl: 'modules/profile/notifications_form.html'
