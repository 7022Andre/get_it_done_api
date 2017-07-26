require 'rails_helper'

RSpec.describe Api::ListsController, type: :controller do
  describe "user logged in" do
    login_user

    it "can create list" do
      post :create, params: { user_id: 1, list: { title: "My test list", public: false } }
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("create_list")
    end
  end

  describe "user not logged in" do
    it "returns error 401 when trying to create list" do
      post :create, params: { user_id: 1, list: { title: "My test list", public: false } }
      expect(response).to have_http_status(401)
    end
  end
end
