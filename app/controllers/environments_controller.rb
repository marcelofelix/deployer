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

  private

  def project
    @project ||= Project.find(params[:project_id])
  end

  def environment_params
    params.require(:environment).permit(:name, :version, :bucket_name)
  end
end
