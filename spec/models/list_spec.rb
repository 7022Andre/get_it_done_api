require 'rails_helper'

RSpec.describe List, type: :model do
  let(:user) { create(:user) }
  let(:list) { create(:list, user: user) }

  describe "attributes" do
    it "has title" do
      expect(list).to have_attributes(title: list.title, user: user)
    end

    it "is public by default" do
      expect(list.public).to be(true)
    end
  end

  describe "invalid list" do
    let(:invalid_list) { build(:list, user: nil) }

    it "should be invalid because of empty user attribute" do
      expect(invalid_list).to_not be_valid
    end
  end
end
