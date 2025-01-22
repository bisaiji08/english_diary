class AddImageToUsers < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:users, :image)
      add_column :users, :image, :string
    end
  end
end
