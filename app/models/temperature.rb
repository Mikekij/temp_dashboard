class Temperature < ApplicationRecord
  belongs_to :thermometer

  def temperature_f
    temperature_f = (self.temperature_c * 1.8) + 32
    return temperature_f
  end

end
