class VersionsController < ApplicationController
  def create
    @version = Version.new(version_params)
    @version.project = project
    if @version.save
      redirect_to 'index'
    else
      respond_to do
        format.html
        format.json { render json: @version.errors.messages }
      end
    end
  end

  private

  def project
    @project ||= Project.find(params[:project_id])
  end

  def version_params
    params.permit(:name)
  end
end
