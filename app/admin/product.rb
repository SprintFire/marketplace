ActiveAdmin.register Product do
  permit_params :name, :description, :price, :quantity, :category_id, :shop_id

end
