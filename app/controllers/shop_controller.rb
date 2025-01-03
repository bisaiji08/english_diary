class ShopController < ApplicationController
  def index
    # ショップに表示するアイテムから Noto Sans 系フォントを除外
    @items = Item.where.not(font_name: ['Noto Sans', 'Noto Sans JP'])
  end

  def show
    @item = Item.find(params[:id])
  end

  def purchase
    @item = Item.find(params[:id])
    @tree = current_user.tree

    # 重複購入チェック
    if current_user.purchases.exists?(item: @item)
      redirect_to shop_index_path, alert: "You already own this item."
      return
    end

    if @tree.points >= @item.price
      ActiveRecord::Base.transaction do
        # ポイントを減らす
        @tree.points -= @item.price
        @tree.save!

        # 購入記録を作成
        Purchase.create!(user: current_user, item: @item)
      end

      # 成功メッセージとリダイレクト
      redirect_to shop_index_path, notice: "You successfully purchased #{@item.name}!"
    else
      # エラーメッセージとリダイレクト
      redirect_to shop_path(@item), alert: "Not enough points to purchase this item."
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to shop_path(@item), alert: "Purchase failed: #{e.message}"
  end
end

