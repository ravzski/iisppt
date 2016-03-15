class Api::DirectionsController < ApiController

  before_action :validate_admin, only: :create
  before_action :find_obj, except: [:index, :create]

  def index
    @collection = Direction.search(query_params).page(current_page)
    render_collection
  end

  def show
    render json: {legs: @obj.legs}
  end

  def create
    @obj = Direction.filter_by_query(params[:direction]).first_or_create
    @obj.set_cords(params[:direction])
    render json: @obj
  end

  def update
    if @obj.update_attributes obj_params.merge(updator_id: current_user.id)
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
    params.require(:marker).permit(*%i(
      lat
      lng
      description
      info_type
      agency
      place
      end_date
    ))
  end

  def find_obj
    @obj = Direction.find(params[:id])
  end

end
