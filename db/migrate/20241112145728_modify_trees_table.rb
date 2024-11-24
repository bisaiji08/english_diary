class ModifyTreesTable < ActiveRecord::Migration[7.1]
  def change
    # 不要なカラムを削除
    remove_column :trees, :growth_stage, :integer
    remove_column :trees, :last_watered_at, :datetime
    remove_column :trees, :water_count, :integer

    # 新しいカラムを追加
    add_column :trees, :name, :string
    add_column :trees, :level, :integer
    add_column :trees, :job, :string
    add_column :trees, :points, :integer
  end
end
