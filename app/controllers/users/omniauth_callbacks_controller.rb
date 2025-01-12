class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.nil?
      redirect_to new_user_registration_url, alert: "Authentication failed: Missing email or invalid user data."
      return
    end

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def after_sign_in_path_for(resource)
    mypages_top_path # マイページのパスにリダイレクト
  end

  def failure
    redirect_to root_path, alert: "Authentication failed. Please try again."
  end
end
