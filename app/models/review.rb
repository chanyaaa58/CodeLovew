class Review < ApplicationRecord
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :name, length:{ in: 1..20 }
    validates :title, length:{ in: 1..100 }
    validates :problem, length:{ in: 1..3000 }
    validates :detail, length:{ in: 1..3000 }
    validates :content, length:{ in: 1..3000 }
  end

  validates :solution, length:{ maximum: 3000 }

end
