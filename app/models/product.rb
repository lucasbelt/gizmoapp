class Product < ApplicationRecord
  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  belongs_to :user
  default_scope -> { order(updated_at: :desc) }
  has_many :product_tags
  has_many :tags, through: :product_tags
  has_many :comments, dependent: :destroy
end