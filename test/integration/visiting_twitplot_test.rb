require File.expand_path(File.dirname(__FILE__)+'/../test_helper')

class VisitingTwitplotTest < ActionController::IntegrationTest
  # Replace this with your real tests.
  test "visiting / and clicking search" do
    visit '/'
    assert_have_selector 'div#about'
    assert_have_selector 'div#results'
    assert_have_selector "form[action='/search']"
    assert_have_selector "form input#location[name='location'][type='text'][value='Boulder, Co']"
    assert_have_selector "form input#keyword[name='keyword'][type='text']"
    assert_have_selector "form select#distance[name='distance']"
    [10,25,50].each do |miles|
      assert_have_selector "form select#distance option[value='#{miles}']:contains('#{miles}')"
    end

    assert_have_selector "form input[type='submit'][name='commit'][value='search']"

    click_button 'search'
    puts response_body
  end
end
