class UsersController < ApplicationController
  before_action :authenticate_user!

  def disconnect_google
    current_user.update(provider: nil, uid: nil)
    redirect_to mypages_top_path, notice: 'Googleアカウントの連携を解除しました。'
  end
end
