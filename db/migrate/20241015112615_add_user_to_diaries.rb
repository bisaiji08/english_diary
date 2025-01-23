# frozen_string_literal: true

class AddUserToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_reference :diaries, :user, foreign_key: true, null: true
  end
end
