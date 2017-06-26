class Character < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 255 }
  
  default_scope -> { order(created_at: :desc) }
end
