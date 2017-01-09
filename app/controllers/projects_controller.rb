#
# Project controller
#
class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    respond_to do |format|
      format.html
      format.json { render json: @projects }
    end
  end

  def show
    render json: Project.find(params[:id])
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
