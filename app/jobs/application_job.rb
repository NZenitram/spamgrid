require 'csv'
class ApplicationJob < ActiveJob::Base

  def create_csv
    file = Faker::Hipster.word
    CSV.open("tmp/#{file}.csv", "wb") do |csv|
      csv << ["name", "email"]
      10.times do |n|
        csv << [Faker::Name.name, "#{n}@sink.sendgrid.net"]
      end
    end
  end

  def email_list(file_name)
    email = []
    CSV.foreach("tmp/#{file_name}", headers: true) do |row|
      email << row[1]
    end
    mailer(email)
  end

  def mailer(email)
    SpamMailer.new.test_multi_send(email).deliver
  end
end
