class Api::UserAlertsController < ApiController



  def create
    UserAlert.where(user_id: current_user.id).delete_all
    alerts = []
    params[:alerts].each do |obj|
      alerts.push(UserAlert.new(facility_type: obj[:facility_type], facility_name: obj[:facility_name], user_id: current_user.id))
    end
    UserAlert.import alerts
    render_empty_success
  end


end
