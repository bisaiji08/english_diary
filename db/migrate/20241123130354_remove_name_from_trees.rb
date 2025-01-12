class RemoveNameFromTrees < ActiveRecord::Migration[7.1]
  def change
    if column_exists?(:trees, :name)
      remove_column :trees, :name, :string
    end
  end
end
