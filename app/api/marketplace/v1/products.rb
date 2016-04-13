class Marketplace::V1::Products < Grape::API
  resource :products do
    desc "List all products"
    get do
      Product.all
    end

    desc "return the information of a product"
    params do
      requires :id, type: Integer, desc: "product id"
    end

    route_param :id do
      get do
        Product.find(params[:id])
      end

      delete do
        authenticate!
        Product.delete(params[:id])
      end

      resource :comments do
        desc "get the comments"
        get do
          Commontator_comments.where(thread_id: params[:id]).all
        end
      end

      resource :edit do
        desc "edit the product"
        params do
          requires :id, type: Integer, desc: "product id"
          optional :name, type: String, desc: "name of the product"
          optional :price, type: Float, desc: "price of the product"
          optional :quantity, type: Integer, desc: "quantity of the product"
          optional :description, type: String, desc: "description of the product"
          optional :category_id, type: Integer, desc: "category id of the product"
        end

        put do
          authenticate!
          product = Product.find(params[:id])
          if product.update(params)
            present product
          else
            render_401_error(product)
          end
        end
      end # resource :edit
    end # route_param :id
  end # resource :products
end
