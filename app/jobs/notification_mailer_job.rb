# frozen_string_literal: true

class NotificationMailerJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    return unless user.notifications_enabled

    ReminderMailer.daily_reminder(user).deliver_now
  end
end
