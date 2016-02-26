class Api::UsersController < ApiController

  skip_before_action :authenticate_request, only: %w(create)
  before_action :find_obj, except: [:index, :create]

  def create
    google_user = Oauth::GoogleAuthenticator.new(params).fetch_user
    user = User.find_or_initialize_by(email: google_user[:emails].first["value"])

    user.update(
      access_token: google_user[:access_token],
      first_name:   google_user[:displayName],
      email:        google_user[:emails].first["value"],
      access_token: google_user[:access_token]
    )

    render json: {token: user.access_token, user: user}
  end

  def update
    update_helper
  end

  def index
    render json: {collection: User.all}
  end

  def destroy
    delete_helper
  end

  def obj_params
    params.require(:user).permit(*%i(
      first_name
      last_name
      email
      password
    ))
  end

  def find_obj
    @obj = User.find(params[:id])
  end

end
