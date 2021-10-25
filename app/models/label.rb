class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :reviews, through: :labellings
end
