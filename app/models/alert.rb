class Alert < ActiveRecord::Base
  include Searchable
  include CommonScopes

  after_create :send_sms

  def self.complete_details
    select("alerts.*,
    CONCAT_WS(' ',users.first_name ,users.last_name) as creator_name").
    joins("inner join users on users.id = #{self.table_name}.creator_id")
  end

  private

  def send_sms
    Sms::Sender.new(self).send_to_users()
  end

end
