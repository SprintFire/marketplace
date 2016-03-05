class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, :unique => true, :null => false, :index => true
      t.timestamps null: false
    end
  end
end
