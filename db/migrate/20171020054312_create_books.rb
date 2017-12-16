class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :publisher_year
      t.integer :amount
      t.string :name
      t.string :weight
      t.string :language
      t.string :description
      t.integer :rating, default: 0
      t.integer :publisher_id
      t.string :cover_image
      t.string :image
      t.integer :type
      t.timestamps
    end
    add_index :books, :publisher_id
  end
end
