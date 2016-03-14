ActiveAdmin.register Category do
  permit_params :title

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  filter :title

  show :title => :name do
    attributes_table do
      row :title
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Shop Details" do
      f.input :title
    end
    f.actions
  end

end
