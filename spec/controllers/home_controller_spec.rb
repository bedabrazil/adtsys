require 'rails_helper'

describe "CONSUME FIPE API", type: :request do
  it 'test success Net::HTTP' do
    uri = URI('http://fipeapi.appspot.com/api/1/carros/marcas.json')
    response = Net::HTTP.get_response(uri)
    json = JSON.parse response.body
    expect(json).to be_an_instance_of(Array)
  end
end