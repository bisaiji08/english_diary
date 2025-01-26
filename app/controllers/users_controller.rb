# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def disconnect_google
    current_user.update(provider: nil, uid: nil)
    redirect_to mypages_top_path, notice: t('users.google.disconnect_success')
  end
end
