require 'test_helper'

class CharactersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @nigiri = characters(:nigiri)
    @yakisoba = users(:yakisoba)
    @hibachi = users(:hibachi)
  end

  test 'should get index' do
    get characters_path
    assert_response :success
  end

  test 'should show character' do
    get character_url(@nigiri)
    assert_response :success
  end

  test 'should get new' do
    log_in_as(@yakisoba)
    get new_character_path
    assert_response :success
  end

  test 'should redirect new when not logged in' do
    get new_character_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect create when not logged in' do
    post characters_url, params: { character: 
                                { name: @nigiri.name } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect edit when not logged in' do
    get edit_character_path(@nigiri)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch character_path(@nigiri), params: { character: 
                                            { name: @nigiri.name } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test 'should redirect edit when logged in as wrong user' do
    log_in_as(@hibachi)
    get edit_character_path(@nigiri)
    assert flash.any?
    assert_redirected_to root_url
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@hibachi)
    patch character_path(@nigiri), params: { character: 
                                            { name: @nigiri.name } }
    assert flash.any?
    assert_redirected_to root_url
  end

  test 'should create character' do
    log_in_as(@hibachi)
    assert_difference('Character.count') do
      post characters_url, params: { character: 
                                    { name: @nigiri.name } }
    end
    assert @hibachi.characters.any?
    assert_redirected_to character_url(@hibachi.characters.first)
  end

  test 'should update character' do
    log_in_as(@yakisoba)
    patch character_url(@nigiri), params: { character: 
                                            { name: 'Updated'} }
    assert_redirected_to character_url(@nigiri)
    assert_not_equal @nigiri.name, @nigiri.reload.name
  end

  test 'should destroy character' do
    log_in_as(@yakisoba)
    assert_difference('Character.count', -1) do
      delete character_url(@nigiri)
    end
    assert_redirected_to characters_url
  end
end
