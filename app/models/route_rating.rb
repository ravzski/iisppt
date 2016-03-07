class RouteRating < ActiveRecord::Base
  include Searchable
  include CommonScopes

  def self.where_location params
    where(from_place: params[:from]).
    where(to_place: params[:to]).
    where(route_index: params[:route_index]).
    where(user_id: params[:user_id])
  end

  def self.average_rating params
    select("sum(rating) as ratings_sum, count(id) as ratings_count, route_index").
    where("from_place = ? and to_place = ?", params[:from], params[:to]).group("route_index")
  end

end
