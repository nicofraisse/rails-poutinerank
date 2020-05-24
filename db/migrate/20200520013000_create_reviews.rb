class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.integer :rating
      t.string :title
      t.text :body
      t.integer :upvotes, default: 0

      t.timestamps
    end
  end
end
