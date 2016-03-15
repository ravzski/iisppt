class Api::DirectionsController < ApiController

  before_action :validate_admin, only: :create
  before_action :find_obj, except: [:index]

  def index
    @collection = Marker.complete_details.search(query_params).page(current_page)
    render_collection
  end

  def show
    render json: {legs: @obj.legs}
  end

  def create
    @obj = Marker.new obj_params.merge(creator_id: current_user.id, updator_id: current_user.id)
    if @obj.save
      render json: @obj
    else
      render_obj_errors
    end
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
    @obj = Direction.where(from: params[:from], to: params[:to]).first_or_create
  end

end
