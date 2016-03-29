require 'rails_helper'
require 'stripe_mock'

RSpec.describe CheckoutsController, type: :controller do

  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  describe "GET#new" do
    before :each do
      user = create(:user)
      sign_in user
      @shop = create(:shop, :user => user)
    end

    it "goes to the checkout page" do
      product = create(:product, shop: @shop)
      get :new, id: product.id
      cards = create(:card, :user => subject.current_user)
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST#checkout_current_card" do
    it "processes charge" do
      charge = Stripe::Charge.create({
      customer: 'test',
      amount: 20,
      currency: 'eur'})
      # expect(response).to redirect_to '?????'
      expect(charge.customer).to eq('test')
      expect(charge.amount).to eq(20)
      expect(charge.currency).to eq('eur')
    end
  end
end
