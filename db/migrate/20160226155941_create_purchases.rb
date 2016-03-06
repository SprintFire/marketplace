class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :user, :null => false
      t.references :product, :null => false
      t.timestamps null: false
    end
  end
end
