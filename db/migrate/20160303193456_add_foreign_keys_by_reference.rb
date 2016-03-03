class AddForeignKeysByReference < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.references :user
      t.references :product
      end
  end
end
