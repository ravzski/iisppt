class Api::RouteRatingsController < ApiController

  before_action :find_obj, only: :create

  def index
    render json: Ratings::Builder.new(params).build
  end

  def create
    if @obj.update_attributes(rating: params[:rating], comment: params[:comment])
      render_empty_success
    else
      render_obj_errors
    end
  end

  private


  def find_obj
    @obj = RouteRating.where_location(params.merge({user_id: current_user.id})).first_or_create
  end

end
