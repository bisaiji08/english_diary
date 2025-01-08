class MypagesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_tree_exists, only: :top

  def top
    @tree = current_user.tree
    @purchased_items = current_user.purchases.includes(:item).map(&:item) # 購入したアイテム一覧
  end

  def settings
    # 特別な処理は不要、ビューを表示するだけ
  end

  private

  def ensure_tree_exists
    current_user.create_tree unless current_user.tree
  end
end
