class AddFontToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :font_name, :string
  end
end
