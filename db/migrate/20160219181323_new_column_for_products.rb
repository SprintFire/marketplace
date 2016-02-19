class NewColumnForProducts < ActiveRecord::Migration
	def change
		add_column :products, :quantity, :numeric
	end
end
