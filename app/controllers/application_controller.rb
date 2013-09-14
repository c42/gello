class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def github_access_token
    session["devise.github_access_token"]
  end
  
  def current_user_with_access_token
    current_user.tap {|u| u.access_token = github_access_token }
  end
end
