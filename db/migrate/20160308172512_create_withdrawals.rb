class CreateWithdrawals < ActiveRecord::Migration
  def change
    create_table :withdrawals do |t|
      t.integer :shop_id
      t.integer :amount
      t.boolean :approved, default: false

      t.timestamps null: false
    end
  end
end
