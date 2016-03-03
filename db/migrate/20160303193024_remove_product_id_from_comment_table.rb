class RemoveProductIdFromCommentTable < ActiveRecord::Migration
  def change
    remove_column :comments, :product_id
  end
end
