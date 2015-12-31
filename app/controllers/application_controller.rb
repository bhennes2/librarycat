class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :only_allow_devise_login

  def only_allow_devise_login
    if params[:controller].include?('devise')
      redirect_to root_url, alert: 'You cannot access that page.' unless controller_name === 'sessions'
    end
  end

end
