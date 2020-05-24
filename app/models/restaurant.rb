class Restaurant < ApplicationRecord
  include PgSearch
    pg_search_scope :global_search,
      against: [ :name ],
      associated_against: {
        restaurant_category: [:name],
        restaurant_address: [:name]
      },
      using: {
        tsearch: { prefix: true } # <-- now `superman batm` will return something!
      }

  has_many :reviews, dependent: :destroy
  belongs_to :restaurant_category
  belongs_to :user

  validates :address, presence: true
  validates :name, presence: true
  validates :price_index, presence: true
  validates :price_index, presence: true, inclusion: 1..3
  validates :restaurant_category_id, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo
end
