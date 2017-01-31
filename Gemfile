source 'https://rubygems.org'
ruby "2.3.1"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'aws-sdk', '~> 2'
gem 'axios_rails', '~> 0.14.0'
gem 'bootstrap-sass'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.1'
gem 'sass-rails', '~> 5.0'
gem 'simplecov', :require => false, :group => :test
gem 'uglifier', '>= 1.3.0'
gem 'lodash-rails'
gem 'handlebars_assets'
gem 'figaro'
gem 'rails_12factor', group: :production
gem 'omniauth-github'
gem 'octokit'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'rb-readline'
  gem 'pry'
  gem 'pry-nav'
  gem 'factory_girl_rails'
  gem 'rubocop', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard'
  gem 'guard-livereload', '~> 2.5', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
