class Review < ApplicationRecord
  belongs_to :poutine
  belongs_to :user
end
