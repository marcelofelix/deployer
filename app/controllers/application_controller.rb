class ApplicationController < ActionController::Base
  unless Rails.env.test?
    # http_basic_authenticate_with name: ENV['USER'], password: ENV['PASSWORD']
  end
end
