# frozen_string_literal: true

class SendRemindersJob < ApplicationJob
  queue_as :default

  def perform
    time_now = Time.zone.now

    # 通知が有効で、設定時刻に一致するユーザーを対象にジョブをスケジュール
    User.where(notifications_enabled: true).find_each do |user|
      next unless user.notification_time.hour == time_now.hour && user.notification_time.min == time_now.min

      NotificationMailerJob.perform_later(user.id)
    end
  end
end
