class User < ActiveRecord::Base
  has_secure_password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  USERNAME_REGEX = /\A[a-zA-Z0-9]{6,20}\z/i
  PASSWORD_REGEX = /\A(?=.*[A-Z])(?=.*\d)(?!.*(.)\1\1)[a-zA-Z0-9@]{6,12}\z/

  validates :email, :username, uniqueness: true
  validates :email, format: { with: EMAIL_REGEX, on: :create } # 邮箱创建时需要验证，创建后不能修改
  validates :username, format: { with: USERNAME_REGEX, on: :create }
  validates :password, format: { with: PASSWORD_REGEX, on: :create }

  before_create :generate_activate_code

  def generate_token
    JWT.encode({ user_id: id }, ENV["token_key"])
  end

  def reset_token!
    generate_token
  end

  # 用户
  def activated?
    activate_code.present? && activated_at.present?
  end

  # 生成32位随机字符串的激活码
  def generate_activate_code
    self.activate_code = ([*('a'..'z'),*('A'..'Z'),*('0'..'9')]-%w(0 1 I O L i o l)).sample(32).join
  end

end
