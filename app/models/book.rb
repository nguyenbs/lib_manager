class Book < ApplicationRecord
  has_many :borrow_books
  has_many :comments
  has_many :user_ratings

  has_many :relationships, as: :targetable
  has_many :users, through: :relationships, source_type: User.name, source: :ownerable
  has_many :categories, through: :relationships, source_type: Category.name, source: :ownerable
  has_many :authors, through: :relationships, source_type: Author.name, source: :ownerable

  belongs_to :publisher

  mount_uploader :cover_image, ImageUploader
  mount_uploader :image, ImageUploader

  # scope :search_book, -> book_name, author_name, category_name do
  #   where("books.name LIKE ?","%#{book_name}%")
  #   .joins(:authors).where("authors.name LIKE ?", "%#{author_name}%")
  #   .joins(:categories).where("categories.name LIKE ?", "%#{category_name}%")
  # end

  def self.search_book book_name, author_name, category_name
    # query = <<-SQL
    # SELECT *
    # FROM books
    # INNER JOIN relationships
    #   ON relationships.targetable_id = books.id
    #   AND relationships.ownerable_type = 'Author'
    #   AND relationships.targetable_type = 'Book'
    # INNER JOIN authors
    #   ON authors.id = relationships.ownerable_id
    # INNER JOIN relationships relationships_books_join
    #   ON relationships_books_join.targetable_id = books.id
    #   AND relationships_books_join.ownerable_type = 'Category'
    #   AND relationships_books_join.targetable_type = 'Book'
    # INNER JOIN categories
    #   ON categories.id = relationships_books_join.ownerable_id
    # WHERE
    #   books.name LIKE "%#{book_name}%" AND authors.name LIKE "%#{author_name}%" AND   categories.name LIKE "%#{category_name}%"
    # SQL
    query = "
    SELECT books.id
    FROM books
    INNER JOIN relationships ON relationships.targetable_id = books.id
    AND relationships.ownerable_type = 'Author'
    AND relationships.targetable_type = 'Book'
    INNER JOIN authors ON authors.id = relationships.ownerable_id
    INNER JOIN relationships relationships_books_join ON relationships_books_join.targetable_id = books.id
    AND relationships_books_join.ownerable_type = 'Category'
    AND relationships_books_join.targetable_type = 'Book'
    INNER JOIN categories ON categories.id = relationships_books_join.ownerable_id
    WHERE (books.name LIKE '%#{book_name}%')
      AND (authors.name LIKE '%#{author_name}%')
      AND (categories.name LIKE '%#{category_name}%')"
    result = ActiveRecord::Base.connection.exec_query(query)
    Book.where(id: result.rows.flatten)
  end

  rails_admin do
    exclude_fields :categories, :relationships, :users, :borrow_books, :comments, :user_ratings, :authors
  end
end
