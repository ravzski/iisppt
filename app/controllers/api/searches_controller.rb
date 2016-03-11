class Api::SearchesController < ApiController

  def index
    render json: SearchProcessor::Builder.new.build
  end

  def create
    SearchProcessor::Builder.new.create(from_params,to_params,current_user)
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
