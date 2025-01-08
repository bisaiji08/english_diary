class ModifyTreesTable < ActiveRecord::Migration[7.1]
  def change
    # 不要なカラムを削除
    if column_exists?(:trees, :growth_stage)
      remove_column :trees, :growth_stage, :integer
    end
    if column_exists?(:trees, :last_watered_at)
      remove_column :trees, :last_watered_at, :datetime
    end
    if column_exists?(:trees, :water_count)
      remove_column :trees, :water_count, :integer
    end
    

    # 新しいカラムを追加
    add_column :trees, :name, :string
    add_column :trees, :level, :integer
    add_column :trees, :job, :string
    add_column :trees, :points, :integer
  end
end
