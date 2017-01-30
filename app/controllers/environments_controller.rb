# Environment controller
class EnvironmentsController < ApplicationController
  before_action :authorize

  def new
    @env = Environment.new
    @action = project_environments_path(project)
    @method = 'post'
  end

  def edit
    env
    @action = project_environment_path(project, env)
    @method = 'put'
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
    @replace.save
  end

  def remove_replace
    replace = Replace.find(params[:id])
    replace.delete
  end

  def destroy
    env.destroy
  end

  def show
    env
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
