class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter CASClient::Frameworks::Rails::Filter

  def current_user
    user ||= Unirole::User.where(login: session[:login]).first if session[:login]
    user ||= Unirole::User.new
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self, root_url)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, alert: exception.message
  end
end
