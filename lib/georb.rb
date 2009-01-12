module Georb
  # load 'vendor/plugins/geokit/lib/geo_kit/mappable.rb'
  # require 'mappable'
   include GeoKit
require 'hpricot'
require 'open-uri'
 
  def self.geocodr(address_str)
      res = Hpricot.XML(open("http://maps.google.com/maps/geo?q=#{CGI.escape(address_str)}&output=xml&key=#{GeoKit::Geocoders::google}&oe=utf-8"))
      status = ""
      res.search("code"){|d| status = d.inner_html}
      @start = GeoLoc.new
      if status == "200"
       coords = []
       res.search("coordinates"){|l| coords = l.inner_html.split(",")} 
       @start.lat = coords[1]
       @start.lng = coords[0]
       @start.success = true
       puts @start
       #@start.status = true
      end
      @start
  end
  
end