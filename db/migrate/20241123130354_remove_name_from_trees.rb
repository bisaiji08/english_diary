class RemoveNameFromTrees < ActiveRecord::Migration[7.1]
  def change
    remove_column :trees, :name, :string
  end
end
