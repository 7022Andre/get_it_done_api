require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user) }
  let(:list) { create(:list, user_id: user.id) }
  let(:item) { create(:item, list_id: list.id) }

  describe "attributes" do
    it "has body" do
      expect(item).to have_attributes(body: item.body)
    end

    it "belongs to list" do
      expect(item.list_id).to be(list.id)
    end
  end

  describe "invalid item" do
    let(:invalid_item_no_body) { build(:item, body: "", list_id: item.list_id) }
    let(:invalid_item_no_list) { build(:item) }

    it "should be invalid because of empty body" do
      expect(invalid_item_no_body).to_not be_valid
    end

    it "should be invalid because of undefined list id" do
      expect(invalid_item_no_list).to_not be_valid
    end
  end
end
