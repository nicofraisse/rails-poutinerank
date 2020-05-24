class Review < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :user_id, presence: true
  validates :rating, presence: true, :inclusion => 0..10
  validates :title, presence: true, length: { minimum: 4, maximum: 80 }
  validates :body, presence: true, length: { minimum: 20, maximum: 5000 }
  after_initialize :init
  has_many_attached :photos

  def init
    self.upvotes = 0
  end
end
