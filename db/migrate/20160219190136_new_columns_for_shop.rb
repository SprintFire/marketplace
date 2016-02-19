class NewColumnsForShop < ActiveRecord::Migration
  def change
    add_column :shops, :facebook_url, :string
    add_column :shops, :twitter_username, :string
    add_column :shops, :instagram_username, :string
    add_column :shops, :contact_phone, :numeric
    add_column :shops, :email_id, :string
  end
end
