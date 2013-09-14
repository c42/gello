class HomeController < ApplicationController
  def index
    if user_signed_in?
      user = current_user_with_access_token
      @repos = []#user.repos
      @avatar_url = ""#user.avatar_url
    end
  end
end
