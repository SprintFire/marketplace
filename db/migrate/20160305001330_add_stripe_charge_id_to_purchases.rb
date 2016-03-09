class AddStripeChargeIdToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :stripe_charge_id, :string
  end
end
