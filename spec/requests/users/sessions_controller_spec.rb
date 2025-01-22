require 'rails_helper'

RSpec.describe "Users::SessionsController", type: :request do
  before do
    @request = ActionDispatch::TestRequest.create
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "POST #create" do
    let(:user) { create(:user) }

    context "with invalid credentials" do
      it "renders the new template with errors" do
        post user_session_path, params: { user: { email: user.email, password: 'wrongpassword' } }
        expect(response.body).to include("Invalid Email or password.")
      end
    end
  end
end
