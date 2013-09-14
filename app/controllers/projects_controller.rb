class ProjectsController < ApplicationController
  def show
    @project = Project.find_or_fetch(params[:handle], params[:repository])
    p 11, @project, 22
  end
end
