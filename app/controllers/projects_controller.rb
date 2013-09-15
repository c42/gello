class ProjectsController < ApplicationController
  layout "application_internal"

  def show
    @project = Project.find_or_fetch(params[:handle], params[:repository], access_token: github_access_token)
  end
end
