class UpdateTreesTable < ActiveRecord::Migration[7.1]
  def change
    # user_idカラムを追加（存在確認を行う）
    unless column_exists?(:trees, :user_id)
      add_reference :trees, :user, null: false, foreign_key: true
    end

    # last_trained_atカラムを追加（存在確認を行う）
    unless column_exists?(:trees, :last_trained_at)
      add_column :trees, :last_trained_at, :datetime
    end

    # max_countカラムを追加（存在確認を行う）
    unless column_exists?(:trees, :max_count)
      add_column :trees, :max_count, :integer, default: 0, null: false
    end

    # nameカラムが存在する場合は削除
    if column_exists?(:trees, :name)
      remove_column :trees, :name, :string
    end
  end
end
