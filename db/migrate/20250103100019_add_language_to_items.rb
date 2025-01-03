class AddLanguageToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :language, :string
  end
end
