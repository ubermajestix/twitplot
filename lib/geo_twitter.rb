module GeoTwitter
  require 'hpricot'
  require 'open-uri'
  require 'twitter'
  
  class << self
    
    def geo_locate(address_str)
   
      res = Hpricot.XML(open("http://maps.google.com/maps/geo?q=#{CGI.escape(address_str)}&output=xml&key=&oe=utf-8"))
      status = ""
      res.search("code"){|d| status = d.inner_html}
      @location = {} 
      if status == "200"
       coords = []
       res.search("coordinates"){|l| coords = l.inner_html.split(",")} 
       @location[:lat] = coords[1]
       @location[:lng] = coords[0]
       @location[:status] = status
      end    
      return @location
    end
  
    def geocode( opts={} )
      raise "need latitude, longitude, and a distance" unless opts[:lat] and opts[:lng] and opts[:distance]
      Twitter::Search.new.geocode("#{opts[:lat]}", "#{opts[:lng]}", "#{opts[:distance]}mi").per_page(opts[:per_page] || 25).page(opts[:page] || 1)
    end
  
    def keyword( opts={} )
      raise "need keyword" unless opts[:keyword]
      Twitter::Search.new.containing(opts[:keyboard]).per_page(opts[:per_page] || 25).page(opts[:page] || 1)
    end
  
    def geocode_and_keyword( opts={} )
      raise "need latitude, longitude, and a distance" unless opts[:lat] and opts[:lng] and opts[:distance]
      raise "need keyword" unless opts[:keyword]
      Twitter::Search.new.geocode("#{opts[:lat]}", "#{opts[:lng]}", "#{opts[:distance]}mi").per_page(opts[:per_page] || 25).containing(opts[:keyword]).page(opts[:page] || 1)
    end
    
    # returns an array with:
    # - an array of all the most recent posts for either keyword search, geolocation, or both
    # - and the time range of the tweets
    def all_posts( opts={} )
      @loc = geo_locate(opts[:location])
      results = []
      15.times do |page|
        results << geocode(:lat => @loc[:lat], :lng => @loc[:lng], :distance => (opts[:distance] || 10), :per_page=>100, :page=>page+1 ) if @loc and not opts[:keyword]
        results << keyword(:keyword=>opts[:keyword], :per_page=>100, :page=>page+1) if opts[:keyword] and not @loc
        results << geocode_and_keyword(:keyword=>opts[:keyword], :lat => @loc[:lat], :lng => @loc[:lng], :distance => (opts[:distance] || 10), :per_page=>100, :page=>page+1 ) if @loc and opts[:keyword]
      end
      results.flatten!

      # get text for each tweet
      @tweets = []
      results.each{ |result| result.each { |t| @tweets << t } }

      # get time range of tweets
      @first_time = @tweets.sort!{|a,b| a.created_at <=> b.created_at}.last.created_at
      @last_time = @tweets.first.created_at    
      return [@tweets, @first_time, @last_time]
    end
    
  end
end
