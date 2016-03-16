class Direction < ActiveRecord::Base
  include Searchable
  include CommonScopes

  validates :from, presence: true
  validates :to, presence: true

  has_many :legs

  COMPLETE_DETAILS = "
    sum(legs.fare) as sum_fare,
    sum(legs.duration) as sum_duration,
    count(directions_ratings.id) as total_rating,
    sum(directions_ratings.rating) as sum_ratings,
    directions.id,
    directions.transporations
  "

  LEGS_WITH_METADATA = "
    legs.*
  "

  def self.complete_details query
    select(COMPLETE_DETAILS).from("legs, directions").
    joins("left join directions_ratings on directions.id = directions_ratings.direction_id").
    where("directions.id = legs.direction_id").
    filter_by_query(query).group("directions.id")
  end

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
