FactoryGirl.define do
  factory :event do |event|
    event.name            {Faker::Name.name}
    event.category        {Faker::Space.agency_abv}
    event.user_id         user
    event.unique_event_id {Faker::Number.number(10)}

  end
end
