class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def create
    Project.create(project_params)
    redirect_to 'index'
  end

  private

  def project_params
    params.require(:project).permit(:name, :bucket_name)
  end
end
