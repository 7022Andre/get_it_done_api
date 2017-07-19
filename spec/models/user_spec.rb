require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "attributes" do
    it "has an email address" do
      expect(user).to have_attributes(email: user.email)
    end
  end

  describe "invalid user" do
    let(:user_with_invalid_email) { build(:user, email: "") }
    let(:user_with_invalid_password) { build(:user, password: "") }

    it "should be invalid due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end

    it "should be invalid due to too short password" do
      expect(user_with_invalid_password).to_not be_valid
    end
  end
end
