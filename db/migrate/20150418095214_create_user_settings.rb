class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
    	t.integer :user_id
    	t.boolean :auto_backup
      t.timestamps
    end
  end
end
