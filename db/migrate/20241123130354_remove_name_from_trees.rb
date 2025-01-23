# frozen_string_literal: true

class RemoveNameFromTrees < ActiveRecord::Migration[7.1]
  def change
    return unless column_exists?(:trees, :name)

    remove_column :trees, :name, :string
  end
end
