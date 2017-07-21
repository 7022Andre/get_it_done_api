require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe "user logged in" do
    login_user

    it "returns list of users" do
      get :index
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("get_users")
    end

    it "can create user" do
      post :create, params: { user: { email: "testuser@api.com", password: "password" } }
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("create_user")
    end
  end

  describe "user not logged in" do
    it "returns error 401 when trying to get users index" do
      get :index
      expect(response).to have_http_status(401)
    end

    it "returns error 401 when trying to create user" do
      post :create, params: { user: { email: "testuser@api.com", password: "password" } }
      expect(response).to have_http_status(401)
    end
  end
end
