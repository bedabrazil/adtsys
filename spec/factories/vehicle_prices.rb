FactoryGirl.define do
  factory :vehicle_price do
    name "NAME"
    mark "FIPE NAME"
    year_model "FIPE KEY"
    price '9999'
    fuel 'FUEL'
    reference 'REFERENCE'
    :car_model_year 
  end

end