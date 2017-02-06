# frozen_string_literal: true
# Environment controller
class EnvironmentsController < ApplicationController
  before_action :authorize

  def new
    @env = Environment.new
  end

  def edit
    env
  end

  def create
    @env = Environment.new(environment_params)
    @env.project = project
    if @env.save
      redirect_to project_path project
    else
      render 'new'
    end
  end

  def update
    if env.update_attributes(environment_params)
      redirect_to project_path(env.project)
    else
      render 'edit'
    end
  end

  def add_replace
    replace_param = params.require(:replace).permit(:file, :key, :value)
    @replace = Replace.new(replace_param)
    @replace.environment = env
    if @replace.save
      redirect_to environment_path(env)
    else
      render 'show'
    end
  end

  def remove_replace
    replace = Replace.find(params[:id])
    replace.delete
    redirect_to project_environment_path(replace.project, replace.environment)
  end

  def destroy
    env.destroy
    redirect_to project_path env.project
  end

  def show
    env
    @replace = Replace.new
  end

  def path
    return project_environments_path(project, env) unless env.id
    return project_environments_path(project, env) if env.id
  end

  private

  def env
    @env ||= Environment.find(params[:id])
  end

  def project
    @project ||= Project.find(params[:project_id])
  end

  def environment_params
    params.require(:environment).permit(:name, :bucket_name, :region)
  end
end
