class ShopController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def purchase
    @item = Item.find(params[:item_id])
    @tree = current_user.tree

    if @tree.points >= @item.price
      # ポイントを減らす
      @tree.points -= @item.price
      @tree.save!

      # 購入記録を作成
      Purchase.create!(user: current_user, item: @item)

      # 成功メッセージとリダイレクト
      redirect_to shop_index_path, notice: "You successfully purchased #{@item.name}!"
    else
      # エラーメッセージとリダイレクト
      redirect_to shop_show_path(@item), alert: "Not enough points to purchase this item."
    end
  end
end

