module AuthHelper
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      request.headers.merge!(user.create_new_auth_token)
      sign_in user
    end
  end
end
