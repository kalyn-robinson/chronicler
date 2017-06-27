class Character < ApplicationRecord
  include ActiveModel::Validations
  acts_as_paranoid
  
  belongs_to :user
  has_one :character_sheet
  has_one :sheet, through: :character_sheet
  accepts_nested_attributes_for :character_sheet, update_only: true
  
  validates :name, presence: true, length: { maximum: 255 }
end
