class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user! unless Rails.env.test?

  helper_method :development_mode?

protected

  def development_mode?
    Rails.env.development?
  end
end
