require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @yakisoba = users(:yakisoba)
    @hibachi = users(:hibachi)
    @sushi = users(:sushi)
  end

  test 'should get new' do
    get signup_path
    assert_response :success
  end

  test 'should redirect edit when not logged in' do
    get edit_user_path(@yakisoba)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch user_path(@yakisoba), params: { user: { name: @yakisoba.name,
                                                  email: @yakisoba.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test 'should redirect edit when logged in as wrong user' do
    log_in_as(@sushi)
    get edit_user_path(@yakisoba)
    assert flash.any?
    assert_redirected_to root_url
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@sushi)
    patch user_path(@yakisoba), params: { user: { name: @yakisoba.name,
                                                  email: @yakisoba.email } }
    assert flash.any?
    assert_redirected_to root_url
  end

  test 'should not allow the admin attribute to be edited via the web' do
    log_in_as(@hibachi)
    assert_not @hibachi.admin?
    patch user_path(@hibachi), params: {
                                 user: { password:              @hibachi.password,
                                         password_confirmation: @hibachi.password,
                                         admin: true } }
    assert_not @hibachi.reload.admin?
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'User.count' do
      delete user_path(@yakisoba)
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when logged in as a non-admin' do
    log_in_as(@hibachi)
    assert_no_difference 'User.count' do
      delete user_path(@yakisoba)
    end
    assert_redirected_to root_url
  end

  test 'should redirect restore when not logged in' do
    assert_no_difference 'User.count' do
      post restore_user_path(@yakisoba)
    end
    assert_redirected_to login_url
  end

  test 'should redirect restore when logged in as a non-admin' do
    log_in_as(@hibachi)
    assert_no_difference 'User.count' do
      post restore_user_path(@yakisoba)
    end
    assert_redirected_to root_url
  end

  # test 'duplicate recovered username should be reset' do
  #   log_in_as(@yakisoba)
  #   assert_difference 'User.count', -1 do
  #     delete user_path(@hibachi)
  #   end
  #   assert_redirected_to users_url
  #   assert_difference 'User.count', 1 do
  #     post signup_path, params: {
  #                         user: { name: @hibachi.name,
  #                                 email: @hibachi.email,
  #                                 password: 'password',
  #                                 password_confirmation: 'password' } }
  #   end

  #   puts @hibachi.reload.inspect

  #   # assert_difference 'User.count', 1 do
  #   post restore_user_path(@hibachi.reload)
  #   # end
  #   assert_not_equal @hibachi.reload.name, 'Hibachi'
  # end
end
