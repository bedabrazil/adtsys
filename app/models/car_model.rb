class CarModel < ActiveRecord::Base
	belongs_to :car_mark
	has_many :car_model_years
end
