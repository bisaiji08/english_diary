class CreateTrees < ActiveRecord::Migration[7.1]
  def change
    unless table_exists?(:trees)
      create_table :trees do |t|
        t.string :name
        t.integer :level
        t.string :job
        t.integer :points

        t.timestamps
      end
    end
  end
end
