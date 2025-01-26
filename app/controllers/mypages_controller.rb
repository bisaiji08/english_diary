# frozen_string_literal: true

class MypagesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_tree_exists, only: :top

  def top
    @tree = current_user.tree
    @purchased_items = current_user.purchases.includes(:item).map(&:item)
  end

  def settings; end

  def google_account; end

  def notification_settings
    @notifications_enabled = current_user.notifications_enabled
    @notification_time = current_user.notification_time
  end

  def update_notification_settings
    if params[:user].present?
      if current_user.update(notification_params)
        redirect_to mypages_notification_settings_path, notice: t('mypages.notifications.updated')
      else
        flash[:alert] = t('mypages.notifications.failed')
        render :notification_settings
      end
    else
      flash[:alert] = t('mypages.notifications.invalid_params')
      redirect_to mypages_notification_settings_path
    end
  end

  def how_to_use; end

  private

  def ensure_tree_exists
    current_user.create_tree unless current_user.tree
  end

  def notification_params
    params.require(:user).permit(:notifications_enabled, :notification_time)
  end
end
