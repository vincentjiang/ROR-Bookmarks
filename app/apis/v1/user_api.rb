class V1::UserApi < Grape::API
  resources :users do
    desc '注册用户'
    params do
      requires :email, type: String, regexp: User::EMAIL_REGEX, desc: "邮箱"
      requires :username, type: String, regexp: User::USERNAME_REGEX, desc: "用户名"
      requires :password, type: String, regexp: User::PASSWORD_REGEX, desc: "密码"
      requires :password_confirmation, type: String, regexp: User::PASSWORD_REGEX, desc: "确认密码"
    end
    post do
      user = User.new(declared(params))
      if user.save
        UserMailer.activate_account(user).deliver_later
        present user, with: V1::Entities::User
      else
        error!(user.errors.full_messages, 422)
      end
    end

    desc '激活用户'
    params do
      requires :email, type: String, regexp: User::EMAIL_REGEX, desc: "用户的邮箱"
      requires :activate_code, type: String, desc: "用户的激活码"
    end
    get 'activate' do
      user = User.find_by(email: params[:email])
      if user && user.activate_code == params[:activate_code] && !user.activated?
        token = user.generate_token
        user.update(token: token, activated_at: DateTime.now)
        UserMailer.welcome(user).deliver_later
        present user, with: V1::Entities::User
      else
        error!("Activate fail", 422)
      end
    end

    desc '获取忘记密码token'
    params do
      requires :email, type: String, regexp: User::EMAIL_REGEX, desc: "用户的邮箱"
    end
    get 'find_password' do
      user = User.where(email: params[:email]).first
      if user
        reset_password_token = user.generate_reset_password_token()
        user.update(reset_password_token: reset_password_token, reset_password_at: 2.hours.from_now)
        present :reset_password_token, reset_password_token
        present :expired_at, 2.hours.from_now.to_s(:db)
      else
        error!("not exist email", 404)
      end
    end

    desc '重置密码'
    params do
      requires :reset_password_token, type: String, desc: "重置密码需要的token"
      requires :password, type: String, desc: "密码"
    end
    patch 'reset_password' do
      user = User.where(reset_password_token: params[:reset_password_token]).first
      if user && user.reset_password_at.to_i >= Time.now.to_i
        if user.update(password: params[:password])
          user.update(reset_password_at: DateTime.now)
          status 200
          present :success, true
        else
          error!(user.errors.full_messages, 422)
        end
      else
        error!("invalid reset password token", 400)
      end
    end

  end

  resource :user do
    desc '查询用户资料'
    get 'info' do
      authenticate_user!
      present current_user, with: V1::Entities::User
    end

    desc '更新用户资料'
    params do
      requires :sexy, type: Integer, values: [0, 1], desc: "0代表男，1表示女"
      requires :birthday, type: Date, desc: "用户的生日日期"
    end
    patch 'update_info' do
      authenticate_user!
      if current_user.update(declared(params))
        present current_user, with: V1::Entities::User
      else
        error!(current_user.errors.full_messages, 422)
      end
    end
  end

end
