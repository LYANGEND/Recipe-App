class Food < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, presence: true, length: { maximum: 100 }
  validates :measurement_unit, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates_uniqueness_of :name
end
