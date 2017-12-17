class RemoveFieldType < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :type
  end
end
