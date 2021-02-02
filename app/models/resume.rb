class Resume < ApplicationRecord
  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  belongs_to :user
end