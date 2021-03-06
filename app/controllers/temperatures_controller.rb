class TemperaturesController < ApplicationController
  before_action :set_temperature, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session

  # GET /temperatures
  # GET /temperatures.json
  def index
    @outside_temps = Thermometer.where(:name => 'outside').first.temperatures.order('created_at DESC')
    @floor_temps = Thermometer.where(:name => 'floor').first.temperatures.order('created_at DESC')

    if !params["days"].nil?
      @outside_temps = Thermometer.where(:name => 'outside').first.temperatures.where("created_at > ?", DateTime.now - params["days"].to_i.days).order('created_at DESC')
      @floor_temps = Thermometer.where(:name => 'floor').first.temperatures.where("created_at > ?", DateTime.now - params["days"].to_i.days).order('created_at DESC')
    end

    outdoor_array = @outside_temps.map{|x| x.temperature_f}
    @outdoor_mean = outdoor_array.inject{ |sum, el| sum + el }.to_f / outdoor_array.size

    floor_array = @floor_temps.map{|x| x.temperature_f}
    @floor_mean = floor_array.inject{ |sum, el| sum + el }.to_f / floor_array.size

  end

  # GET /temperatures/1
  # GET /temperatures/1.json
  def show
  end

  # GET /temperatures/new
  def new
    @temperature = Temperature.new
  end

  # GET /temperatures/1/edit
  def edit
  end

  # POST /temperatures
  # POST /temperatures.json
  def create
  #  @temperature = Temperature.new(temperature_params)
     @temperature = Temperature.new
     @temperature.temperature_c = temperature_params[:temperature_c]
     @temperature.thermometer_id = Thermometer.where(:name => temperature_params[:name]).first.id


    respond_to do |format|
      if @temperature.save
        format.html { redirect_to @temperature, notice: 'Temperature was successfully created.' }
        format.json { render :show, status: :created, location: @temperature }
      else
        format.html { render :new }
        format.json { render json: @temperature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temperatures/1
  # PATCH/PUT /temperatures/1.json
  def update
    respond_to do |format|
      if @temperature.update(temperature_params)
        format.html { redirect_to @temperature, notice: 'Temperature was successfully updated.' }
        format.json { render :show, status: :ok, location: @temperature }
      else
        format.html { render :edit }
        format.json { render json: @temperature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temperatures/1
  # DELETE /temperatures/1.json
  def destroy
    @temperature.destroy
    respond_to do |format|
      format.html { redirect_to temperatures_url, notice: 'Temperature was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temperature
      @temperature = Temperature.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def temperature_params
      params.require(:temperature).permit(:thermometer_id, :temperature_c, :name)
    end
end
