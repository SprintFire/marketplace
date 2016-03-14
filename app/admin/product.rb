ActiveAdmin.register Product do
  permit_params :title, :content

  show do
    attributes_table do
      row :title
      row :content
      table_for post.categories.order('title ASC') do
        column "Categories" do |category|
          link_to category.title, [ :admin, category ]
        end
      end
    end
  end

end
