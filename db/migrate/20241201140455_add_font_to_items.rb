# frozen_string_literal: true

class AddFontToItems < ActiveRecord::Migration[7.1]
  def change
    # font_nameカラムが存在しない場合のみ追加
    add_column :items, :font_name, :string unless column_exists?(:items, :font_name)
  end
end
