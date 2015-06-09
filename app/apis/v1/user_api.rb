class V1::UserApi < Grape::API
  resources :users do
    desc '注册用户'
    params do
      requires :email, type: String, desc: "邮箱"
      requires :username, type: String, desc: "用户名"
      requires :password, type: String, desc: "密码"
      requires :password_confirmation, type: String, desc: "确认密码"
    end
    post do
      user = User.new(email: params[:email], username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
      if user.save
        UserMailer.activate_account(user).deliver_later
        present user, with: V1::Entities::User
      else
        error!(user.errors.full_messages, 422)
      end
    end

    desc '激活用户'
    params do
      requires :email, type: String, desc: "用户的邮箱"
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
      if current_user.update(sexy: params[:sexy], birthday: params[:birthday])
        present current_user, with: V1::Entities::User
      else
        error!(current_user.errors.full_messages, 422)
      end
    end
  end

end
