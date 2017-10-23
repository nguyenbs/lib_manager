class CreateUserRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :user_ratings do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :rate

      t.timestamps
    end
    add_index :user_ratings, [:user_id, :book_id]
  end
end
