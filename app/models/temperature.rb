class Temperature < ApplicationRecord
  belongs_to :thermometer

  def temperature_f
    temperature_f = (self.temperature_c * 1.8) + 32
    return temperature_f
  end

  def corresponding_temp
    temp_2 = Temperature.where("created_at < ? AND thermometer_id = ?", self.created_at + 1.minute, 2).order(created_at: :desc).first
    return temp_2
  end

  def get_adjacent_temp_range(interval)
    later_temp = Temperature.where("thermometer_id = ? AND created_at > ?", self.id, self.created_at + (interval - 1).minute).order(created_at: :asc).first
    earlier_temp = Temperature.where("thermometer_id = ? AND created_at < ?", self.id, self.created_at - (interval + 1).minute).order(created_at: :desc).first
    if !later_temp.nil? and !earlier_temp.nil?
      return later_temp.temperature_f - earlier_temp.temperature_f
    else
      return nil
    end
  end

  def self.find_slope(outside_temp,inside_temp,inside_temp_range)
    slope = inside_temp_range.to_f / (outside_temp.temperature_f.to_f - inside_temp.temperature_f.to_f)
    return slope
  end

end
