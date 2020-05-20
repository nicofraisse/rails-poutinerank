class AddRefToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_reference :restaurants, :restaurant_category, null: false, foreign_key: true
  end
end
