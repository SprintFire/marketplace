class FixColumnNameOfReviews < ActiveRecord::Migration
  def change
    rename_column :reviews, :product_id, :item_id
  end
end
