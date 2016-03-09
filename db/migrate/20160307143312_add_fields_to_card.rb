class AddFieldsToCard < ActiveRecord::Migration
  def change
    add_column :cards, :stripe_card_id, :string
    add_column :cards, :card_brand, :string
    add_column :cards, :card_last_4, :string
  end
end
