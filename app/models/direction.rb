class Direction < ActiveRecord::Base
  include Searchable
  include CommonScopes

  validates :from, presence: true
  validates :to, presence: true

  has_many :legs

  def self.filter_by_query query
    where(from: query[:from]).
    where(to: query[:to])
  end

  def set_cords query
    self.from_lat =  query[:from_lat]
    self.from_lng =  query[:from_lng]
    self.to_lat =  query[:to_lat]
    self.to_lng = query[:to_lng]
    self.save
  end

end
