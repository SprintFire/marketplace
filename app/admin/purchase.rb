ActiveAdmin.register Purchase do

  index do
    selectable_column
    id_column
    column :user_id
    column :product_id
    column :created_at
    column :updated_at
    column :price
    column :quantity
    column :stripe_charge_id
    actions
  end

  filter :id
  filter :user_id
  filter :product_id
  filter :price
  filter :quantity
  filter :stripe_charge_id

  show :title => :id do
    attributes_table do
      row :id
      row :user_id
      row :product_id
      row :created_at
      row :updated_at
      row :price
      row :quantity
      row :stripe_charge_id
    end

    panel "Product Information" do
      table_for purchase.product do |product|
        column("Product ID", :sortable => :id) {|product| link_to "##{product.id}", admin_product_path(product.id) }
        column("Product Name") {|product| product.name}
        column("Listed Date", :sortable => :created_at){|product| pretty_format(product.created_at) }
        column("Update Date", :sortable => :updated_at){|product| pretty_format(product.updated_at) }
        column("Current Price") {|product| number_to_currency product.price}
        column("From Shop") {|product| link_to product.shop.name, admin_shop_path(product.shop)}
      end
    end
  end

end
