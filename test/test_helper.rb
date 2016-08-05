ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require 'minitest/autorun'
require 'support/database_cleaner'
require 'minitest/rg'
require 'shoulda-matchers'
require "minitest/rails/capybara"
require 'simplecov'
require 'mocha/mini_test'
require 'minitest/rails/capybara'
require 'active_support/testing/assertions'
require "minitest/rails/capybara"
require "rails/test_help"
include ActiveSupport::Testing::Assertions
require 'simplecov'
require 'rails_helper.rb'
SimpleCov.start 'rails' unless ENV['NO_COVERAGE']
#rails g minitest:feature ProductShow

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]
# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  fixtures :all
  include ApplicationHelper
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # Add more helper methods to be used by all tests here...
end
class Capybara::Rails::TestCase
 include Devise::Test::IntegrationHelpers
 include Capybara::DSL
 include Capybara::Assertions
 fixtures :all
end


class ActionController::TestCase
  include Devise::Test::ControllerHelpers
  CarrierWave.root = 'test/fixtures/images'
  def is_logged_in?
    !session[:user_id].nil?
  end

class CarrierWave::Mount::Mounter
  def store!
    # Not storing uploads in the tests
  end
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
