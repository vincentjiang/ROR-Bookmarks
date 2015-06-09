class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activate_account.subject
  #
  def activate_account(user)
    @user = user
    @greeting = "Hi, #{@user.username}, #{@user.email}, please activate your account"

    mail to: @user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    @greeting = "Hi"

    mail to: @user.email
  end
end
