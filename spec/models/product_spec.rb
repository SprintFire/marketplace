require 'rails_helper'

RSpec.describe Product, type: :model do
  it "has a valid factory" do
    expect(build(:product)).to be_valid
  end

  describe "Validation Test" do
    it "is invalid without a name" do
      expect(build(:product, name: nil)).not_to be_valid
    end
    it "is invalid without a price" do
      expect(build(:product, price: nil)).not_to be_valid
    end
    it "is invalid without a quantity" do
      expect(build(:product, quantity: nil)).not_to be_valid
    end
    it "is invalid without a description" do
      expect(build(:product, description: nil)).not_to be_valid
    end
    it "is invalid without a category" do
      expect(build(:product, category: nil)).not_to be_valid
    end
  end

  describe "Length Test" do
    it "name attribute" do
      should validate_length_of(:name).is_at_least(2).on(:create)
    end
    it "description attribute" do
      should validate_length_of(:description).is_at_least(2).on(:create)
    end
  end

  describe "Association Test" do
    it { should belong_to(:shop) }
    it { should belong_to(:category) }
    it { should have_many(:purchases) }
  end
end
