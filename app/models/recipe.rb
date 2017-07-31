class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 1500 }
  belongs_to :chef
  validates :chef_id, presence: true
end