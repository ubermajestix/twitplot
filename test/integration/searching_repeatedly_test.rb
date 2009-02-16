if ENV['SELENIUM']
  require File.expand_path(File.dirname(__FILE__)+'/../test_helper')
  class SearchingRepeatedlyTest < ActionController::IntegrationTest
    test "visiting / and clicking search" do
      visit '/'
      click_button 'search'
      sleep 5

      fill_in 'keyword', :with => 'bike'
      click_button 'search'
      sleep 5

      fill_in 'location', :with => 'Anchorage, AK'
      fill_in 'keyword', :with => ''
      select '25'
      click_button 'search'
      sleep 5
    end
  end
end
