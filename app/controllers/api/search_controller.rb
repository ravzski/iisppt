class Api::SearchController < ApiController

  def index
    render json: Gmap::Directions.new(params).build
  end

end
