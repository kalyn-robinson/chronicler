class CharacterValidator < ActiveModel::Validator
  def validate(character)
    unless character.name.starts_with? 'X'
      character.errors[:name] << 'Need a name starting with X please!'
    end
  end
end