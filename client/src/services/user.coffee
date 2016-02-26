module = ($resource)->

  User = $resource "/api/users/:id", {id: '@id'},
    {
      index:
        method: 'GET'
        isArray: false
      getList:
        method: 'GET'
        isArray: false
      update:
        method: 'PATCH'
      search:
        method: 'GET'
        isArray: true
        url: "/api/users/search"
    }

  User::fullName = ->
    "#{this.first_name} #{this.last_name}"

  User::lookUpTitle = ->
    "#{@fullName()} (#{this.email}) - #{@role_name}"

  User::isRequestApprover =(approvers)->
    for obj in approvers
      if obj.user_id == this.id
        return true
        break

  User



module.$inject = ['$resource']
angular.module('client').factory('User', module)
