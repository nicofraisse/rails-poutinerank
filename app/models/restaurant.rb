class Restaurant < ApplicationRecord
  searchkick

  has_many :reviews, dependent: :destroy
  belongs_to :restaurant_category
  belongs_to :user

  validates :address, presence: true
  validates :name, presence: true
  validates :restaurant_category_id, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo
end
