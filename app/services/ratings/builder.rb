module Ratings
  class Builder

    def initialize params
      @params = params
    end

    def build
      collection = []
      current_rating .each do |obj|
        collection.push rating_details(obj)
      end
      collection
    end

    private

    def rating_details obj
      {
        ratings_sum: obj.ratings_sum,
        ratings_count: obj.ratings_count,
        route_index: obj.route_index
      }
    end

    def current_rating
      @current_rating ||= RouteRating.average_rating(@params)
    end

  end

end
