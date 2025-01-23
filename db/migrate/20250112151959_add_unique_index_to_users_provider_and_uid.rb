# frozen_string_literal: true

class AddUniqueIndexToUsersProviderAndUid < ActiveRecord::Migration[7.1]
  def change
    add_index :users, %i[provider uid], unique: true
  end
end
