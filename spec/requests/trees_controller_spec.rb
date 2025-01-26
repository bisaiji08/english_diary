# frozen_string_literal: true

require 'rails_helper'

RSpec.describe I18n.t('rspec.controllers.trees_controller'), type: :request do
  let!(:user) { create(:user) }
  let!(:tree) { user.tree || create(:tree, user: user) }

  before do
    sign_in user
  end

  describe I18n.t('rspec.actions.post_train') do
    context I18n.t('rspec.contexts.tree_can_be_trained') do
      it I18n.t('rspec.trains_tree_redirects_with_notice') do
        tree.update(last_trained_at: 1.day.ago)
        post '/train'
        expect(flash[:notice]).to eq(I18n.t('trees.train.success'))
        expect(response).to redirect_to(mypages_top_path)
      end
    end

    context I18n.t('rspec.contexts.tree_cannot_be_trained') do
      it I18n.t('rspec.redirects_with_alert') do
        tree.update(last_trained_at: Time.current)
        post '/train'
        expect(flash[:alert]).to eq(I18n.t('trees.train.already_done'))
        expect(response).to redirect_to(mypages_top_path)
      end
    end
  end
end
