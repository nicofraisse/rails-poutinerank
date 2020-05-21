class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :restaurant_category
  belongs_to :user
  validates :restaurant_category_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
  validates :price_index, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
