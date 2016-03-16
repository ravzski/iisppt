class Api::SearchController < ApiController

  def index
    render json:
      {
        gmap_data: Gmap::MetaData.new(eval_params).build,
        custom_data: Direction.complete_details(params)
      }
  end

  private

  def eval_params
    if current_user.present?
      params.merge({user_id: current_user.id})
    else
      params
    end
  end

end
