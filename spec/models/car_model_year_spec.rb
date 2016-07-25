require 'rails_helper'

RSpec.describe CarModelYear, type: :model do
  let(:car_model_year){create :car_model_year}
  context 'valid belongs_to car_models'  do
		it{
			expect(car_model_year).to belong_to(:car_model)
		}
  end
end
