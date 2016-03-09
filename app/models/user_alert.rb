class UserAlert < ActiveRecord::Base
  include Searchable
  include CommonScopes

  def self.full_details facility_type, facility_name
    select("users.mobile_number").from("users, user_alerts").
    where("users.id = user_alerts.user_id").
    where("user_alerts.facility_type = ?", facility_type).
    where("user_alerts.facility_name = ?", facility_name).
    where("users.mobile_number is not null").
    where("users.is_active")
  end

end
