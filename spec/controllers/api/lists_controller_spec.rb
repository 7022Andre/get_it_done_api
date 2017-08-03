require 'rails_helper'

RSpec.describe Api::ListsController, type: :controller do
  let(:user_not_logged_in) { create(:user) }
  let(:list_of_not_logged_in_user) { create(:list, user_id: user_not_logged_in.id) }

  let(:list_of_logged_in_user) { create(:list, user_id: subject.current_user.id) }

  describe "user logged in" do
    login_user

    it "can create list" do
      post :create, params: { user_id: subject.current_user, list: { title: "My test list" } }
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("create_list")
    end

    it "can see public lists of other user" do
      get :index, params: { user_id: user_not_logged_in }
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("get_lists")
    end

    it "can't see private list of other user" do

    end

    it "can update own list" do
      put :update, params: { user_id: subject.current_user, id: list_of_logged_in_user, list: { public: false, title: "My new List title" } }
      expect(response).to have_http_status(200)
      expect(response.body).to match_response_schema("update_list")
    end

    it "can't update list of another user" do
      put :update, params: { user_id: user_not_logged_in, id: list_of_not_logged_in_user, list: { public: false, title: "My new List title" } }
      expect(response).to have_http_status(403)
    end

    it "can delete own list" do
      delete :destroy, params: { user_id: subject.current_user, id: list_of_logged_in_user }
      expect(response).to have_http_status(200)
    end

    it "can't delete list of another user" do
      put :destroy, params: { user_id: user_not_logged_in, id: list_of_not_logged_in_user }
      expect(response).to have_http_status(403)
    end

    it "receives 404 when trying to delete non-existent list" do
      delete :destroy, params: { user_id: subject.current_user, id: 99 }
      expect(response).to have_http_status(404)
    end
  end

  describe "user not logged in" do
    context "returns error 401" do
      it "when trying to create list" do
        post :create, params: { user_id: user_not_logged_in, list: { title: "My test list" } }
        expect(response).to have_http_status(401)
      end

      it "when trying to see list for specific user" do
        get :index, params: { user_id: user_not_logged_in }
        expect(response).to have_http_status(401)
      end
    end
  end
end
