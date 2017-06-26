require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  def setup
    @user = users(:yakisoba)
    @character = @user.characters.build(name: 'Nigiri')
  end

  test 'should be valid' do
    assert @character.valid?
  end

  test 'name should be present' do
    @character.name = nil
    assert_not @character.valid?
  end

  test 'name should be at most 255 characters' do
    @character.name = 'a' * 256
    assert_not @character.valid?
  end

  test 'order should be most recent first' do
    assert_equal characters(:california), Character.first
  end
end
