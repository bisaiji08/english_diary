class NotificationMailerJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    if user.notifications_enabled
      ReminderMailer.daily_reminder(user).deliver_now
    end
  end
end
