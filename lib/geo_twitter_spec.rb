require 'geo_twitter'

describe GeoTwitter do
  it "should geocode with success" do
    GeoTwitter.geo_locate("Boulder, CO").class.should == Hash
  end
  
  it "should return post from twitter for location" do
      results = GeoTwitter.geocode(:lat=>"40.0104920", :lng=>"-105.2768430",:distance=>"10")
      results.class.should == Twitter::Search
  end
  
  it "should raise error if no location given to geocode" do
      lambda{results = GeoTwitter.geocode(:distance=>"10")}.should raise_error
  end
  
  it "should raise error if no location given to geocode_and_keyword" do
      lambda{results = GeoTwitter.geocode_and_keyword(:distance=>"10")}.should raise_error
  end
  
  it "should raise error if no keyword given to geocode_and_keyword" do
      lambda{results = GeoTwitter.geocode_and_keyword(:lat=>"40.0104920", :lng=>"-105.2768430",:distance=>"10")}.should raise_error
  end
  
  it "should raise error if no location given to keyword" do
      lambda{results = GeoTwitter.keyword(); puts results.inspect}.should raise_error
  end
  
  it "should return tweets for keyword search" do
      results = GeoTwitter.keyword(:keyword=>"boom")
  end
  
  it "should return tweets for geocode and keyword search" do
      results = GeoTwitter.geocode_and_keyword(:lat=>"40.0104920", :lng=>"-105.2768430",:distance=>"10", :keyword=>"boom")
  end
  
  it "should return an array for all posts including time info" do
       results = GeoTwitter.all_posts(:location=>"Boulder, Co")
       results.class.should == Array
       results.first.class.should == Array
       results[1].class.should == String
   end
end
