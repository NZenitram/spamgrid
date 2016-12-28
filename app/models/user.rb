class User < ApplicationRecord
  validates_presence_of :provider, :name, :oauth_expires_at, :uid, :oauth_token
  validates_uniqueness_of :uid, :oauth_token

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider         = auth.provider
      user.uid              = user.uid
      user.name             = auth.info.name
      user.email_address    = auth.info.email
      user.oauth_token      = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
