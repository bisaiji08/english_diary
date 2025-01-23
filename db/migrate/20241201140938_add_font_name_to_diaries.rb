# frozen_string_literal: true

class AddFontNameToDiaries < ActiveRecord::Migration[7.1]
  def change
    # font_nameカラムが存在しない場合のみ追加
    add_column :diaries, :font_name, :string unless column_exists?(:diaries, :font_name)
  end
end
