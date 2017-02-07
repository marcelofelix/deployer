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

  def destroy
    env.destroy
    redirect_to project_path env.project
  end

  def show
    env
    @replace = Replace.new
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
