# frozen_string_literal: true

class ReminderMailer < ApplicationMailer
  default from: ENV['GMAIL_USERNAME']

  def daily_reminder(user)
    @user = user
    mail(
      to: @user.email,
      subject: 'リマインダー通知: 今日の日記を書いてみませんか？'
    )
  end
end
