class Marketplace::V1::Users < Grape::API
  resource :users do
    desc "List all users"
    get do
      User.all
    end

    resource :auth do
      desc 'Provide token via basic authentication.'
      params do
        requires :email,    type: String, desc: 'Email'
        requires :password, type: String, desc: 'Password'
      end

      post :sign_in do
        user = User.find_by(email: params[:email])
        if user.present? && user.valid_password?(params[:password])
          { token: TokenProvider.generate_token(user_id: user.id), user: user }
        else
          error!({ error_code: 404, error_message: 'Invalid email or password.' }, 401)
        end
      end

      desc 'Register user and return user object, access token'
      params do
        requires :first_name, type: String, desc: 'First name'
        requires :last_name,  type: String, desc: 'Last name'
        requires :email,    type: String, desc: 'Email'
        requires :password, type: String, desc: 'Password'
      end

      post :sign_up do
        user = User.new(
          first_name: params[:first_name],
          last_name:  params[:last_name],
          password: params[:password],
          email:    params[:email]
        )

        if user.save
          { token: TokenProvider.generate_token(user_id: user.id), user: user }
        else
          error!({ error_code: 404, error_message: 'Invalid email or password.' }, 401)
        end
      end

      desc "Get token using Oauth provider's credentials."
      params do
        requires :auth, type: Hash do
          requires :provider, type: String
          requires :uid, type: String

          requires :info, type: Hash do
            requires :email, type: String
            requires :name, type: String
            optional :image, type: String
          end

          requires :credentials, type: Hash do
            requires :token, type: String
            requires :expires_at, type: Integer
            requires :expires, type: Boolean
          end
        end
      end

      post :social_sign_in do
        error!('Token Validation Failed', 401) unless OauthTokenValidator.new(params[:auth]).valid?

        user = User.from_omniauth(params[:auth])

        if user.present?
          { token: TokenProvider.generate_token(user_id: user.id), user: user }
        else
          error!('Unauthorized', 401)
        end
      end
    end # resource :auth

    desc "return the information of a user"
    params do
      requires :id, type: Integer, desc: "user id"
    end

    route_param :id do
      get do
        User.find(params[:id])
      end
    end
  end # resource :users
end
