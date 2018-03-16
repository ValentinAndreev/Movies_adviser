source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.0'

# Rails
gem 'coffee-rails', '~> 4.2'
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'jbuilder', '~> 2.5'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.3'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

#Frontend
gem 'bootstrap', '~> 4.0.0.beta'
gem 'bootstrap4-kaminari-views'
gem 'devise-bootstrap-views', :git => 'https://github.com/hisea/devise-bootstrap-views', :branch => 'bootstrap4'
gem 'jquery-rails'
gem 'popper_js'
gem 'slim'

#Common
gem 'activeadmin'
gem 'devise'
gem 'trix'

#Services/API
gem 'carrierwave', '~> 1.0'
gem "fog-aws"
gem 'omniauth-google-oauth2'
gem 'themoviedb-api'

group :development, :test do
  gem 'bullet'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false, group: :test
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'rspec-rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop'
  gem 'brakeman'
  gem 'reek'
end
