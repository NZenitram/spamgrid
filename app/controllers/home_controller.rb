class HomeController < ApplicationController

  def show
    # @uploads = current_user.uploads
  end

  def spam
    file_name = params[:upload][:name]
    SpamMailer.test_multi_send(file_name).deliver_now
    redirect_to root_path
  end

  def sign_up
    HomeHelper.scrape_keys
    redirect_to root_path
  end
end
