# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # OmniAuthコールバック時にCSRFチェックをスキップ
  protect_from_forgery with: :exception, except: :omniauth_callbacks

  # OmniAuth認証エラーメッセージをセット
  before_action :set_omniauth_error_message

  private

  def set_omniauth_error_message
    return unless params[:message].present?

    flash[:alert] = "Authentication failed: #{params[:message]}"
  end

  def log_session_details
    Rails.logger.debug("Session details: #{session.to_hash}")
  end
end
