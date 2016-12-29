class Upload < ApplicationRecord
  attr_reader :s3
  belongs_to :user

  def s3
    AWS::S3::Client.new(:access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])
  end

end
