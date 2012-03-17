# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController

  skip_before_filter :authenticate_user!
  skip_authorization_check

  before_filter :check_development_or_test_mode!

  def create
    user = User.find(params[:user_id])
    session["warden.user.user.key"] = ["User", user.id, nil]
    
    flash[:success] = "Signed in as #{user.name}"
    
    redirect_to :root
  end
  
  protected
  
  def check_development_or_test_mode!
    unless development_or_test_mode?
      flash[:error] = "not in development mode"
      redirect_to :back
    end
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

 def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.banned?
      sign_out resource
      flash[:error] = "Dieser Benutzer wurde blockiert, bitte kontaktieren sie den Administrator"
      root_path
    else
      super
    end
  end
end
