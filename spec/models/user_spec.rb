require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User model" do
    it "has a valid factory" do
      expect(build(:user)).to be_valid
    end
  end # describe

  context "Validation tests of" do
    describe "account information" do
      it "is invalid without an email address" do
        expect(build(:user, email: nil)).not_to be_valid
      end

      it "is invalid without a first name" do
        expect(build(:user, first_name: nil)).not_to be_valid
      end

      it "is valid without a last name" do
        expect(build(:user, last_name: nil)).to be_valid
      end

      it "is invalid if the password is less than 6 characters" do
        should validate_length_of(:password).is_at_least(6).on(:create)
      end

      it "is invalid if the password is more than 20 characters" do
        should validate_length_of(:password).is_at_most(20).on(:create)
      end
    end # describe
  end # context
end
