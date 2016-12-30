FactoryGirl.define do
  factory :upload do |upload|
    upload.name {Faker::Name.name}
    upload.url  {Faker::Internet.url}
    user
  end
end
