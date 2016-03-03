class Api::SessionsController < ApiController

  skip_before_action :authenticate_request, only: :create

  def show
    if current_user.present?
      render json: Sessions::Builder.new(current_user).show
    else
      render_expired_session
    end
  end

  def create
    user = User.find_by_credentials(params[:credentials])
    if user && user.set_access_token
      render json: Sessions::Builder.new(user).create
    else
      render json: { error: 'Incorrect email or password' }, status: :unauthorized
    end
  end


  def destroy
    if current_user.destroy_token
      render_update_success
    else
      render_obj_errors
    end
  end

end
