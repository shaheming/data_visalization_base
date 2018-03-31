class ShangHaiRestaurantController < ApplicationController
  layout 'echart'

  def average

  end

  def total

  end

  def average_data
    data = RestaurantDatum.avg_to_json
    render :json => [data, data.size]
  end


  def total_data
    data = RestaurantDatum.total_to_json
    render :json => [data, data.size]
  end
end
