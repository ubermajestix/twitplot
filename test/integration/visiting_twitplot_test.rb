require File.expand_path(File.dirname(__FILE__)+'/../test_helper')

class VisitingTwitplotTest < ActionController::IntegrationTest
  test "visiting / displays displays the default search options" do
    form_selector = "div#search_form form[action='/search']"

    visit '/'
    assert_have_selector 'div#about'
    assert_have_selector 'div#results'
    assert_have_selector "#{form_selector}"
    assert_have_selector "#{form_selector} input#location[name='location'][type='text']"
    assert_have_selector "#{form_selector} input#keyword[name='keyword'][type='text']"
    assert_have_selector "#{form_selector} select#distance[name='distance']"
    [10,25,50].each do |miles|
      assert_have_selector "#{form_selector} select#distance option[value='#{miles}']:contains('#{miles}')"
    end

    assert_have_selector "#{form_selector} input[type='submit'][name='commit'][value='search']"

    click_button 'search'
  end
end
