class ShopController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def purchase
    @item = Item.find(params[:item_id]) # item_id を受け取る
    @tree = current_user.tree

    message = @tree.purchase_item(@item)

    redirect_to shop_index_path, notice: message
  end
end

