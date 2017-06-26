class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.references :user, foreign_key: true
      
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :characters, [:name, :user_id, :created_at, :updated_at, :deleted_at],
                           name: :index_characters
  end
end
