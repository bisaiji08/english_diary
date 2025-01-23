# frozen_string_literal: true

class CreatePurchases < ActiveRecord::Migration[7.1]
  def change
    # テーブルが存在しない場合のみ作成
    return if table_exists?(:purchases)

    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
