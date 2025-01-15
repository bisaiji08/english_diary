class MypagesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_tree_exists, only: :top

  def top
    @tree = current_user.tree
    @purchased_items = current_user.purchases.includes(:item).map(&:item) # 購入したアイテム一覧
  end

  def settings
    # 特別な処理は不要、ビューを表示するだけ
  end

  def google_account
    # 必要ならGoogle連携に関する情報を取得
  end
  
  def notification_settings
    @notifications_enabled = current_user.notifications_enabled
    @notification_time = current_user.notification_time
  end

  def update_notification_settings
    if params[:user].present?
      if current_user.update(notification_params)
        redirect_to mypages_notification_settings_path, notice: 'Notification settings updated successfully.'
      else
        flash[:alert] = 'Failed to update notification settings.'
        render :notification_settings
      end
    else
      flash[:alert] = 'Invalid parameters. Please try again.'
      redirect_to mypages_notification_settings_path
    end
  end
  

  private

  def ensure_tree_exists
    current_user.create_tree unless current_user.tree
  end

  def notification_params
    params.require(:user).permit(:notifications_enabled, :notification_time)
  end
end
