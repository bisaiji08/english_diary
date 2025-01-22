class AddUniqueIndexToTreesUserId < ActiveRecord::Migration[7.1]
  def change
    if index_exists?(:trees, :user_id)
      remove_index :trees, :user_id
    end

    add_index :trees, :user_id, unique: true
  end
end
