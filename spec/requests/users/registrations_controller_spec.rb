require 'rails_helper'

RSpec.describe "Users::RegistrationsController", type: :request do
  before do
    @request = ActionDispatch::TestRequest.create
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "POST #create" do
    context "with invalid parameters" do
      it "renders the new template with errors" do
        post user_registration_path, params: { user: attributes_for(:user, email: '') }
        expect(response.body).to include("Sign up")
      end
    end
  end
end
