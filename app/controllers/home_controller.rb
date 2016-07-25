class HomeController < ApplicationController
  before_action :json_mark, if: :car_mark_empty?, only: :index
  before_action :json_model, if: :car_model_empty?, only: :search_models
  before_action :json_model_year, if: :car_model_year_empty?, only: :search_model_years
  before_action :json_vehicle_price, if: :vehicle_price_empty?, only: :search_vehicle_prices

  def index
    @car_marks = CarMark.where.not(fipe_id: nil).select("car_marks.fipe_id as id, car_marks.name as name")
  end

  def search_vehicle_prices
    if !params[:car_model][:fipe_id].blank? && !params[:car_mark][:fipe_id].blank? && !params[:car_model_year][:fipe_id].blank?
      car_mark = CarMark.find_by(fipe_id: params[:car_mark][:fipe_id])
      car_model = CarModel.find_by(fipe_id: params[:car_model][:fipe_id], car_mark: car_mark)
      car_model_year = CarModelYear.find_by(car_model: car_model, fipe_key: "#{params[:car_model_year][:fipe_id]}-1")
      @vehicle_prices = VehiclePrice.find_by(car_model_year: car_model_year)
      respond_to do |format|
        format.html{ render nothing: true}
        format.js 
      end
    end
  end

  def search_models
    if !params[:fipe_id].blank?
      @car_models = CarModel.where(car_mark_id: CarMark.find_by(fipe_id: params[:fipe_id]).id).select("car_models.fipe_id as id, car_models.name as name")
      respond_to do |format|
        format.html {render nothing: true}
        format.json { render json: { 'object': @car_models }}
      end
    end
  end

  def search_model_years
    if !params[:car_model_fipe_id].blank? && !params[:car_mark_fipe_id].blank?
      @car_model_years = CarModelYear.where(car_model_id: CarModel.find_by(fipe_id: params[:car_model_fipe_id]).id).select("car_model_years.fipe_key as id, car_model_years.name as name")
      respond_to do |format|
        format.html {render nothing: true}
        format.json { render json: { 'object': @car_model_years }}
      end
    end
  end


  private

  def vehicle_price_empty?
    if !params[:car_model][:fipe_id].blank? && !params[:car_model_year][:fipe_id].blank?
      VehiclePrice.where(car_model_year: CarModelYear.find_by(fipe_key: "#{params[:car_model_year][:fipe_id]}-1", car_model: CarModel.find_by(fipe_id: params[:car_model][:fipe_id]))).blank?
    end
  end

  def car_model_year_empty?
    if !params[:car_model_fipe_id].blank?
      CarModelYear.where(car_model: CarModel.find_by(fipe_id: params[:car_model_fipe_id])).blank?
    end
  end

  def car_model_empty?
    if !params[:fipe_id].blank?
      CarModel.where(car_mark: CarMark.find_by(fipe_id: params[:fipe_id])).blank?
    end
  end

  def car_mark_empty?
    CarMark.all.blank?
  end

  def json_uri(url)
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      JSON.parse response.body 
    end
  end

  def json_vehicle_price
    json = json_uri("http://fipeapi.appspot.com/api/1/carros/veiculo/#{params[:car_mark][:fipe_id]}/#{params[:car_model][:fipe_id]}/#{params[:car_model_year][:fipe_id]}-1.json")
    VehiclePrice.create(
      name: json['name'],
      price: json['preco'],
      year_model: json['ano_modelo'],
      fuel: json['combustivel'],
      reference: json['referencia'],
      mark: json['marca'],
      car_model_year: CarModelYear.find_by(fipe_key: "#{params[:car_model_year][:fipe_id]}-1", car_model: CarModel.find_by(fipe_id: params[:car_model][:fipe_id]))
    )
  end
  def json_model_year
    json = json_uri("http://fipeapi.appspot.com/api/1/carros/veiculo/#{params[:car_mark_fipe_id]}/#{params[:car_model_fipe_id]}.json")
    json.each do |model_year|
      CarModelYear.create(
        name: model_year["name"], 
        fipe_key: model_year['key'],
        car_model: CarModel.find_by(fipe_id: params[:car_model_fipe_id])
      )
    end    
  end

  def json_model
    json = json_uri("http://fipeapi.appspot.com/api/1/carros/veiculos/#{params[:fipe_id]}.json")
    json.each do |model|
      CarModel.create(
        name: model["name"], 
        fipe_name: model['fipe_name'], 
        fipe_key: model['key'],
        fipe_id: model["id"], 
        car_mark: CarMark.find_by(fipe_id: params[:fipe_id])
      )
    end
  end

  def json_mark
    json = json_uri("http://fipeapi.appspot.com/api/1/carros/marcas.json")
    json.each do |mark|
      CarMark.create(
        name: mark["name"], 
        fipe_name: mark['fipe_name'], 
        fipe_key: mark['key'],
        fipe_id: mark["id"]
      )
    end
  end
end
