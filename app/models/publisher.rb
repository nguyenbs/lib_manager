class Publisher < ApplicationRecord
  has_many :books
  has_many :authors

  validates :name, presence: true
end
