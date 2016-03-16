class Leg < ActiveRecord::Base
  include Searchable
  include CommonScopes

  belongs_to :direction

  before_save :set_defaults

  private

  def set_defaults
    self.duration = 0 unless self.duration.present?
    self.fare = 0 unless self.duration.present?
  end

end
