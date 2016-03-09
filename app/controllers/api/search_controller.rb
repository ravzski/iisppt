class Api::SearchController < ApiController

  def index
    render json: Gmap::MetaData.new(params.merge({user_id: current_user.id})).build
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
