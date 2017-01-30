# frozen_string_literal: true
#
# Project controller
#
class ProjectsController < ApplicationController
  before_action :authorize

  def index
    @projects = Project.all
  end

  def new
    @action = projects_path
    @method = 'post'
    @project = Project.new
  end

  def show
    project
  end

  def edit
    @action = project_path project
    @method = 'put'
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_url
    else
      render 'new'
    end
  end

  def update
    if project.update_attributes(project_params)
      redirect_to projects_url
    else
      render 'edit'
    end
  end

  def versions
    render json: project.list_versions
  end

  def errors
    []
  end

  private

  def project
    @project ||= Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :bucket_name, :region)
  end
end
