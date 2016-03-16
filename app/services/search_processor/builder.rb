module SearchProcessor
  class Builder

    def build
      collection = {from: [], to: []}
      Search.complete_details.group_by(&:orientation).each do |orientation,col|
        if orientation
          collection[:from] = col
        else
          collection[:to] = col
        end
      end
      collection
    end

    def create from_params,to_params,current_user
      searches = []
      searches.push Search.new(from_params)
      searches.push Search.new(to_params)
      searches[0].user_id = current_user.id if current_user.present?
      searches[1].user_id = current_user.id if current_user.present?
      Search.import searches
    end


  end

end
