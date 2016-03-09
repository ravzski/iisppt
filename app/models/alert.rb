class Alert < ActiveRecord::Base
  include Searchable
  include CommonScopes

    def self.complete_details
      select("alerts.*,
      CONCAT_WS(' ',users.first_name ,users.last_name) as creator_name").
      joins("inner join users on users.id = #{self.table_name}.creator_id")
    end

end
