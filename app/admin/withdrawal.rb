ActiveAdmin.register Withdrawal do
  permit_params :approved

  index do
    selectable_column
    id_column
    column :shop_id
    column :amount_decimal
    column :approved
    column :created_at
    column :updated_at
    actions
  end

  filter :id
  filter :shop_id
  filter :amount_decimal
  filter :approved
  filter :created_at
  filter :updated_at

  show :title => :id do
    attributes_table do
      row :id
      row :shop_id
      row :amount_decimal
      row :approved
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Withdrawal Details" do
      f.input :approved
    end
    f.actions
  end
end
