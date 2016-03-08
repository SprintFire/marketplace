ActiveAdmin.register Shop do
  permit_params :name, :description, :facebook_url, :twitter_username, :instagram_username, :contact_phone, :email_id, :longitude, :latitude, :profile_image, :header_image

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :user_id
    column :facebook_url
    column :twitter_username
    column :instagram_username
    column :contact_phone
    column :email_id
    column :longitude
    column :latitude
    actions
  end

  filter :name
  filter :description
  filter :contact_phone
  filter :email_id
  filter :created_at

  show :title => :name do
    attributes_table do
      row :name
      row :description
      row :user_id
      row :facebook_url
      row :twitter_username
      row :instagram_username
      row :contact_phone
      row :email_id
      row :longitude
      row :latitude
      row :profile_image
      row :header_image
      row :created_at
      row :updated_at
    end

    panel "Products" do
      table_for shop.products.all.each do |product|
        column("Product ID", :sortable => :id) {|product| link_to "##{product.id}", admin_product_path(product.id) }
        column("Product Name") {|product| product.name}
        column("Listed Date", :sortable => :created_at){|product| pretty_format(product.created_at) }
        column("Update Date", :sortable => :updated_at){|product| pretty_format(product.updated_at) }
        column("Quantity")  {|product| product.quantity}
        column("Price") {|product| number_to_currency product.price }
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Shop Details" do
      f.input :name
      f.input :description
      f.input :facebook_url
      f.input :twitter_username
      f.input :instagram_username
      f.input :contact_phone
      f.input :email_id
      f.input :longitude
      f.input :latitude
    end
    f.actions
  end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
