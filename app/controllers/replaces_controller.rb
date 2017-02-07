# frozen_string_literal: true
#
# Replace controller
#
class ReplacesController < ApplicationController
  before_action :authorize

  def create
    replace_param = params.require(:replace)
                          .permit(:file, :key, :value)
    @replace = Replace.new(replace_param)
    @replace.environment = env
    if @replace.save
      redirect_to environment_path(env)
    else
      render 'environments/show'
    end
  end

  def destroy
    replace = Replace.find(params[:id])
    replace.delete
    redirect_to environment_path(replace.environment)
  end

  private

  def env
    @env ||= Environment.find(params[:id])
  end
end
