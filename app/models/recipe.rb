class Recipe < ApplicationRecord
  validates :chef_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  belong_to :chef
end