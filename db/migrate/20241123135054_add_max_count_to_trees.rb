# frozen_string_literal: true

class AddMaxCountToTrees < ActiveRecord::Migration[7.1]
  def change
    add_column :trees, :max_count, :integer, default: 0, null: false unless column_exists?(:trees, :max_count)
  end
end
