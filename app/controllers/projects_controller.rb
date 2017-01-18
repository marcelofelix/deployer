#
# Project controller
#
class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show
    project
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

  def versions
    render json: project.list_versions
  end

  private

  def project
    @project ||= Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :bucket_name)
  end
end
