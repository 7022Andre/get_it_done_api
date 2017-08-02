require 'rails_helper'

RSpec.describe Api::ItemsController, type: :controller do
  let(:user_not_logged_in) { create(:user) }
  let(:list_of_not_logged_in_user) { create(:list, user_id: user_not_logged_in.id) }
  let(:item_of_not_logged_in_user) { create(:item, list_id: list_of_not_logged_in_user.id) }

  let(:list_of_logged_in_user) { create(:list, user_id: subject.current_user.id) }
  let(:item_of_logged_in_user) { create(:item, list_id: list_of_logged_in_user.id) }

  describe "user logged in" do
    login_user

    it "can see items per list" do
      get :index, params: { list_id: list_of_logged_in_user }
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("get_items")
    end

    it "can create item" do
      post :create, params: { list_id: list_of_logged_in_user, item: { body: "My to-do-item" } }
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("create_item")
    end

    it "can update own item" do
      put :update, params: { list_id: list_of_logged_in_user, id: item_of_logged_in_user, item: { completed: true, body: "My updated item" } }
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("update_item")
    end

    it "can't update item of other user" do
      put :update, params: { list_id: list_of_not_logged_in_user, id: item_of_not_logged_in_user, item: { completed: true, body: "My updated item" } }
      expect(response).to have_http_status(403)
    end

    it "can delete own item" do
      delete :destroy, params: { id: item_of_logged_in_user }
      expect(response).to have_http_status(200)
    end

    it "can't delete item of other user" do
      delete :destroy, params: { id: item_of_not_logged_in_user }

      expect(response).to have_http_status(200)
    end
  end

  describe "user not logged in" do
    it "returns error 401 when trying to create item" do
      post :create, params: { list_id: list_of_not_logged_in_user.id, item: { body: "My to-do-item" } }
      expect(response).to have_http_status(401)
    end
  end
end
