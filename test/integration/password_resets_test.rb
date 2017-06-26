require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:yakisoba)
  end

  test 'expired token' do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path,
         params: { password_reset: { name: @user.name } }
    assert_redirected_to root_url
    @user = assigns(:user)
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(@user.reset_token),
          params: { name: @user.name,
                    user: { password:              'foobar',
                            password_confirmation: 'foobar' } }
    assert_response :redirect
    follow_redirect!
    assert_match /expired/i, response.body
  end

  test 'password resets' do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Invalid name
    post password_resets_path, params: { password_reset: { name: '' } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Valid name
    post password_resets_path,
         params: { password_reset: { name: @user.name } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Password reset form
    user = assigns(:user)
    # Wrong name
    get edit_password_reset_path(user.reset_token, name: '')
    assert_redirected_to root_url
    # Right name, wrong token
    get edit_password_reset_path('wrong token', name: user.name)
    assert_redirected_to root_url
    # Right name, right token
    get edit_password_reset_path(user.reset_token, name: user.name)
    assert_template 'password_resets/edit'
    assert_select 'input[name=name][type=hidden][value=?]', user.name
    # Invalid password & confirmation
    patch password_reset_path(user.reset_token),
          params: { name: user.name,
                    user: { password:              'foobaz',
                            password_confirmation: 'barquux' } }
    assert_select 'div#error_explanation'
    # Empty password
    patch password_reset_path(user.reset_token),
          params: { name: user.name,
                    user: { password:              '',
                            password_confirmation: '' } }
    assert_select 'div#error_explanation'
    # Valid password & confirmation
    patch password_reset_path(user.reset_token),
          params: { name: user.name,
                    user: { password:              'foobaz',
                            password_confirmation: 'foobaz' } }
    assert is_logged_in?
    assert_nil user.reload.reset_digest
    assert_not flash.empty?
    assert_redirected_to user
  end
end