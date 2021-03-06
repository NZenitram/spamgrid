require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      stub = stub_omniauth
      user = User.create!(provider: stub.provider, uid: stub.uid, name: stub.info.name, email_address: stub.info.email, oauth_token: stub.credentials.token, oauth_expires_at: Time.at(stub.credentials.expires_at))
      upload = Upload.create!(name: Faker::Name.name, url: Faker::Internet.url, user_id: user.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
