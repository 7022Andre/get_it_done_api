require 'rails_helper'

RSpec.describe Api::ListsController, type: :controller do
  let(:user) { create(:user, email: "mytest@email.com", password:"password", password_confirmation:"password") }
  let(:list) { create(:list, user_id: user.id) }

  describe "user logged in" do
    login_user

    it "can create list" do
      post :create, params: { user_id: 1, list: { title: "My test list" } }
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("create_list")
    end

    it "can see lists for specific user" do
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("get_lists")
    end

    it "can delete list" do
      delete :destroy, params: { user_id: user.id, id: list.id }
      expect(response).to have_http_status(200)
    end

    it "receives 404 when trying to delete non-existent list" do
      delete :destroy, params: { user_id: 99, id: 99 }
      expect(response).to have_http_status(404)
    end
  end

  describe "user not logged in" do
    it "returns error 401 when trying to create list" do
      post :create, params: { user_id: 1, list: { title: "My test list" } }
      expect(response).to have_http_status(401)
    end

    it "returns error 401 when trying to delete list" do
      delete :destroy, params: { user_id: user.id, id: list.id }
      expect(response).to have_http_status(401)
    end

    it "returns error 401 when trying to see list for specific user" do
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(401)
    end
  end
end
