require 'rails_helper'

RSpec.describe AverageCache, type: :model do
  describe "Association Test" do
    it { should belong_to(:rater).class_name('User') }
    it { should belong_to(:rateable) }
  end
end
