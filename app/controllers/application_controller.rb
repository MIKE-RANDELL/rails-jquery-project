class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  #before_action :sign_up_admin_only, only: [:new], if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :role])
  end

  #def sign_up_admin_only
    #current_user.try(:admin?)
  #end
end
