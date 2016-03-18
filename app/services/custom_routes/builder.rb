module CustomRoutes
  class Builder

    def initialize direction_id
      @direction_id = direction_id
    end

    def build
      collection = []
      existing_ids = []
      legs.each_with_index do |leg,index|
        leg.markers = []
        @lat_offset = 0
        @lng_offset =  0
        markers = Marker.search_by_location(leg.lat, leg.lng, existing_ids).group_by(&:info_type).each do |info_type,markers|
          temp = {info_type: info_type, events: [], step_index: index}
          markers.each do |obj|
            @lat_offset += 0.0001
            @lng_offset += 0.0001
            existing_ids.push obj.id

            temp[:events].push metadata_details(obj)
          end
          leg.markers.push temp
        end
        collection.push details(leg)
      end
      {legs: collection}
    end

    private

    def metadata_details obj
      {
        info_type: obj.info_type,
        place: obj.place,
        agency: obj.agency,
        description: obj.description,
        created_at: obj.created_at,
        lat: obj.lat+@lat_offset,
        lng: obj.lng+@lng_offset
      }
    end

    def details leg
      {
        duration: leg.duration,
        fare: leg.fare,
        instructions: leg.instructions,
        lat: leg.lat,
        lng: leg.lng,
        transporation: leg.transporation,
        place: leg.place,
        markers: leg.markers
      }
    end

    def legs
      @legs ||= Leg.where(direction_id: @direction_id)
    end

  end

end
