class CharacterSheet < ApplicationRecord
  serialize :properties, Hash

  # def valid_properties
  #   sheet.properties.each do |key, value|
  #     CharacterSheet.validates(, { length: { minimum: 5 } })
  #   end

  #   # self.validates(:gnosis, @properties[:gnosis])
  # end
  
  belongs_to :character
  belongs_to :sheet

  validate :valid_properties, on: :update

  def valid_properties
    sheet.properties.each do |key, value|
      # Validate presence.
      if value[:presence] && properties[key].blank?
        errors.add(key, "must not be blank.")
      elsif !value[:presence] && properties[key].blank?
        return true
      end

      # Validate type.
      if value.include?(:type)
        eval("#{value[:type]}(#{properties[key]})") rescue errors.add(key, "must be a(n) #{value[:type]}")
      end
    end
  end
end
