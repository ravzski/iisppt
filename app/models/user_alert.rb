class UserAlert < ActiveRecord::Base
  include Searchable
  include CommonScopes

end
