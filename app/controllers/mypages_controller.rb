class MypagesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_tree_exists, only: :top

  def top
    @tree = current_user.tree
  end

  private

  def ensure_tree_exists
    current_user.create_tree unless current_user.tree
  end
end
