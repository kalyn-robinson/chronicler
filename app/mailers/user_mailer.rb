class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'Chronicler Account Activation'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Chronicler Password Reset'
  end
end