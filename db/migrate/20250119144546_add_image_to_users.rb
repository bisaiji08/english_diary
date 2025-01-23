# frozen_string_literal: true

class AddImageToUsers < ActiveRecord::Migration[7.1]
  def change
    return if column_exists?(:users, :image)

    add_column :users, :image, :string
  end
end
