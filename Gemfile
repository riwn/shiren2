source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', group: [:development, :test]
gem 'mysql2', group: :production
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
#gem 'duktape'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Get Public Image Gem
gem 'font-awesome-rails'

# Image Upload
gem 'carrierwave'
gem 'mini_magick'
gem 'fog-aws'

# jQuery
gem "jquery-rails"

# 管理画面
gem 'rails_admin', '~> 1.3'
gem 'devise'
gem 'cancancan'

#日本語化
gem 'rails-i18n'

#デザイン
gem 'bootstrap', '~> 4.3.1'

#ページネーション
gem 'kaminari'

#デバッグ用
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'ruby-debug-ide'
  gem 'debase'
  gem 'timecop'
end

gem 'rails_12factor', group: :production

# 環境変数管理
gem 'dotenv-rails'

# WYSIWYGエディタ
gem 'trix'

# アナリティクス
gem 'google-analytics-rails'

# Twitter
gem 'twitter'

# DoS攻撃対策
gem 'rack-attack'

# SEO対策
gem 'meta-tags'
gem 'sitemap_generator'
gem 'aws-sdk'

#　定時処理
gem 'whenever', require: false