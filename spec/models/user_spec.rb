require 'rails_helper'

RSpec.describe User, type: :model do
  context "invalid attributes" do
    it "is invalid without a uid" do
      user = User.new(provider: Faker::Company.name, uid: nil,
                      name: Faker::Name.name,
                      oauth_token: Faker::Crypto.md5,
                      oauth_expires_at: Faker::Time.between(DateTime.now - 1, DateTime.now))

      expect(user).to be_invalid
    end

    it "is innvalid without a provider" do
      user = User.new(provider: nil, uid: Faker::Crypto.md5,
                      name: Faker::Name.name,
                      oauth_token: Faker::Crypto.md5,
                      oauth_expires_at: Faker::Time.between(DateTime.now - 1, DateTime.now))

      expect(user).to be_invalid
    end

    it "is innvalid without a name" do
      user = User.new(provider: Faker::Company.name, uid: Faker::Crypto.md5,
                      name: nil,
                      oauth_token: Faker::Crypto.md5,
                      oauth_expires_at: Faker::Time.between(DateTime.now - 1, DateTime.now))

      expect(user).to be_invalid
    end

    it "is innvalid without a oauth_token" do
      user = User.new(provider: Faker::Company.name, uid: Faker::Crypto.md5,
                      name: Faker::Name.name,
                      oauth_token: nil,
                      oauth_expires_at: Faker::Time.between(DateTime.now - 1, DateTime.now))

      expect(user).to be_invalid
    end

    it "is innvalid without a oauth_expires_at" do
      user = User.new(provider: Faker::Company.name, uid: Faker::Crypto.md5,
                      name: Faker::Name.name,
                      oauth_token: Faker::Crypto.md5,
                      oauth_expires_at: nil)

      expect(user).to be_invalid
    end
  end
end
