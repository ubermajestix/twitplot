class HomeController < ApplicationController
  layout "standard"
  def index
     session[:results] = nil
     @location = session[:location] || "Boulder, Co"
  end
  
  def search  
    session[:location] = params[:location]
    @location = params[:location]
    @loc = Georb.geocodr(params[:location])
    @distance = params[:distance]
  
    if session[:results]
      @results = []
      results = Twitter::Search.new.geocode("#{@loc.lat}", "#{@loc.lng}", "#{@distance}mi")
      results.each{|r| @results << r unless session[:results].include?(r.text)}
      session[:results] = @results.map(&:text) + session[:results]
    end
    unless @results
      @results = Twitter::Search.new.geocode("#{@loc.lat}", "#{@loc.lng}", "#{@distance}mi").per_page(25)
      session[:results] = @results.map(&:text)
    end
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
end
