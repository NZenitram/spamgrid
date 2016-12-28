class UserNotifierMailer < ApplicationMailer
  default :from => 'spamgrid@example.com'

  array = ["a@sink.sendgrid.net","b@sink.sendgrid.net", "c@sink.sendgrid.net"]

  def send_signup_email(user)
    @user = user
    mail( to: @user.email_address,
          :subject => 'Thanks for signing up!')
  end

  def test_spam
    mail( to: array,
          :subject => 'Thanks for signing up!')
  end
end
