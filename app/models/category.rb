class Category < ApplicationRecord
  has_many :relationships, as: :ownerable
  has_many :books, through: :relationships,
    source_type: Book.name, source: :targetable

  validates :name, presence: true

  accepts_nested_attributes_for :books

  rails_admin do
    exclude_fields :relationships
  end
end
