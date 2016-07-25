require 'rails_helper'

RSpec.describe CarModel, type: :model do
  let(:car_model){create :car_model}
  context 'valid belongs_to car_mark'  do
		it{
			expect(car_model).to belong_to(:car_mark)
		}
  end
end
