class ShangHaiRestaurantController < ApplicationController
  layout 'echart'
  STYLE = "mapbox://styles/sandersaaa/cjficjvvld53d2qrq6o5q986n"
  COLOR = ["#4A3F6A", "#55487A", "#5B4C82", "#825E89", "#91678C", "#9E6F8F", "#B98196", "#D1929C", "#F4AFA6", "#F5C6A0", "#F5D29A", "#F4DC93", "#F4E48C", "#F4E986"]

  def average
    @map_style_path = STYLE
    @color_range = COLOR
  end

  def total
    @map_style_path = STYLE
    # @color_range = ["#F4E986", "#F4E48C", "#F4DC93", "#F5D29A", "#F5C6A0", "#F4AFA6", "#D1929C", "#B98196", "#9E6F8F", "#91678C", "#825E89", "#5B4C82", "#55487A", "#4A3F6A"]
    @color_range = COLOR
  end

  def average_data
    data = RestaurantDatum.avg_to_json
    render :json => data
  end


  def total_data
    data = RestaurantDatum.total_to_json
    render :json => data
  end
end
