# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TreesController', type: :request do
  let!(:user) { create(:user) }
  let!(:tree) { user.tree || create(:tree, user: user) }

  before do
    sign_in user
  end

  describe 'POST #train' do
    context 'when tree can be trained' do
      it 'trains the tree and redirects with a notice' do
        tree.update(last_trained_at: 1.day.ago)
        post '/train'
        expect(flash[:notice]).to eq('水やりが完了しました。')
        expect(response).to redirect_to(mypages_top_path)
      end
    end

    context 'when tree cannot be trained' do
      it 'redirects with an alert' do
        tree.update(last_trained_at: Time.current)
        post '/train'
        expect(flash[:alert]).to eq('今日はもう水やりはできません。')
        expect(response).to redirect_to(mypages_top_path)
      end
    end
  end
end
