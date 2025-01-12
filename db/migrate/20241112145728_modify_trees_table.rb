class ModifyTreesTable < ActiveRecord::Migration[7.1]
  def change
    # 不要なカラムを削除
    remove_column :trees, :growth_stage, :integer if column_exists?(:trees, :growth_stage)
    remove_column :trees, :last_watered_at, :datetime if column_exists?(:trees, :last_watered_at)
    remove_column :trees, :water_count, :integer if column_exists?(:trees, :water_count)

    # 新しいカラムを追加（存在しない場合のみ）
    add_column :trees, :name, :string unless column_exists?(:trees, :name)
    add_column :trees, :level, :integer unless column_exists?(:trees, :level)
    add_column :trees, :job, :string unless column_exists?(:trees, :job)
    add_column :trees, :points, :integer unless column_exists?(:trees, :points)
  end
end
