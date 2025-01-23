# frozen_string_literal: true

class ShopController < ApplicationController
  def index
    purchased_items = current_user.purchases.pluck(:item_id)
    @japanese_fonts = Item
                      .where(language: 'Japanese')
                      .where.not(id: purchased_items)
                      .where.not(font_name: ['Noto Sans JP'])

    @english_fonts = Item
                     .where(language: 'English')
                     .where.not(id: purchased_items)
                     .where.not(font_name: ['Noto Sans'])
  end

  def show
    @item = Item.find(params[:id])
  end

  def purchase
    @item = Item.find(params[:id])
    @tree = current_user.tree

    # 重複購入チェック
    if current_user.purchases.exists?(item: @item)
      redirect_to shop_index_path, alert: 'You already own this item.'
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
      redirect_to shop_path(@item), alert: 'Not enough points to purchase this item.'
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to shop_path(@item), alert: "Purchase failed: #{e.message}"
  end
end
