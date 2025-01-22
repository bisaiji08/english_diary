class AddUniqueConstraintToTreesUserId < ActiveRecord::Migration[7.1]
  def change
    unless index_exists?(:trees, :user_id, unique: true)
      remove_index :trees, :user_id if index_exists?(:trees, :user_id) # 一般的なインデックスがある場合は削除
      add_index :trees, :user_id, unique: true
    end
  end
end
