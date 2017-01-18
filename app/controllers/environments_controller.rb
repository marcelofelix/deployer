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
    @replce.environment = environment
    if @replace.save
      render json: @replace
    else
    end
  end

  def show
    @env = Environment.find(params[:id])
    render json: environment, include: [:replaces]
  end

  private

  def environment
    @env = Environment.find(params[:id])
  end

  def project
    @project ||= Project.find(params[:project_id])
  end

  def environment_params
    params.require(:environment).permit(:name, :version, :bucket_name)
  end
end
