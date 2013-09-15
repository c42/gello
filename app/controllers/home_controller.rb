class HomeController < ApplicationController
  def index
    if user_signed_in?
      user = current_user_with_access_token
      repos = user.all_repos_with_issues
      @managed, @unmanaged = repos.partition {|r| Project.where(github_path: r.full_name).exists?}
      render "repositories", layout: "application_internal"
    else
      render "landing_page"
    end
  end
end
