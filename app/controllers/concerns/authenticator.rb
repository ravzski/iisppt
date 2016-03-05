module Authenticator
  extend ActiveSupport::Concern

  def validate_admin
    render_access_denied unless current_user.admin
  end

  def current_user
    @current_user ||= User.find_by_valid_token request_details
  end

  def request_details
    @request_details ||=
      {
        access_token:  request.headers['Authorization'] || params[:access_token],
        user_id: request.headers['UserId'] || params[:user_id]
      }
  end

  def authenticate_request
    render_expired_session unless current_user.present?
  end

  def render_expired_session
    render json: { error: 'Your session has expired' }, status: 401
  end

  def render_access_denied
    render json: { error: 'Access Denied' }, status: 403
  end

end
