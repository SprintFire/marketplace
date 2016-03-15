ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :last_sign_in_at
    column :sign_in_count
    column :last_sign_in_ip
    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :created_at
  filter :last_sign_in_at
  filter :sign_in_count

  show :title => :email do
    attributes_table do
      row :id
      row :email
      row :first_name
      row :last_name
      row :created_at
      row :updated_at
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :sign_in_count
    end

    panel "Shops" do
      table_for user.shops.all.each do |shop|
        column("Shop ID", :sortable => :id) {|shop| link_to "##{shop.id}", admin_shop_path(shop.id)}
        column("Name") {|shop| shop.name}
        column("Description") {|shop| shop.description}
        column("Created at") {|shop| shop.created_at}
        column("Updated at") {|shop| shop.updated_at}
      end
    end

    panel "Purchase History" do
      table_for user.purchases.all.each do |order|
        column("Order ID", :sortable => :id) {|order| link_to "##{order.id}", admin_purchase_path(order.id) }
        column("Product") {|order| order.product.name}
        column("From Shop") {|order| order.product.shop.name}
        column("Date", :sortable => :created_at){|order| pretty_format(order.created_at) }
        column("Quantity")  {|order| order.quantity}
        column("Total") {|order| number_to_currency order.price }
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :first_name
      f.input :last_name
    end
    f.actions
  end

end
