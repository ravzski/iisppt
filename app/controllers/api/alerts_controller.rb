class Api::AlertsController < ApiController

  before_action :validate_admin, except: [:show]
  before_action :find_obj, except: [:index, :create]

  def index
    @collection = Alert.complete_details.page(current_page)
    render_collection
  end

  def show
    render json: @obj
  end

  def create
    @obj = Alert.new obj_params.merge(creator_id: current_user.id)
    if @obj.save
      render json: @obj
    else
      render_obj_errors
    end
  end
  #
  # def update
  #   if @obj.update_attributes obj_params.merge(updator_id: current_user.id)
  #     render json: @obj
  #   else
  #     render_obj_errors
  #   end
  # end
  #
  # def destroy
  #   render_empty_success unless current_user.admin
  #   if @obj.destroy
  #     render_empty_success
  #   else
  #     render_obj_errors
  #   end
  # end


  private

  def obj_params
    params.require(:alert).permit(*%i(
      facility_name
      facility_type
      event
      place
    ))
  end

  def find_obj
    @obj = Alert.find(params[:id])
  end

end
