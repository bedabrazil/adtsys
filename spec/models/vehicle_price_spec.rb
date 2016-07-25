require 'rails_helper'

RSpec.describe VehiclePrice, type: :model do
  let(:vehicle_price){create :vehicle_price}
  context 'valid belongs_to car_models'  do
		it{
			expect(vehicle_price).to belong_to(:car_model_year)
		}
  end
end
