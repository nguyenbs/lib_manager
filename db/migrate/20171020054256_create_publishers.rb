class CreatePublishers < ActiveRecord::Migration[5.1]
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
