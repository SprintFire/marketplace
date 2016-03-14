ActiveAdmin.register Withdrawal do
  permit_params :shop_id, :amount, :approved

  index do
    selectable_column
    id_column
    column :shop_id
    column :amount
    column :approved
    column :created_at
    column :updated_at
    actions
  end

  filter :id
  filter :shop_id
  filter :amount
  filter :approved
  filter :created_at
  filter :updated_at

  show :title => :id do
    attributes_table do
      row :id
      row :shop_id
      row :amount
      row :approved
      row :created_at
      row :updated_at
    end

    active_admin_comments

  end
end
