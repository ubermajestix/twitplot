# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  TWITTER_URL = "http://search.twitter.com/search.atom?geocode="
  include GeoKit
  include GeoKit::Geocoders
  #include AuthenticatedSystem
  require 'open-uri'
  require 'hpricot'
  include Georb
  require 'cgi'
  require 'twitter'
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => 'c2871d0217de834fe3d00ad24ff07727'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
