class Category < ApplicationRecord
  has_many :relationships, as: :ownerable
  has_many :books, through: :relationships,
    source_type: Book.name, source: :targetable

  validates :name, presence: true

  rails_admin do
    exclude_fields :relationships, :books
  end
end
