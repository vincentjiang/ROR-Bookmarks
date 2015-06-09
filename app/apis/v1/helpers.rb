module V1
  module Helpers
    def authenticate_user!
      begin
        token = request.headers["Authorization"]
        payload, _ = JWT.decode(token, ENV['token_key'])
        @current_user = User.where(id: payload["user_id"]).first
      rescue Exception => e
        puts e if Rails.env.development?
      end
      error!("unauthorized access", 401) if @current_user.nil?
    end

    def current_user
      @current_user
    end
  end
end
