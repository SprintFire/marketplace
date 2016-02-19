class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
  	dashboard_path
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit :first_name, :last_name, :email, :password, :password_confirmation
      end
    end

  private

    def user_not_authorized
      flash[:error] = 'You are not authorized to perform this action.'
      redirect_to(request.referrer || root_path)
    end
  
end
