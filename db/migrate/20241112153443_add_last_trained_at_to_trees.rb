class AddLastTrainedAtToTrees < ActiveRecord::Migration[7.1]
  def change
    add_column :trees, :last_trained_at, :datetime
  end
end
