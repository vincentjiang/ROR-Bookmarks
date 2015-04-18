class CreateUserQuestions < ActiveRecord::Migration
  def change
    create_table :user_questions do |t|
    	t.integer :user_id
    	t.string :content
      t.timestamps
    end
  end
end
