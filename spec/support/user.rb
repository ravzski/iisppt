def current_user
  @user ||= User.create(first_name: "test firstname", last_name: "test lastname", email: "test@test.com", password: "password")
end