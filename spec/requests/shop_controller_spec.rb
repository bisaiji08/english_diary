# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShopController, type: :controller do
  let(:user) { create(:user) }
  let(:item) { create(:item) }

  before do
    sign_in user
  end

  describe I18n.t('rspec.actions.get_index') do
    it I18n.t('rspec.assigns_items_available') do
      get :index
      expect(assigns(:japanese_fonts)).not_to be_nil
      expect(assigns(:english_fonts)).not_to be_nil
    end
  end

  describe I18n.t('rspec.actions.post_purchase') do
    context I18n.t('rspec.contexts.sufficient_points') do
      it I18n.t('rspec.processes_purchase_redirects') do
        user.tree.update(points: item.price)
        post :purchase, params: { id: item.id }
        expect(flash[:notice]).to eq(I18n.t('shop.purchase.success', name: item.name))
        expect(response).to redirect_to(shop_index_path)
      end
    end

    context I18n.t('rspec.contexts.insufficient_points') do
      it I18n.t('rspec.does_not_process_purchase_redirects_with_alert') do
        user.tree.update(points: 0)
        post :purchase, params: { id: item.id }
        expect(flash[:alert]).to eq(I18n.t('shop.purchase.insufficient_points'))
        expect(response).to redirect_to(shop_path(item))
      end
    end
  end
end
