class AddFontNameToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_column :diaries, :font_name, :string
  end
end
