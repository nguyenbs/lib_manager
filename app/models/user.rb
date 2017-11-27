class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments, dependent: :destroy
  has_many :user_ratings, dependent: :destroy
  has_many :borrow_books

  has_many :relationships, as: :ownerable
  has_many :books, through: :relationships, source_type: Book.name, source: :targetable
  has_many :following_author, through: :relationships, source_type: Author.name, source: :targetable

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "ownerable_id", dependent: :destroy
  has_many :following, through: :active_relationships,
    source_type: User.name, source: :targetable

  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "targetable_id", dependent: :destroy
  has_many :followers, through: :passive_relationships,
    source_type: User.name, source: :ownerable

  validates :email, presence: true
  validates :name, presence: true
  validates :password, presence: true
end
