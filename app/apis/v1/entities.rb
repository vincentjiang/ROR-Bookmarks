module V1
  module Entities
    class User < Grape::Entity
      expose :id, :email, :username, :sexy, :birthday
      expose :token
      expose :activate_code
      expose :created_at do |user, options|
        user.created_at.to_s(:db)
      end
      expose :updated_at do |user, options|
        user.updated_at.to_s(:db)
      end
      expose :activated_at do |user, options|
        user.activated_at.to_s(:db) if user.activated_at.present?
      end
    end
  end
end
