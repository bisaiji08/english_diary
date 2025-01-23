# frozen_string_literal: true

class AddResetPasswordToUsers < ActiveRecord::Migration[7.1]
  def change
    # カラムを一括で確認しながら追加
    add_column :users, :reset_password_token, :string unless column_exists?(:users, :reset_password_token)
    add_column :users, :reset_password_sent_at, :datetime unless column_exists?(:users, :reset_password_sent_at)
  end
end
