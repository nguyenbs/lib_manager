class Author < ApplicationRecord
  belongs_to :publisher
  
  has_many :relationships, as: :ownerable
  has_many :books, through: :relationships, source_type: Book.name, source: :targetable
  has_many :follower_users, through: :relationships, source_type: User.name, source: :ownerable

  accepts_nested_attributes_for :books
  accepts_nested_attributes_for :publisher

  rails_admin do
    exclude_fields :follower_users
  end
end