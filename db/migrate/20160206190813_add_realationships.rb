class AddRealationships < ActiveRecord::Migration
  def change
    add_reference :shops, :user, :index => true, :null => false
    add_reference :products, :user, :index => true, :null => false
  end
end
