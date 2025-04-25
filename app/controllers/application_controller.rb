class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include LegacyParamsConcern
  
  # If using Devise
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  # Strong parameters for Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email])
  end
  
  # Patch for handling old render :text usage
  def render_text(text)
    render plain: text
  end
end