source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby               '2.6.5'

gem 'bootsnap',           '>= 1.4.2', require: false
gem 'carrierwave',        '~> 2.0'
gem 'config'
gem 'damerau-levenshtein'
gem 'draper'
gem 'fog-aws'
gem 'haml'
gem 'jbuilder',           '~> 2.7'
gem 'mini_magick'
gem 'pg',                 '1.2.3'
gem 'puma',               '~> 4.1'
gem 'rails',              '~> 6.0.3', '>= 6.0.3.4'
gem 'rails-i18n'
gem 'sass-rails',         '>= 6'
gem 'simple_form'
gem 'sorcery'
gem 'turbolinks',         '~> 5'
gem 'webpacker',          '~> 4.0'
gem 'whenever',           require: false

group :development, :test do
  gem 'byebug',            platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails' ,     require: 'dotenv/rails-now'
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'letter_opener'
  gem 'rails-controller-testing'
  gem 'rspec-rails',              '~> 4.0.1'
  gem 'shoulda-matchers',         '~> 4.0'
end

group :development do
  gem 'listen',                   '~> 3.2'
  gem 'rubocop',                  '0.54.0', require: false
  gem 'spring'
  gem 'spring-watcher-listen',    '~> 2.0.0'
  gem 'web-console',              '>= 3.3.0'
end

group :test do
  gem 'capybara',                 '>= 2.15'
  gem 'capybara-screenshot'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
