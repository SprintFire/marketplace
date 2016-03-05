class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.text :description
      t.string :slug, :unique => true, :index => true
      t.timestamps null: false
    end
  end
end
