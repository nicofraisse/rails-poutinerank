class CreatePoutines < ActiveRecord::Migration[6.0]
  def change
    create_table :poutines do |t|
      t.string :category
      t.integer :price
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
