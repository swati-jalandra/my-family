source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use mysql2 as the database for Active Record
gem 'mysql2'
# Heroku
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
#gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# Active admin
gem 'inherited_resources', github: 'activeadmin/inherited_resources'

gem 'activeadmin', github: 'activeadmin'  #active admin gem
# authentication
gem 'devise'
# file upload
gem 'paperclip'
# authorization
gem 'cancan' # or cancancan
gem 'draper'
gem 'pundit'
# extract files as zip
gem 'rubyzip', '>= 1.0.0' # will load new rubyzip version
gem 'zip-zip' # will load compatibility for old rubyzip API.
# implement elastic search engine
#gem 'elasticsearch-model'
#gem 'elasticsearch-rails'
# local storage
gem 'paperclip'
# cloud storage
gem 'paperclip-cloudinary'
# active admin custom theme
gem 'active_admin_theme', path: 'lib/plugins/active_admin_theme'
# get birthday
gem 'birthday'
# Use Omniauth Facebook plugin
gem 'omniauth-facebook'
# Use Omniauth Github plugin
gem 'omniauth-github'
# Use Omniauth Google plugin
gem 'omniauth-google-oauth2'
# Environment variables
gem 'dotenv-rails'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
