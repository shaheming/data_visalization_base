class CreateRestaurantData < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurant_data do |t|
      t.string :east_longitude
      t.string :north_latitude
      t.string :district
      t.string :name
      t.float :price
      t.integer :review_cnt
      t.string :large_area
      t.string :small_area
      t.string :r_1
      t.string :r_2
      t.string :r_3
      t.float :taste_rate
      t.float :service_rate
      t.float :env_rate
      t.string :category
      t.timestamps
    end
  end
end
