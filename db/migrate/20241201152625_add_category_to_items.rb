class AddCategoryToItems < ActiveRecord::Migration[7.1]
  def change
    # categoryカラムが存在しない場合のみ追加
    add_column :items, :category, :string unless column_exists?(:items, :category)
  end
end
