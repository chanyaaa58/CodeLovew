class Comment < ApplicationRecord
  belongs_to :review
  validates :content, length:{ maximum: 200 }
end
