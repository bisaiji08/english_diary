class AddLanguageToItems < ActiveRecord::Migration[7.1]
  def change
    # languageカラムが存在しない場合のみ追加
    add_column :items, :language, :string unless column_exists?(:items, :language)
  end
end
