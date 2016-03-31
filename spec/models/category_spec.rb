require 'rails_helper'

RSpec.describe Category, type: :model do
  context "Association test of" do
    describe "relationships" do
      it "has many products" do
        should have_many(:products)
      end
    end # describe
  end # context
end
