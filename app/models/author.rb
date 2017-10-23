class Author < ApplicationRecord
  belongs_to :publisher
  
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "ownerable_id", dependent: :destroy
  has_many :books, through: :active_relationships, source_type: Book.name,
    source: :targetable

  has_many :passive_relationships, -> {author_name}, class_name: Relationship.name,
    foreign_key: "targetable_id", dependent: :destroy
  has_many :follower_users, through: :passive_relationships,
    source_type: User.name, source: :ownerable
  
  validates :name, presence: true
end
