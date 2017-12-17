class ChangeFieldType < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :type, :string
  end
end
