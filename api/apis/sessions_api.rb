class SessionsAPI < Grape::API
	
	params do
    requires :username, type: String, desc: "user name"
    requires :password, type: String, desc: "password"
  end
	post :login do
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			msg = "登录成功" 
			present :user, user, with: UserEntity
		else
			msg = "用户名或密码错误"
		end
		present :msg, msg
	end
end