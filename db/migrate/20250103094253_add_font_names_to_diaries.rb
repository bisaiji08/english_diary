class AddFontNamesToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_column :diaries, :japanese_font_name, :string
    add_column :diaries, :english_font_name, :string
  end
end
