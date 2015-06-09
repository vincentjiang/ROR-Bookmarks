class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest
      t.string :token
      t.integer :sexy
      t.date :birthday

      t.timestamps null: false
    end
  end
end
