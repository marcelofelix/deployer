class VersionsController < ApplicationController
  def create
    @version = Version.new(version_params)
    @version.project = project
    if @version.save
      render body: nil, status: 204
    else
      render json: @version.errors.messages
    end
  end

  def deploy
    version.deploy_to environment
    environment.save
  end

  private

  def version
    @version ||= Version.find(params[:id])
  end

  def environment
    @environment ||= Environment.find(params[:environment_id])
  end

  def project
    @project ||= Project.find(params[:project_id])
  end

  def version_params
    params.permit(:name)
  end
end
