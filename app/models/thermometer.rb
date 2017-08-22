class Thermometer < ApplicationRecord
  has_many :temperatures, dependent: :destroy 

end
