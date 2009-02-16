class HomeController < ApplicationController
  layout "standard"
  def index
     session[:results] = nil
     @location = session[:location] || "Boulder, Co"
     @keyword  = session[:keyword]
  end

  def search  
    @keyword  = params[:keyword]
    @location = params[:location]
    @distance = params[:distance]
    @loc      = Georb.geocodr(@location)

    @results = geocode_and_keyword(@loc, @distance, @keyword ) if @keyword and @loc
    @results = keyword(@keyword)                               if @keyword and not @loc
    @results = geocode(@loc, @distance)                        if @loc and not @keyword

    @time = Time.now.strftime("%I:%M %p")
    @tweets = @results.inject(0) { |sum, part| sum += 1 }

    render :update do |page|
      page << "$('results').innerHTML = '';"
      page.insert_html :top, :results, :partial => "results"
      for r in @results 
        page.visual_effect :blind_down, dom_id(r)
      end
    end
    session[:location] = @location;
  end

private
  def geocode(loc, distance)
    logger.debug "in geocode"
    Twitter::Search.new.geocode("#{loc.lat}", "#{loc.lng}", "#{distance}mi").per_page(25)
  end
  def keyword(keyword)
    logger.debug "in keyword"
    Twitter::Search.new.containing(keyword).per_page(25)
  end
  def geocode_and_keyword(loc, distance, keyword)
    logger.debug "doing keyword and geocode"
    Twitter::Search.new.geocode("#{loc.lat}", "#{loc.lng}", "#{distance}mi").per_page(25).containing(keyword)
  end
end
