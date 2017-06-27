class Sheet < ApplicationRecord
  serialize :properties, Hash

  has_many :character_sheets
  has_many :characters, through: :character_sheets
end
