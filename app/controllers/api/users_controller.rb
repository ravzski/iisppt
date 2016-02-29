class Api::UsersController < ApiController

  skip_before_action :authenticate_request, only: %w(create)
  before_action :find_obj, except: [:index, :create]

  private
  
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
