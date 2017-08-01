require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  let(:user) { create(:user) }

  describe "user logged in" do
    login_user

    it "returns list of users" do
      get :index
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("get_users")
    end

    it "can create user" do
      post :create, params: { user: { email: "mytestuser@api.com", password: "password" } }
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("create_user")
    end

    it "can delete user" do
      delete :destroy, params: { id: user.id }
      expect(response).to have_http_status(200)
    end

    it "receives 404 when trying to delete non-existent user" do
      delete :destroy, params: { id: 0 }
      expect(response).to have_http_status(404)
    end
  end

  describe "user not logged in" do
    context "returns error 401" do
      it "when trying to get users index" do
        get :index
        expect(response).to have_http_status(401)
      end

      it "when trying to create user" do
        post :create, params: { user: user }
        expect(response).to have_http_status(401)
      end

      it "when trying to delete user" do
        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(401)
      end
    end
  end
end
