# frozen_string_literal: true

class ChangeUserIdToNotNullInDiaries < ActiveRecord::Migration[7.1]
  def change
    change_column_null :diaries, :user_id, false
  end
end
