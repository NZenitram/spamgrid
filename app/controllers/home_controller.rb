class HomeController < ApplicationController

  def spam
    UserNotifierMailer.test_spam.deliver
    redirect_to root_path
  end

  def show
  end
end
