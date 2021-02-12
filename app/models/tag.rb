class Tag < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 80 }
  validates_uniqueness_of :name
  has_many :product_tags
  has_many :products, through: :product_tags
end