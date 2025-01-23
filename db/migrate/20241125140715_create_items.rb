# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    # テーブルが存在しない場合のみ作成
    return if table_exists?(:items)

    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
