class Review < ApplicationRecord
  belongs_to :user
  has_many :lovews, dependent: :destroy
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  has_many :comments, dependent: :destroy

  def lovewd_by?(user)
    lovews.where(user_id: user.id).exists?
  end

  with_options presence: true do
    validates :title, length:{ maximum: 100 }
    with_options length: { maximum: 3000 } do
      validates :problem
      validates :detail
      validates :content
    end
  end

  validates :solution, length:{ maximum: 3000 }

end
