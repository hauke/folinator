class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user! unless Rails.env.test?

  helper_method :development_or_test_mode?

protected

  def development_or_test_mode?
    Rails.env.development? || Rails.env.test?
  end
end
