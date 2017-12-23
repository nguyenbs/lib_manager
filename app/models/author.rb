class Author < ApplicationRecord
  belongs_to :publisher

  has_many :relationships, class_name: Relationship.name, foreign_key: "ownerable_id"
  has_many :books, through: :relationships, source_type: Book.name, source: :targetable
  # has_many :follower_users, through: :relationships, source_type: User.name, source: :ownerable

  mount_uploader :avatar, ImageUploader

  rails_admin do
    exclude_fields :categories, :relationships, :users, :borrow_books, :comments, :user_ratings, :books, :follower_users
  end
end
