source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Rails framework
gem 'rails', '~> 6.0.0'

# PostgreSQL database adapter
gem 'pg', '>= 0.18', '< 2.0'

# Puma web server
gem 'puma', '~> 3.11'

# JSON API builder
gem 'jbuilder', '~> 2.7'

# JWT authentication
gem 'jwt'

gem 'kaminari'

# Use bcrypt for password hashing
gem 'bcrypt', '~> 3.1.7'

# Bootsnap for faster boot times
gem 'bootsnap', '>= 1.4.2', require: false

# Test dependencies
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'minitest'
  gem 'minitest-rails'
  gem 'minitest-reporters'
end


# Ensure timezone data is available on Windows
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem 'rspec-rails', '~> 4.0.0'
  gem 'factory_bot_rails', '~> 6.1.0'
end
group :test do
  gem 'shoulda-matchers', '~> 4.0'
  gem 'database_cleaner-active_record'
end

gem 'faker'
gem 'ransack'
gem 'jsonapi-serializer'