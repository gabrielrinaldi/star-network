# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem 'tailwindcss-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing'

# View components
gem 'view_component'

# Forms
gem 'simple_form'

# Icons
gem 'heroicon'

# QR Codes
gem 'rqrcode'

# Authentication
gem 'devise'
gem 'devise-two-factor'
gem 'pundit'
gem 'strong_password'

# Validation and cleanup
gem 'nilify_blanks'
gem 'validate_url'

# Sendgrid SDK
gem 'sendgrid-ruby'

# Twilio SDK
gem 'twilio-ruby'

# Email templates
gem 'mjml-rails'

# Business logic
gem 'light-service'

# Background jobs
gem 'sidekiq'
gem 'sidekiq-cron'

# HTML safety
gem 'better_html'

# HTTP client wrapper
gem 'faraday'

# HTTP client
gem 'httpx'

# Monitoring
gem 'health_check', github: 'armoryapp/health_check'

group :development do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Docker
  gem 'dockerfile-rails'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem 'rack-mini-profiler'

  # Lint and static analysis
  gem 'erb_lint', require: false
  gem 'htmlbeautifier', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-thread_safety', require: false

  # Security check
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false

  # Live reloading
  gem 'hotwire-livereload'

  # Annotate models
  gem 'annotate'

  # Annotate routes
  gem 'chusaku', require: false

  # Language servers
  gem 'solargraph', require: false
  gem 'solargraph-rails', require: false
end
