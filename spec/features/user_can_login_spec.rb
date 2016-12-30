require 'rails_helper'

describe 'user visits root' do
  scenario 'they can log in' do
    stub = stub_omniauth
    user = User.create!(provider: stub.provider, uid: stub.uid, name: stub.info.name, email_address: stub.info.email, oauth_token: stub.credentials.token, oauth_expires_at: Time.at(stub.credentials.expires_at))
    upload = Upload.create!(name: Faker::Name.name, url: Faker::Internet.url, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'
    expect(page).to have_content("Sign Out")
  end
end
