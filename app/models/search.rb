class Search < ActiveRecord::Base
  include Searchable
  include CommonScopes

end
