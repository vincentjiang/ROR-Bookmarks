class UsersAPI < Grape::API
	namespace :users do
		
		helpers do
			def user_params
				params.symbolize_keys
			end
		end

		desc "create a account"
    params do
      requires :username, type: String, desc: "user name"
      requires :email, type: String
      requires :password, type: String, desc: "password"
    end
		post :create  do
			user = User.create(user_params)
			present user, with: UserEntity
		end
	end
end