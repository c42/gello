class HomeController < ApplicationController
  def index
    if user_signed_in?
      user = current_user_with_access_token
      @repos = user.repos_with_issues
      @organizations = user.organizations
      render "repositories", layout: "application_internal"
    else
      render "landing_page"
    end
  end
end
