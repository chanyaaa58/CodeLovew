class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :validatable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :reviews, dependent: :destroy
  has_many :lovews, dependent: :destroy
  has_many :lovew_reviews, through: :lovews, source: :review
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :name, length: { maximum: 20 }
    validates :email, length: { maximum: 100 }
    validates :password
  end

  def self.guest
    find_or_create_by!(name: 'Guest', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.admin_guest
    find_or_create_by!(name: 'Admin_Guest', email: 'admin_guest@example.com', admin: true) do |user|
      user.password = SecureRandom.alphanumeric()
    end
  end

  mount_uploader :icon, IconUploader
end
