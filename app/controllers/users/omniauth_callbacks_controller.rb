# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    before_action :authenticate_user!, only: [:connect_google]

    def google_oauth2
      Rails.logger.info 'Google OAuth Callback Received'
      Rails.logger.info "OmniAuth Auth Hash: #{request.env['omniauth.auth'].inspect}"

      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.nil?
        Rails.logger.error 'User creation failed: No user returned from from_omniauth'
        redirect_to new_user_registration_url, alert: t('devise.omniauth_callbacks.failure', kind: 'Google')
        return
      end

      if @user.persisted?
        Rails.logger.info "User found or created: #{@user.inspect}"
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
      else
        Rails.logger.error "User not persisted: #{@user.errors.full_messages}"
        session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
    end

    def after_sign_in_path_for(_resource)
      mypages_top_path # マイページのパスにリダイレクト
    end

    def connect_google
      # OmniAuthデータが存在しない場合のエラーハンドリング
      auth = request.env['omniauth.auth']
      if auth.blank? || auth.provider.blank? || auth.uid.blank?
        redirect_to mypages_google_account_path, alert: t('devise.omniauth_callbacks.link_failure')
        return
      end

      # 現在のユーザーと同じGoogleアカウントが既に存在しているか確認
      existing_user = User.find_by(provider: auth.provider, uid: auth.uid)
      if existing_user && existing_user != current_user
        redirect_to mypages_google_account_path, alert: t('devise.omniauth_callbacks.already_linked')
        return
      end

      current_user.update(provider: auth.provider, uid: auth.uid)
      if current_user.save
        redirect_to mypages_settings_path, notice: t('devise.omniauth_callbacks.link_success')
      else
        Rails.logger.error "Failed to save user: #{current_user.errors.full_messages}"
        redirect_to mypages_google_account_path, alert: t('devise.omniauth_callbacks.link_failure')
      end
    end

    def failure
      redirect_to mypages_google_account_path, alert: t('devise.omniauth_callbacks.failure')
    end
  end
end
