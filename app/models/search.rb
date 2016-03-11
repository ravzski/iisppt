class Search < ActiveRecord::Base
  include Searchable
  include CommonScopes

  def self.complete_details
    select("count(id) as total_count,searches.place, searches.orientation, searches.lng, searches.lat").
    group("searches.orientation, searches.lat, searches.lng, searches.place").order("total_count DESC")
  end
end
