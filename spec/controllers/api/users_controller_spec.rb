require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe "user logged in" do
    login_user

    it "returns success (200)" do
      get :index
      expect(response).to have_http_status(200)
    end

    it "returns list of users" do
      get :index
      result = JSON.parse(response.body)
      expect(result.length).to eq(1)
    end
  end

  describe "user not logged in" do
    it "returns access denied (401)" do
      get :index
      expect(response).to have_http_status(401)
    end
  end
end
