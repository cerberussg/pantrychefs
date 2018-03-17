class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :ingredients, presence: true, length: { minimum: 5, maximum: 1500 }
  validates :directions, presence: true, length: { minimum: 5, maximum: 1500 }
  belongs_to :chef
  validates :chef_id, presence: true
  default_scope -> { order(updated_at: :desc) }
  has_many :recipe_fixings
  has_many :fixings, through: :recipe_fixings
  has_many :comments, dependent: :destroy
  
  def self.search(term)
  if term
    where('name LIKE ?', "%#{term}%")
  else
    all
  end
end