class Api::SearchesController < ApiController

  def index
    render json: Searches.complete_details
  end

  def create
    @obj = Searches.new obj_params.merge(user_id: current_user.id)
    if @obj.save
      render json: @obj
    else
      render_obj_errors
    end
  end

  private

  def obj_params
    params.require(:search).permit(*%i(
      lat
      lng
      orientation
      place
    ))
  end

end
