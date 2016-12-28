require "rails_helper"

RSpec.describe UserNotifierMailer, type: :mailer do
  describe 'signup mailer' do

    user = stub_omniauth

    let(:user) {mock_model User, name: user.info.name, email: "testmail@mymailaddress.com"}
    let(:mail) {UserNotifierMailer.send_signup_email(user).deliver}

    it 'renders the subject' do
      expect(mail.subject).to eq('Thanks for signing up!')
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['spamgrid@example.com'])
    end
  end
end
