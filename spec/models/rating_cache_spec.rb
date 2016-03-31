require 'rails_helper'

RSpec.describe RatingCache, type: :model do
  describe "Association Test" do
    it { should belong_to(:cacheable) }
  end
end
