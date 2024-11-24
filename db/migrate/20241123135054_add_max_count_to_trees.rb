class AddMaxCountToTrees < ActiveRecord::Migration[7.1]
  def change
    add_column :trees, :max_count, :integer, default: 0, null: false
  end
end
