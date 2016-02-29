require 'google_maps_service'

module Gmap
  class Base

    def initialize params
      params.each do |k,v|
        instance_variable_set(:"@#{k}", v)
      end
      @gmaps = GoogleMapsService::Client.new(key: GMAP_API)
    end

  end
end
