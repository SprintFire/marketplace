require 'rails_helper'

RSpec.describe OverallAverage, type: :model do
  describe "Association Test" do
    it { should belong_to(:rateable) }
  end
end
