class Publisher < ApplicationRecord
  has_many :books
  has_many :authors

  accepts_nested_attributes_for :books
  accepts_nested_attributes_for :authors

  validates :name, presence: true
end
