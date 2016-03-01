class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user, :null => false
      t.references :product, :null => false
      t.integer :star_rating
      t.text :comment
      t.timestamps null: false
    end
  end
end
