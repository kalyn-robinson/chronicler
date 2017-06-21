require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = 'Chronicler'
  end

  test "should get root" do
    get root_url
    assert_response :success
    assert_select 'title', @base_title
  end

  test 'should get home' do
    get pages_home_url
    assert_response :success
    assert_select 'title', @base_title
  end

  test 'should get help' do
    get pages_help_url
    assert_response :success
    assert_select 'title', "#{@base_title} | Help"
  end

  test 'should get contact' do
    get pages_contact_url
    assert_response :success
    assert_select 'title', "#{@base_title} | Contact Us"
  end
end
