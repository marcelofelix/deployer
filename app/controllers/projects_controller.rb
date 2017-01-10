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
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @project }
    end
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      render json: @project
    else
      render json: { errors: @project.errors.messages }, status: 422
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :bucket_name)
  end
end
