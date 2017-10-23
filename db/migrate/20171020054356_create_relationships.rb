class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :ownerable_id
      t.string :ownerable_type
      t.integer :targetable_id
      t.string :targetable_type

      t.timestamps
    end
    add_index :relationships, [:ownerable_id, :targetable_id]
  end
end
