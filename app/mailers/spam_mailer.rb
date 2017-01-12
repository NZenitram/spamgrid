require 'csv'
class SpamMailer < ApplicationMailer

  def test_multi_send(file_name)
    s3 = AWS::S3.new
    obj = s3.buckets['spamgrid'].objects["#{file_name}"]
    File.open("tmp/#{file_name}", "wb") do |file|
      obj.read do |chunk|
        file.write(chunk)
      end
    end
    email = []
    CSV.foreach("tmp/#{file_name}", headers: true) do |row|
      email << row[1]
    end
      mail( :to => email,
            :from => 'spamgrid@gmail.com',
            :subject => 'Thanks for signing up!')

    sleep 2
    delete_file(file_name)
  end

  def delete_file(file_name)
    File.delete("tmp/#{file_name}")
  end
end
