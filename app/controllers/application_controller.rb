class ApplicationController < ActionController::Base
  # OmniAuthコールバック時にCSRFチェックをスキップ
  protect_from_forgery with: :exception, except: :omniauth_callbacks

  # OmniAuth認証エラーメッセージをセット
  before_action :set_omniauth_error_message

  #本番環境では削除
  skip_before_action :verify_authenticity_token, only: [:omniauth_callbacks]

  private

  def set_omniauth_error_message
    if params[:message].present?
      flash[:alert] = "Authentication failed: #{params[:message]}"
    end
  end

  def log_session_details
    Rails.logger.debug("Session details: #{session.to_hash}")
  end
end
