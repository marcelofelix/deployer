# Environment controller
class EnvironmentsController < ApplicationController
  def create
    @env = Environment.new(environment_params)
    @env.project = project
    if @env.save
      render 'index'
    else
      respond_to do
        format.html
        format.json { render json: @env.errors.messages }
      end
    end
  end

  def add_replace
    replace_param = params.require(:replace).permit(:file, :key, :value)
    @replace = Replace.new(replace_param)
    @replace.environment = environment
    if @replace.save
      render json: @replace
    else
    end
  end

  def remove_replace
    replace = Replace.find(params[:id])
    replace.delete
  end

  def destroy
    environment.destroy
  end

  def deploy
    version = params.require(:version).to_s
    deploy = Deploy.new(environment, version)
    deploy.download
    deploy.replace
    deploy.upload
  end

  def show
    render json: environment, include: [:replaces]
  end

  private

  def environment
    @env ||= Environment.find(params[:id])
  end

  def project
    @project ||= Project.find(params[:project_id])
  end

  def environment_params
    params.require(:environment).permit(:name, :version, :bucket_name)
  end
end
