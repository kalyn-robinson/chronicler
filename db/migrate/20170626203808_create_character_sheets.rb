class CreateCharacterSheets < ActiveRecord::Migration[5.1]
  def change
    create_table :character_sheets do |t|
      t.text :properties
      
      t.references :character, foreign_key: true
      t.references :sheet, foreign_key: true

      t.timestamps
    end
  end
end
