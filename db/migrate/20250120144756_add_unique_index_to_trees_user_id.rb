# frozen_string_literal: true

class AddUniqueIndexToTreesUserId < ActiveRecord::Migration[7.1]
  def change
    remove_index :trees, :user_id if index_exists?(:trees, :user_id)

    add_index :trees, :user_id, unique: true
  end
end
