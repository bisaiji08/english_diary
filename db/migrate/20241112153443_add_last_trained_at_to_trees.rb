class AddLastTrainedAtToTrees < ActiveRecord::Migration[7.1]
  def change
    add_column :trees, :last_trained_at, :datetime unless column_exists?(:trees, :last_trained_at)
  end
end
