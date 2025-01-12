class AddFontNamesToDiaries < ActiveRecord::Migration[7.1]
  def change
    # japanese_font_nameカラムが存在しない場合のみ追加
    add_column :diaries, :japanese_font_name, :string unless column_exists?(:diaries, :japanese_font_name)

    # english_font_nameカラムが存在しない場合のみ追加
    add_column :diaries, :english_font_name, :string unless column_exists?(:diaries, :english_font_name)
  end
end
