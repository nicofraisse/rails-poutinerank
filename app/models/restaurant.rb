class Restaurant < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  include PgSearch
    pg_search_scope :global_search,
      against: [ :name , :address],
      associated_against: {
        restaurant_category: [:name],
      },
      using: {
        tsearch: { prefix: true } # <-- now `superman batm` will return something!
      }

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
