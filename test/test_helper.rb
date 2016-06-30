ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"
require 'minitest/autorun'
require 'support/database_cleaner'
require 'minitest/rg'
require 'shoulda-matchers'
require "minitest/rails/capybara"
require 'simplecov'
require 'mocha/mini_test'
require 'minitest/rails/capybara'

SimpleCov.start 'rails' unless ENV['NO_COVERAGE']
Minitest::Reporters.use!
# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
 include Capybara::DSL
 include Capybara::Assertions
  fixtures :all
end
class ActionController::TestCase
  include Devise::TestHelpers
  def is_logged_in?
    !session[:user_id].nil?
  end

    # Logs in a test user.
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, session: { email:       user.email,
                                  password:    password,
                                  remember_me: remember_me }
    else
      session[:user_id] = user.id
    end
  end
end
