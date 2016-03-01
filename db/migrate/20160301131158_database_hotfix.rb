class DatabaseHotfix < ActiveRecord::Migration
  def change
    remove_column :products, :quantity
    add_column :products, :quantity, :interger # Need to validate as positive interger

    remove_column :shops, :contact_phone
    add_column :shops, :contact_phone, :char(20)

  end
end
