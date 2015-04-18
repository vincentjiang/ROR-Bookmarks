class UserEntity < Grape::Entity
	expose :id, :username, :email, :avatar, :sex, :birthday

end