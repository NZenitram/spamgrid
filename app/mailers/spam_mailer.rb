require 'csv'
class SpamMailer < ApplicationMailer

  def test_multi_send(file_name)
    email = []
    CSV.foreach("tmp/#{file_name}", headers: true) do |row|
      email << row[1]
    end
      mail( :to => email,
            :from => 'spamgrid@gmail.com',
            :subject => 'Thanks for signing up!')
  end
end
