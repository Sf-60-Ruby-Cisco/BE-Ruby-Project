source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "rails", "~> 7.0.3"

gem "sprockets-rails"

gem "pg", "~> 1.1"

gem 'rspec-rails'

gem 'slim-rails'

gem 'devise'

gem "image_processing", ">= 1.2"

gem 'money-rails', '~>1.12'

gem 'kaminari'

gem 'bootstrap5-kaminari-views'

gem "chartkick"

gem "groupdate"

gem 'rails-i18n', '~> 7.0.0'

gem 'devise-i18n'

gem "puma", "~> 5.0"

gem "importmap-rails"

gem "turbo-rails", github: "hotwired/turbo-rails", branch: "turbo-7-2-0"

gem "stimulus-rails"

gem "jbuilder"

gem "tzinfo-data"

gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
  gem 'rails-controller-testing'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end

group :development do
  gem "web-console"
end

