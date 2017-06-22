require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @yakisoba = users(:yakisoba)
    @hibachi = users(:hibachi)
  end

  test 'index including pagination' do
    log_in_as(@yakisoba)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

  test 'index as admin including pagination and delete links' do
    log_in_as(@yakisoba)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @yakisoba
        assert_select 'a[href=?]', user_path(user), text: 'Delete' if !user.deleted_at?
        assert_select 'a[href=?]', user_path(user), text: 'Restore' if user.deleted_at?
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@hibachi)
    end
  end

  test 'index as non-admin' do
    log_in_as(@hibachi)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end