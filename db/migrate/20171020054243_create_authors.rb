class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :gender
      t.string :address
      t.string :dob
      t.string :description
      t.integer :publisher_id
      t.string :avatar

      t.timestamps
    end
    add_index :authors, :publisher_id
  end
end
