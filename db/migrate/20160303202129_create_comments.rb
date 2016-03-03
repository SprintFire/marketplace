class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :star_rating
      t.text :body
      t.references :user, :null => false
      t.references :product, :null => false
      t.timestamps null: false
    end
  end
end
