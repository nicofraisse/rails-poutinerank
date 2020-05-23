class AddRefToRestaurantAddresses < ActiveRecord::Migration[6.0]
  def change
    add_reference :restaurant_addresses, :restaurant, null: false, foreign_key: true
  end
end
