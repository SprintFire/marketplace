class DatabaseHotfix < ActiveRecord::Migration
  def change
    change_column :products, :quantity, :integer # Need to validate as positive interger

    change_column :shops, :contact_phone, "char(20)"

  end
end
