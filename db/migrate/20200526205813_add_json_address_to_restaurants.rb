class AddJsonAddressToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :json_address, :json
  end
end
