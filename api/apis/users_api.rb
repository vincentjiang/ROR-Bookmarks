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
			user_check_name = User.where(username: params[:username])
			user_check_email = User.where(email: params[:email])
			if user_check_name.blank? && user_check_email
				user = User.create(user_params)
				present user, with: UserEntity
			else
				msg = "邮箱已被注册" if user_check_email.present?
				msg = "用户名已被注册" if user_check_name.present?
				present :msg, msg
			end
		end
	end
end