class Review < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  validates :rating, presence: true, :inclusion => 0..10
  validates :title, length: { minimum: 4, maximum: 80 }
  validates :body, length: { minimum: 20, maximum: 5000 }
  after_initialize :init

  def init
    self.upvotes = 0
  end
end
