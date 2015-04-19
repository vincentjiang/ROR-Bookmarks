class User < ActiveRecord::Base
	has_secure_password

	has_many :bookmarks
	has_many :categories
	has_many :user_questions
	has_one  :user_setting
end
