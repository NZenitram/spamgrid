FactoryGirl.define do
  factory :user do |user|
    user.provider         {Faker::Company.name}
    user.uid              {Faker::Crypto.md5}
    user.name             {Faker::Name.name}
    user.oauth_token      {Faker::Crypto.md5}
    user.oauth_expires_at {Faker::Time.between(DateTime.now - 1, DateTime.now)}
  end
end
