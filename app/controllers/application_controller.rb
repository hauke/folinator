# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization :unless => :devise_controller?
  before_filter :authenticate_user!, :except => [:logout_info]
  helper_method :development_or_test_mode?

  before_filter :banned?

protected

  def development_or_test_mode?
    Rails.env.development? || Rails.env.test?
  end

  def is_admin
    return false unless current_user
    current_user.admin
  end

  def banned?
    if current_user.present? && current_user.banned?
      sign_out current_user
      flash[:error] = "Dieser Benutzer wurde blockiert, bitte kontaktieren sie den Administrator"
      root_path
    end
  end

end
