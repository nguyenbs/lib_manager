class BorrowBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validates :date_borrow, presence: true

  enum status: [:processing, :borrowing, :returned, :rejected]
end
