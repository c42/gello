class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def github_access_token
    session["devise.github_access_token"]
  end
end
