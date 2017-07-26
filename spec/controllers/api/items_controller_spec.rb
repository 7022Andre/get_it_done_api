require 'rails_helper'

RSpec.describe Api::ItemsController, type: :controller do
  let(:user) { create(:user, email: "mytest@email.com", password:"password", password_confirmation:"password") }
  let(:list) { create(:list, user_id: user.id) }

  describe "user logged in" do
    login_user

    it "can create item" do
      post :create, params: { list_id: list.id, item: { body: "My to-do-item" } }
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("create_item")
    end
  end

  describe "user not logged in" do
    it "returns error 401 when trying to create item" do
      post :create, params: { list_id: list.id, item: { body: "My to-do-item" } }
      expect(response).to have_http_status(401)
    end
  end
end
