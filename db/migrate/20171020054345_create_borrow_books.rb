class CreateBorrowBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :borrow_books do |t|
      t.date :date_borrow
      t.date :date_return
      t.integer :status, null: false, default: 0

      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
    add_index :borrow_books, [:user_id, :book_id]
  end
end
