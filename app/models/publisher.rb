class Publisher < ApplicationRecord
  has_many :books
  has_many :authors

  validates :name, presence: true
  mount_uploader :image, ImageUploader

  rails_admin do
    exclude_fields :books, :authors
  end
end
