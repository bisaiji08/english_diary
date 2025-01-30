# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    def new
      self.resource = User.new
      super
    end

    def create
      user = User.find_by(email: params[:user][:email])
      if user&.valid_password?(params[:user][:password])
        remember_me = params[:user][:remember_me] == '1' # 明示的に変数に格納
        sign_in(user, remember_me: remember_me)

        if remember_me
          cookies.permanent.signed[:remember_user_token] = user.rememberable_value # 追加
        end

        redirect_to mypages_top_path
      else
        self.resource = User.new
        flash[:alert] = I18n.t('devise.failure.invalid', authentication_keys: 'Email') # 追加
        render :new
      end
    end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end

    def after_sign_in_path_for(_resource)
      mypages_top_path
    end

    def after_sign_out_path_for(_resource_or_scope)
      new_user_session_path
    end
  end
end
