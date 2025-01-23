# frozen_string_literal: true

class AddNotificationSettingsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :notifications_enabled, :boolean
    add_column :users, :notification_time, :time
  end
end
