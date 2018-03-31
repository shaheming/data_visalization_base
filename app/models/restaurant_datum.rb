class RestaurantDatum < ApplicationRecord

  def self.avg_to_json
    self.all.map {
        |r| {name: r.name, value: [r.longitude.to_f, r.latitude.to_f, r.price.to_f]}
    }
  end

  def self.total_to_json
    self.all.map {
        |r| {name: r.name, value: [r.longitude.to_f, r.latitude.to_f, r.price.to_f * r.review_cnt]}
    }
  end
end
