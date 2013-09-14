class HomeController < ApplicationController
  def index
    @octokit_user_name = []
    @octokit_issues = []
    if user_signed_in?
      begin
        client = Octokit::Client.new(access_token: session["devise.github_access_token"])
        @octokit_user_name = client.user.name
        @octokit_issues = client.list_issues("c42/gello-spikes")
      rescue Exception => e
        flash[:error] = "Octokit blew up: #{e.class.name}"
        sign_out
      end
    end
  end
end
