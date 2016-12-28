require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #create" do
    it "returns http success" do
      user = request.env["omniauth.auth"]

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:found)
    end
  end

end
