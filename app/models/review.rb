class Review < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  belongs_to :poutine_category
  validates :user_id, presence: true
  validates :global_rating, presence: true, :inclusion => 1..10
  validates :title, presence: true, length: { minimum: 4, maximum: 80 }
  validates :body, presence: true, length: { minimum: 20, maximum: 8000 }

  has_many_attached :photos


end
