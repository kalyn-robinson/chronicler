require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test 'layout links' do
    get root_path
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path, count: 2
    assert_select 'a[href=?]', contact_path, count: 1
    assert_select 'title', full_title

    get help_path
    assert_select 'title', full_title('Help')
    
    get contact_path
    assert_select 'title', full_title('Contact Us')
  end
end