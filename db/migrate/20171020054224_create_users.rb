class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :address
      t.string :name
      t.string :phone_number
      t.string :gender
      t.string :avatar
      t.string :dob
      
      t.timestamps
    end
  end
end
