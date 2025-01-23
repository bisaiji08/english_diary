# frozen_string_literal: true

class RenameContentInDiaries < ActiveRecord::Migration[7.1]
  def change
    rename_column :diaries, :content, :content_japanese

    add_column :diaries, :content_english, :text
  end
end
