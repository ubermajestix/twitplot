ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'webrat'
require 'webrat/selenium'

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
  module ActionController #:nodoc:
    IntegrationTest.class_eval do
      include Webrat::Selenium::Methods
      include Webrat::Selenium::Matchers
    end
  end
end

Webrat.configure do |config|
  if ENV['SELENIUM']
    module ActionController #:nodoc:
      IntegrationTest.class_eval do
        include Webrat::Selenium::Methods
        include Webrat::Selenium::Matchers
      end
    end
    config.mode = :selenium
  else
    config.mode = :rails
  end
end


