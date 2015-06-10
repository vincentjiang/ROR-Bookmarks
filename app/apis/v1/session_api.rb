class V1::SessionApi < Grape::API
  resources :sessions do
    desc '登录用户'
    params do
      requires :email, type: String, regexp: User::EMAIL_REGEX, desc: "用户邮箱"
      requires :password, type: String, regexp: User::PASSWORD_REGEX, desc: "用户密码"
    end
    post do
      user = User.where(email: params[:email]).first
      if user && user.activated? && user.authenticate(params[:password])
        status 200
        present :token, user.token
      else
        error!("wrong username or password", 401)
      end
    end
  end
end
