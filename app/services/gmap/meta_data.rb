module Gmap
  class MetaData < Base

    def build
      result= {collection: [], rating: nil}
      collection = []
      existing_ids = []

      @lng.each_with_index do |lng,index|
        lat = @lat[index]
        markers = Marker.search_by_location(lat, lng, existing_ids).group_by(&:info_type).each do |info_type,markers|
          temp = {info_type: info_type, events: [], step_index: index}
          markers.each do |obj|
            existing_ids.push obj.id
            temp[:events].push metadata_details(obj)
          end
          result[:collection].push temp
        end
      end
      result[:rating] = user_rating.present? ? user_rating.rating : 0
      result
    end

    private

    def user_rating
      @user_rating ||= RouteRating.where_location(route_rating_params).first
    end

    def route_rating_params
      {
        from: @from,
        to: @to,
        route_index: @route_index,
        user_id: @user_id
      }
    end

    def metadata_details obj
      {
        info_type: obj.info_type,
        place: obj.place,
        agency: obj.agency,
        description: obj.description,
        created_at: obj.created_at
      }
    end


  end
end
