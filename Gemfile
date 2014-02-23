source 'https://rubygems.org'

gem 'bcrypt-ruby', '~> 3.0.0'

gem 'rails', '3.2.17'

gem 'doorkeeper', '~> 0.6.7'

gem 'omniauth'
gem 'omniauth-identity'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-google-oauth2'

gem 'squeel'
gem 'quiet_assets'

gem 'openstax_utilities',  '1.0.1' 
gem 'lev', '~> 2.0.2'

gem 'jquery-rails'
gem 'jquery-ui-rails'

# API documentation
gem 'apipie-rails'
gem 'maruku'

gem 'jbuilder'

gem 'delayed_job_active_record'

gem 'sqlite3'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 2.3.1.0'
end

group :development, :test do
  gem 'debugger'
  gem 'thin'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :production do
  gem 'mysql2', '~> 0.3.11'
  gem 'unicorn'
  gem 'lograge', git: 'https://github.com/jpslav/lograge.git' # 'git@github.com:jpslav/lograge.git'
end
