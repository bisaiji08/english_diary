class CreateItems < ActiveRecord::Migration[7.1]
  def change
    # テーブルが存在しない場合のみ作成
    unless table_exists?(:items)
      create_table :items do |t|
        t.string :name
        t.text :description
        t.integer :price

        t.timestamps
      end
    end
  end
end
