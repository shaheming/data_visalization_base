class RestaurantDatum < ApplicationRecord

  def self.to_json

    self.all.map{
      |r| {name: r.name,value:[r.longitude.to_f, r.latitude.to_f, r.price.to_f]}
    }[1..3000]
  end

end
