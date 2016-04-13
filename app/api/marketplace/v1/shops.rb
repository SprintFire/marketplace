class Marketplace::V1::Shops < Grape::API
  resource :shops do
    desc "List all shops"
    get do
      Shop.all
    end

    desc "return the information of a shop"
    params do
      requires :id, type: Integer, desc: "shop id"
    end

    route_param :id do
      get do
        Shop.find(params[:id])
      end

      delete do
        authenticate!
        Shop.delete(params[:id])
      end

      resource :products do
        desc "List all products in given category"
        get do
          Product.where(shop_id: params[:id]).all
        end
      end

      resource :new do
        desc "create a product in this shop"
        params do
          requires :name, type: String, desc: "name of the product"
          requires :price, type: Float, desc: "price of the product"
          requires :quantity, type: Integer, desc: "quantity of the product"
          requires :description, type: String, desc: "description of the product"
          optional :category_id, type: Integer, desc: "category id of the product"
        end

        post do
          authenticate!
          product = Product.new(
            name: params[:name],
            description: params[:description],
            price: params[:price],
            quantity: params[:quantity],
            shop_id: params[:id],
            category_id: params[:category_id] || Category.find_by(title: 'Uncategorized').id
          )
          if product.save
            present product
          else
            render_401_error(product)
          end
        end # post
      end # resource :new
    end

    resource :new do
      desc "create a new shop"
      params do
        requires :name, type: String, desc: "name of the shop"
        requires :description, type: String, desc: "description of the shop"
        requires :email_id, type: String, desc: "email address of the shop"
      end

      post do
        authenticate!
        shop = Shop.new(
          name: params[:name],
          description: params[:description],
          email_id: params[:email_id],
          user_id: current_user.id
        )
        if shop.save
          present shop
        else
          render_401_error(shop)
        end
      end
    end # resource :new

  end # resource :shops
end
