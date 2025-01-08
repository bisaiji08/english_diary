class AddResetPasswordToUsers < ActiveRecord::Migration[7.1]
  def change
    # reset_password_token が存在しない場合のみ追加
    unless column_exists?(:users, :reset_password_token)
      add_column :users, :reset_password_token, :string
    end

    # reset_password_sent_at が存在しない場合のみ追加
    unless column_exists?(:users, :reset_password_sent_at)
      add_column :users, :reset_password_sent_at, :datetime
    end
  end
end
