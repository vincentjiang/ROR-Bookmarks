class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
    	t.integer :user_id
    	t.integer :category_id
    	t.string :name
    	t.string :url
    	t.string :avatar
      t.timestamps
    end
  end
end
