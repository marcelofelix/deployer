class VersionsController < ApplicationController
  def index
    @versions = project.versions
  end

  def sync
    @versions = project.list_versions
  end

  private

  def project
    @project ||= Project.find(params.require(:project_id))
  end
end
