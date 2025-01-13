class UsersController < ApplicationController
  before_action :authenticate_user!

  def disconnect_google
    current_user.update(provider: nil, uid: nil)
    redirect_to mypages_top_path, notice: 'Cancel linking your Google account.'
  end
end
