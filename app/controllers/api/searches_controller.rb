class Api::SearchesController < ApiController

  def index
    render json: Search.complete_details
  end

  def create
    # @obj = Search.new obj_params.merge(user_id: current_user.id)
    searches = []
    searches.push Search.new(from_params)
    searches.push Search.new(to_params)
    searches[0].user_id = current_user.id if current_user.present?
    searches[1].user_id = current_user.id if current_user.present?
    Search.import searches
    render_empty_success
  end

  private

  def from_params
    params.require(:from).permit(*%i(
      lat
      lng
      orientation
      place
    ))
  end

  def to_params
    params.require(:to).permit(*%i(
      lat
      lng
      orientation
      place
    ))
  end

end
