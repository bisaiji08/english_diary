class ReminderMailer < ApplicationMailer
  default from: 'yourapp@example.com'

  def daily_reminder(user)
    @user = user
    mail(
      to: @user.email,
      subject: 'リマインダー通知: アプリを開く時間です！'
    )
  end
end
