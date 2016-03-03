module User
  class Builder

    def initialize user
      @user = user
    end

    def build
      {
        id: @user.id,
        first_name: @user.first_name,
        last_name: @user.last_name,
        email: @user.email,
        auth_token: @user.auth_token
      }
    end

  end

end
