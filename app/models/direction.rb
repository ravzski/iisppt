class Direction < ActiveRecord::Base
  include Searchable
  include CommonScopes

  has_many :legs

end
