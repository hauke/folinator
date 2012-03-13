class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization :unless => :devise_controller?
  before_filter :authenticate_user! 
  helper_method :development_or_test_mode?

protected

  def development_or_test_mode?
    Rails.env.development? || Rails.env.test?
  end

  def is_admin
    current_user.admin
  end
end
