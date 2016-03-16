class Leg < ActiveRecord::Base
  include Searchable
  include CommonScopes

  attr_accessor :markers

  belongs_to :direction

  before_save :set_defaults
  before_save :set_direction_transport

  private

  def set_direction_transport
    transporations =
      if self.direction.transporations.present?
        self.direction.transporations.split(",")
      else
        []
      end
    transporations.push self.transporation unless transporations.include?(self.transporation)
    self.direction.update_attribute(:transporations,transporations.join(","))
  end

  def set_defaults
    self.duration = 0 unless self.duration.present?
    self.fare = 0 unless self.duration.present?
  end

end
