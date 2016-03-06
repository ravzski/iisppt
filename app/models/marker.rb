class Marker < ActiveRecord::Base
  include Searchable
  include CommonScopes

  def self.metadata location, existing_ids
    where(build_like_query('place',location)).
    filter_out("id",existing_ids).
    where("end_date is null")
  end

  def self.search_by_location lat, lng, existing_ids
    select("*, #{self.build_location_calculation(lat,lng)} as distance").
    where("end_date is null").
    filter_out("id", existing_ids).
    having("distance < .5").order("distance DESC")
  end

  def self.build_location_calculation lat, lng
    sanitize_sql_array(["( 6371
      * acos( cos( radians(?) )
      * cos( radians( lat ) )
      * cos( radians( lng )
      - radians(?) )
      + sin( radians(?) )
      * sin(radians(lat)) ) )",lat,lng,lat])
  end


end
