class UpdateTreesTable < ActiveRecord::Migration[7.1]
  def change
    # user_idカラムを追加
    add_reference :trees, :user, null: false, foreign_key: true

    # last_trained_atカラムを追加
    add_column :trees, :last_trained_at, :datetime

    # max_countカラムを追加（デフォルト値とNOT NULLを設定）
    add_column :trees, :max_count, :integer, default: 0, null: false

    # nameカラムがすでに存在する場合は削除
    remove_column :trees, :name, :string if column_exists?(:trees, :name)
  end
end
