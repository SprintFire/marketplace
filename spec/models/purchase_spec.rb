require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe "Association Test" do
    it { should belong_to(:product) }
    it { should belong_to(:user) }
  end
end
