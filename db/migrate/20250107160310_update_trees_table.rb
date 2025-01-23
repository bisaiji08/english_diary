# frozen_string_literal: true

class UpdateTreesTable < ActiveRecord::Migration[7.1]
  def change
    # user_idカラムを追加（存在確認を行う）
    add_reference :trees, :user, null: false, foreign_key: true unless column_exists?(:trees, :user_id)

    # last_trained_atカラムを追加（存在確認を行う）
    add_column :trees, :last_trained_at, :datetime unless column_exists?(:trees, :last_trained_at)

    # max_countカラムを追加（存在確認を行う）
    add_column :trees, :max_count, :integer, default: 0, null: false unless column_exists?(:trees, :max_count)

    # nameカラムが存在する場合は削除
    return unless column_exists?(:trees, :name)

    remove_column :trees, :name, :string
  end
end
