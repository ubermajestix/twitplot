ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'spec'

class Test::Unit::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

if ENV['SELENIUM']
  require 'webrat/selenium'
  Webrat.configuration.application_port = 4567
  Webrat.configuration.application_environment = 'test'
  Webrat.configuration.mode = :selenium
else
  require 'webrat/rails'
  Webrat.configuration.mode = :rails
end
