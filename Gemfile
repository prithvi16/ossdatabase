source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Best database int the world
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10'
# Auhentication
gem 'devise'
# Admin
gem 'activeadmin'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# search
gem 'ransack'

# friendly urls
gem 'friendly_id', '~> 5.4.0'

# markdown
gem "redcarpet", "~> 3.5" # A fast, safe and extensible Markdown to (X)HTML parser

# pagination
gem 'kaminari'

# Background jobs
gem 'sidekiq'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# forms
gem 'simple_form'

# Fast partials
gem "view_component"


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Rspec
  gem 'rspec-rails'
  # debugging
  gem 'pry-rails'
  # linitng
  gem 'rubocop', '~> 0.90.0', require: false
  gem "rubocop-rails"

  # Factories
  gem 'factory_bot_rails'
  # Environment variables
  gem 'dotenv-rails'
  # Mail
  gem 'mailcatcher'
  # beautify html code
  gem 'htmlbeautifier'
  # Faking stuff
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'

  gem 'rack-mini-profiler'
  # For memory profiling
  gem 'memory_profiler'

  # For call-stack profiling flamegraphs
  gem 'flamegraph'
  gem 'stackprof'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # static security analysis
  gem "brakeman"
  # better errors
  gem "better_errors"
  gem "binding_of_caller"
  # letter oepner
  gem "letter_opener"
  # Shooting N+1 queries
  gem 'bullet'
  # recorder
  gem 'heavens_door'
  # deploy
  gem 'capistrano', '~> 3.11'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
  gem 'capistrano-rails-console', require: false
end

group :test do
  # Clean database for tests
  gem 'database_cleaner-active_record'
  # One liner tests http://matchers.shoulda.io/
  gem 'shoulda-matchers'
  # Time travel in tests
  gem 'timecop'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'webdrivers'
  gem 'cuprite'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
