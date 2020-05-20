class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :restaurant_category
  validates :restaurant_category_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
  validates :price_index, presence: true
end
