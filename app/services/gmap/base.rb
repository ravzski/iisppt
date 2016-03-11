require 'google_maps_service'

module Gmap
  class Base

    def initialize params
      params.each do |k,v|
        instance_variable_set(:"@#{k}", v)
      end
      @lat_offset = 0
      @lng_offset =  0
      @gmaps = GoogleMapsService::Client.new(key: GMAP_API)
    end

  end
end
