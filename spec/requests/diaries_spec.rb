# frozen_string_literal: true

require 'rails_helper'

RSpec.describe I18n.t('rspec.controllers.diaries'), type: :request do
  let(:user) { create(:user) }
  let(:diary) { create(:diary, user: user) }

  before do
    sign_in user
  end

  describe I18n.t('rspec.actions.get_index') do
    it I18n.t('rspec.returns_user_diaries') do
      get diaries_path
      expect(response).to have_http_status(:ok)
      expect(assigns(:diaries)).to eq(user.diaries)
    end
  end

  describe I18n.t('rspec.actions.post_create') do
    context I18n.t('rspec.contexts.valid_parameters') do
      it I18n.t('rspec.creates_new_diary') do
        expect do
          post diaries_path, params: { diary: attributes_for(:diary) }
        end.to change(Diary, :count).by(1)
        expect(response).to redirect_to(diary_path(Diary.last))
      end
    end

    context I18n.t('rspec.contexts.invalid_parameters') do
      it I18n.t('rspec.renders_new_template') do
        post diaries_path, params: { diary: attributes_for(:diary, title: nil) }
        expect(response).to render_template(:new)
      end
    end
  end
end
