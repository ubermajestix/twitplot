class HomeController < ApplicationController
  layout "standard"
  def index
     session[:results] = nil
     @location = session[:location] || "Boulder, Co"
     @keyword  = session[:keyword]
  end
  
  def search  
    session[:location] = params[:location] unless params[:location].empty?
    session[:keyword] = params[:keyword] unless params[:keyword].empty?
    
    @keyword = params[:keyword] unless params[:keyword].empty?
    @location = params[:location] unless params[:location].empty?
    @loc      = Georb.geocodr(params[:location]) unless params[:location].empty?
    @distance = params[:distance]
  
    if session[:results]
      @results = []
      results = geocode_and_keyword(@loc, @distance, @keyword ) if @keyword and @loc
      results = keyword(@keyword)                               if @keyword and not @loc
      results = geocode(@loc, @distance)                        if @loc and not @keyword
      results.each{|r| @results << r unless session[:results].include?(r.text)}
      session[:results] = @results.map(&:text) + session[:results]
    end
    
    unless @results
      @results = geocode_and_keyword(@loc, @distance, @keyword ) if @keyword and @loc
      @results = keyword(@keyword)                               if @keyword and not @loc
      @results = geocode(@loc, @distance)                        if @loc and not @keyword
      session[:results] = @results.map(&:text)
    end
    puts "=="*45
    t=[] 
    @results.each{|r| t << r}
    puts t.first.inspect
    puts "=="*45
    @tweets = 0
    @results.each{|r| @tweets += 1}
    @time = Time.now.strftime("%I:%M %p")
    render :update do |page|
        page.insert_html :top, :results, :partial => "results"
        for r in @results 
          page.visual_effect :blind_down, dom_id(r)
        end      
    end
  end
  
  # def t2d
  #   @loc = Georb.geocodr("Boulder, CO")
  #   results = []
  #   15.times do |page|
  #     results << Twitter::Search.new.geocode("#{@loc.lat}", "#{@loc.lng}", "10mi").per_page(100).page(page+1)
  #   end
  #   results.flatten!
  # 
  #   puts "=="*45
  #   # get text for each tweet
  #   @tweets = []
  #   results.each{|result| puts result.inspect; result.each{|t| @tweets << t}}
  #   puts @tweets.inspect
  #   puts "=="*45
  #   
  #   @text = @tweets.map(&:text)
  #   @first_time = @tweets.sort!{|a,b| a.created_at <=> b.created_at}.last.created_at
  #   @last_time = @tweets.first.created_at
  # 
  # end
private
  def geocode(loc, distance)
    puts "in geocode"
    Twitter::Search.new.geocode("#{loc.lat}", "#{loc.lng}", "#{distance}mi").per_page(25)
  end
  def keyword(keyword)
    puts "in keyword"
    Twitter::Search.new.containing(keyword).per_page(25)
  end
  def geocode_and_keyword(loc, distance, keyword)
    puts "doing keyword and geocode"
    Twitter::Search.new.geocode("#{loc.lat}", "#{loc.lng}", "#{distance}mi").per_page(25).containing(keyword)
  end
end
