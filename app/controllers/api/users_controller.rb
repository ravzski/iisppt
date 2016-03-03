class Api::UsersController < ApiController

  skip_before_action :authenticate_request, only: %w(create)
  before_action :find_obj, except: [:index, :create]

  def index
    @collection = User.search(query_params).page(current_page)
    render_collection
  end

  def create
    @obj = User.new obj_params
    if @obj.save
      render json: Sessions::Builder.new(@obj).create
    else
      render_obj_errors
    end
  end


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
