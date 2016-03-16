class Api::LegsController < ApiController

  before_action :validate_admin
  before_action :find_obj, except: [:index, :create]


  def create
    @obj = Leg.new obj_params
    if @obj.save
      render json: @obj
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
    if @obj.destroy
      render_empty_success
    else
      render_obj_errors
    end
  end


  private

  def obj_params
    params.require(:leg).permit(*%i(
      direction_id
      place
      transporation
      fare
      lat
      lng
      instructions
    ))
  end


  def find_obj
    @obj = Leg.find(params[:id])
  end

end
