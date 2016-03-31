require 'rails_helper'

RSpec.describe Withdrawal, type: :model do
  describe "Association Test" do
    it { should belong_to(:shop) }
  end
end
