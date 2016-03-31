require 'rails_helper'

RSpec.describe Card, type: :model do
  context "Association test of" do
    describe "relationships" do
      it "belongs to user" do
        should belong_to(:user)
      end
    end # describe
  end # context
end
