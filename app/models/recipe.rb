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
  
  def self.search(term, page)
    if term
      name = where('lower(name) LIKE ?', "%#{term}%")
      fixings = where('lower(fixings.name) LIKE ?', "%#{term}%")
      if name
        where('lower(name) LIKE ?', "%#{term}%").paginate(page: page, per_page: 10)
      elsif fixings
        where('lower(fixings.name) LIKE ?', "%#{term}%").paginate(page: page, per_page: 10)
      end
    else
      paginate(page: page, per_page: 10)
    end
  end
end