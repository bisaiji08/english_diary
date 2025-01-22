require 'rails_helper'

RSpec.describe 'Diaries', type: :request do
  let(:user) { create(:user) }
  let(:diary) { create(:diary, user: user) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'returns a list of diaries for the current user' do
      get diaries_path
      expect(response).to have_http_status(:ok)
      expect(assigns(:diaries)).to eq(user.diaries)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new diary' do
        expect {
          post diaries_path, params: { diary: attributes_for(:diary) }
        }.to change(Diary, :count).by(1)
        expect(response).to redirect_to(diary_path(Diary.last))
      end
    end

    context 'with invalid parameters' do
      it 'renders the new template' do
        post diaries_path, params: { diary: attributes_for(:diary, title: nil) }
        expect(response).to render_template(:new)
      end
    end
  end
end
