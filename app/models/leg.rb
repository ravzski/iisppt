class Leg < ActiveRecord::Base
  include Searchable
  include CommonScopes

  belongs_to :direction

end
