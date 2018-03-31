class WelcomeController < ApplicationController

  def index
    @text = Time.now.to_s + "SHAME"
  end

  def test

  end

  def restaurant_data
    data = RestaurantDatum.to_json
    render :json => [data, data.size]
  end

  private

  def check_1
    render :json => {msg: "data less than 1"} if params[:data].to_i <= 1
  end

  def check_2
    render :json => {msg: "data less than 2"} if params[:data].to_i <= 2
  end
end
