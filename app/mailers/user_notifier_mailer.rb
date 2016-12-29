require 'csv'
class UserNotifierMailer < ApplicationMailer
  default :from => 'spamgrid@example.com'

  def send_signup_email(user)
    @user = user
    mail( to: @user.email_address,
          :subject => 'Thanks for signing up!')
  end
end
