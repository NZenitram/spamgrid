class SessionsController < ApplicationController

  def create
    user = User.find_by(uid: user_credentials.uid)
    if User.exists?(uid: user_credentials.uid)
      session[:user_id] = user.id
      redirect_to root_path
    else
      user = User.from_omniauth(user_credentials)
      session[:user_id] = user.id
      UserNotifierMailer.send_signup_email(user).deliver
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
    attr_reader :user_credentials

  def user_credentials
    env["omniauth.auth"]
  end
end
