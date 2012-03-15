class StaticController < ApplicationController

  skip_authorization_check

  def logout_info
  end
end
