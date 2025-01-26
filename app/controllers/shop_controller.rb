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

    if current_user.purchases.exists?(item: @item)
      redirect_to shop_index_path, alert: t('shop.purchase.already_owned')
      return
    end

    if @tree.points >= @item.price
      ActiveRecord::Base.transaction do
        @tree.points -= @item.price
        @tree.save!

        Purchase.create!(user: current_user, item: @item)
      end

      redirect_to shop_index_path, notice: t('shop.purchase.success', name: @item.name)
    else
      redirect_to shop_path(@item), alert: t('shop.purchase.insufficient_points')
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to shop_path(@item), alert: t('shop.purchase.failed', error: e.message)
  end
end
