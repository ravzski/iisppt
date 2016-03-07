class Api::SearchController < ApiController

  def index
    render json: Gmap::MetaData.new(params.merge({user_id: current_user.id})).build
  end

end
