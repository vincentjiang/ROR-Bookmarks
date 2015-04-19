module SessionHelpers

	def current_user
  	@user = User.where(id: session[:user_id]).first 
  end


  def session
    env[Rack::Session::Abstract::ENV_SESSION_KEY]
  end

  def authenticate!
    error!('401 Unauthorized', 401) unless current_user
  end

end