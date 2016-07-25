require 'rails_helper'

RSpec.describe CarMark, type: :model do
  let(:car_mark){create :car_mark}
  context 'valid has_many car_models'  do
		it{
			expect(car_mark).to have_many(:car_models)
		}
  end
end
