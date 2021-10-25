class Comment < ApplicationRecord
  belongs_to :review
  belongs_to :user
  validates :content, length:{ maximum: 200 }
end
