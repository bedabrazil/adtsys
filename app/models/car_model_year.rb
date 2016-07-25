class CarModelYear < ActiveRecord::Base
  belongs_to :car_model
  has_many :vehicle_prices
end
