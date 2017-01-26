# Handle action related to Deploy, list versions that can be
# deployied into a Environment and handle the process to deploy
class DeployController < ApplicationController
  def index
    env
  end

  def deploy
    version = params.require(:version).to_s
    Deploy.new(env, version).execute
    redirect_to project_path(env.project)
  end

  private

  def project
    return unless params[:project_id]
    @project ||= Project.find(params[:project_id])
  end

  def env
    return unless params[:env]
    @env ||= Environment.find(params[:env])
  end
end
