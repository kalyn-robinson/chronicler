class CreateSheets < ActiveRecord::Migration[5.1]
  def change
    create_table :sheets do |t|
      t.string :name
      t.text :properties
      t.string :avatar

      t.timestamps
    end
  end
end
