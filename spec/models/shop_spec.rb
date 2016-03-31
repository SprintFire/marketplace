require 'rails_helper'

RSpec.describe Shop, type: :model do
  it "has a valid factory" do
    expect(build(:shop)).to be_valid
  end

  describe "Validation Test" do
    it "is invalid without a name" do
      expect(build(:shop, name: nil)).not_to be_valid
    end
    it "is invalid without a description" do
      expect(build(:shop, description: nil)).not_to be_valid
    end
    it "is invalid without an email_id" do
      expect(build(:shop, email_id: nil)).not_to be_valid
    end
  end

  describe "Length Test" do
    it "name attribute" do
      should validate_length_of(:name).is_at_least(2).on(:create)
    end
    it "description attribute" do
      should validate_length_of(:description).is_at_least(10)
    end
  end
end
