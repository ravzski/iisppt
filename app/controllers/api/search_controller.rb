class Api::SearchController < ApiController

  def index
    render json: Gmap::MetaData.new(params).build
  end

end
