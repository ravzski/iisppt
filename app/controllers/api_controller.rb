class ApiController < ActionController::Base
  include Authenticator
  include MetadataBuilder
  include CommonActions
  include CommonResponse

  protect_from_forgery with: :null_session
  before_action :authenticate_request

end
