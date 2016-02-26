#
# Authenticated requests
#
[:get, :patch, :put, :post, :delete].each do |method|

  define_method "auth_#{method}" do |path, *args|
    params = args[0]
    headers = args[1] || {}
    current_user.ensure_authentication_token
    #user_id = current_user.id
    send(method, path, params, headers.merge(AuthToken: current_user.auth_token))
  end

end