class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :email

      t.string  :password_digest
      t.string  :remember_digest
      
      t.string  :reset_digest
      t.datetime  :reset_sent_at

      t.boolean :admin
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :users, :name, unique: true, where: 'deleted_at IS NULL'
    add_index :users, :deleted_at
  end
end
