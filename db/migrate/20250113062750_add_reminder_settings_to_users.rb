class AddReminderSettingsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :reminder_time, :time
    add_column :users, :reminder_enabled, :boolean
  end
end
