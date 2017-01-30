# frozen_string_literal: true
# Handle action related to Deploy, list versions that can be
# deployied into a Environment and handle the process to deploy
class DeployController < ApplicationController
  before_action :authorize

  def index
    env
  end

  def deploy
    version = params.require(:version).to_s
    Deploy.new(env, version).execute
    redirect_to project_path(env.project)
  end

  private

  def env
    return unless params[:env]
    @env ||= Environment.find(params[:env])
  end
end
