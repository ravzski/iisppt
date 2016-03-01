module Gmap
  class Directions < Base

    def build
     @gmaps.directions(
        "Manila, NCR, Philippines",
         "Ortigas Center, Pasig, NCR, Philippines",
        mode: 'transit',
        transit_mode: get_transit_mode,
        alternatives: true,
        )
    end

    private

    def get_transit_mode
      modes = ["bus","rail"]
      modes.delete("bus") unless @bus.present?
      modes.join("|")
    end

  end
end
