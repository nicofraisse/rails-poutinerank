class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :category
      t.string :address
      t.integer :price_index

      t.timestamps
    end
  end
end
