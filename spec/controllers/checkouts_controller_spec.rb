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
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST#checkout_current_card" do
    it "processes charge from current card" do
      charge = Stripe::Charge.create({
      customer: 'John',
      amount: 20,
      currency: 'eur'})
      expect(charge.customer).to eq('John')
      expect(charge.amount).to eq(20)
      expect(charge.currency).to eq('eur')
    end

    it "redirects back when an error is encountered" do
      expect { Stripe::Charge.create(customer: 'Brian',amount: 1, currency: 'eur') }.to_not raise_error {|e|
        expect(e).to be_a StandardError
        expect(response).to redirect_to(root_path)
      }
    end

    it "raises an error for an unrecognized card error code" do
      expect { StripeMock.prepare_card_error(:non_existant_error_code) }.to raise_error {|e|
        expect(e).to be_a(StripeMock::StripeMockError)
      }
    end

    it "checks if the record is saved to database" do
      # expect {
      #   cards = create(:card, :user => subject.current_user)
      # }.to change { Card.count }

      expect { Stripe::Charge.create(customer: 'Brian',amount: 1, currency: 'eur') }.to eq(stripe_customer_id)
    end
  end

  describe "POST#checkout_new_card" do
    it "creates a stripe customer" do
      customer = Stripe::Customer.create({
        email: 'johnny@appleseed.com',
        card: stripe_helper.generate_card_token
      })
      expect(customer.email).to eq('johnny@appleseed.com')
    end

    it "processes charge from new card" do
      charge = Stripe::Charge.create({
        customer: 'test',
        amount: 20,
        description: 'Marketplace customer',
        currency:'eur'
      })
    end

    it "redirects back when an error is encountered" do
      expect { Stripe::Charge.create(customer: 'Darren',amount: 10, currency: 'eur') }.to_not raise_error {|e|
        expect(e).to be_a StandardError
        expect(response).to redirect_to(root_path)
      }
    end

    it "raises an error for an unrecognized card error code" do
      expect { StripeMock.prepare_card_error(:non_existant_error_code) }.to raise_error {|e|
        expect(e).to be_a(StripeMock::StripeMockError)
      }
    end

    it "checks if the record is saved to database" do
      expect {
        cards = create(:card, :user => subject.current_user)
      }.to change { Card.count }
    end
  end
end
