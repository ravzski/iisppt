class Api::SearchController < ApiController

  def index
    render json: Gmap::Directions.new(a).build
  end

end
