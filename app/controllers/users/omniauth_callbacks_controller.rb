class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Facebook'
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash[:notice] = 'Looks like you already have an account with the same email. Please login using a different method first to connect with Facebook.'
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
     # You need to implement the method below in your model (e.g. app/models/user.rb)
     @user = User.from_omniauth(request.env["omniauth.auth"])

     if @user.persisted?
       flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
       sign_in_and_redirect @user, event: :authentication
     else
       session["devise.google_data"] = request.env["omniauth.auth"]
       flash[:notice] = 'Looks like you already have an account with the same email. Please login using a different method first to connect with Google.'
       redirect_to new_user_registration_url
     end
  end

  def failure
    flash[:error] = 'Oops! Looks like something went wrong... :('
    redirect_to root_path
  end
end
