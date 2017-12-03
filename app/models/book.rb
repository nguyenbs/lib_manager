class Book < ApplicationRecord
  has_many :borrow_books
  has_many :comments
  has_many :user_ratings

  has_many :relationships, as: :targetable
  has_many :users, through: :relationships, source_type: User.name, source: :ownerable
  has_many :categories, through: :relationships, source_type: Category.name, source: :ownerable
  has_many :authors, through: :relationships, source_type: Author.name, source: :ownerable

  belongs_to :publisher

  accepts_nested_attributes_for :publisher
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :authors
  
  rails_admin do
    exclude_fields :relationships, :users, :borrow_books, :comments, :user_ratings
  end
end