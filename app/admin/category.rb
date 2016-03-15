ActiveAdmin.register Category do
  permit_params :title

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  filter :title

  form do |f|
    f.inputs "Categories" do
      f.input :title
      f.input :description
    end
    f.actions
  end

end
