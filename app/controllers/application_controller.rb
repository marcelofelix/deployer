class ApplicationController < ActionController::Base
  unless Rails.env.test?
    before_filter :authenticate
    protect_from_forgery

  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == Figaro.env.user && password == Figaro.env.password
    end
  end
end
