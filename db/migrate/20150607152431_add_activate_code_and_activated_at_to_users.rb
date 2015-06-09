class AddActivateCodeAndActivatedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activate_code, :string
    add_column :users, :activated_at, :datetime
  end
end
