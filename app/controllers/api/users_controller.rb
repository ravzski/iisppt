class Api::UsersController < ApiController

  skip_before_action :authenticate_request, only: :create
  before_action :validate_admin, except: [:create, :update]
  before_action :find_obj, except: [:index, :create]

  def index
    @collection = User.basic_details.search(query_params).page(current_page)
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

  def update
    if @obj.update_attributes obj_params
      render json: @obj
    else
      render_obj_errors
    end
  end

  def destroy
    render_empty_success unless current_user.admin
    if @obj.destroy
      render_empty_success
    else
      render_obj_errors
    end
  end


  private

  def obj_params
    if current_user.present? && current_user.admin
      params.require(:user).permit(*%i(
        password
        is_active
      ))
    else
      params.require(:user).permit(*%i(
        first_name
        last_name
        email
        password
        mobile_number
        is_active
      ))
    end
  end

  def find_obj
    @obj = User.basic_details.find(params[:id])
    render_empty_success if @obj.id != current_user.id && !current_user.admin
  end

end
