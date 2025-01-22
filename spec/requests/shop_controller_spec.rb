require 'rails_helper'

RSpec.describe ShopController, type: :controller do
  let(:user) { create(:user) }
  let(:item) { create(:item) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns items available for purchase' do
      get :index
      expect(assigns(:japanese_fonts)).not_to be_nil
      expect(assigns(:english_fonts)).not_to be_nil
    end
  end

  describe 'POST #purchase' do
    context 'with sufficient points' do
      it 'processes the purchase and redirects' do
        user.tree.update(points: item.price)
        post :purchase, params: { id: item.id }
        expect(flash[:notice]).to eq("You successfully purchased #{item.name}!")
        expect(response).to redirect_to(shop_index_path)
      end
    end

    context 'with insufficient points' do
      it 'does not process the purchase and redirects with alert' do
        user.tree.update(points: 0)
        post :purchase, params: { id: item.id }
        expect(flash[:alert]).to eq('Not enough points to purchase this item.')
        expect(response).to redirect_to(shop_path(item))
      end
    end
  end
end
