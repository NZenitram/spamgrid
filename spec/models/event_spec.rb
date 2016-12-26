require 'rails_helper'

RSpec.describe Event, type: :model do
  context "invalid attributes" do
    it "is invalid without a name" do
      event = Event.new(name: nil,
                        category: Faker::Space.agency_abv,
                        user_id: create(:user),
                        unique_event_id: Faker::Number.number(10))

      expect(event).to be_invalid
    end

    it "is invalid without a category" do
      event = Event.new(name: Faker::Name.name,
                        category: nil,
                        user_id: create(:user),
                        unique_event_id: Faker::Number.number(10))

      expect(event).to be_invalid
    end

    it "is invalid without a user_id" do
      event = Event.new(name: Faker::Name.name,
                        category: Faker::Space.agency_abv,
                        user_id: nil,
                        unique_event_id: Faker::Number.number(10))

      expect(event).to be_invalid
    end

    it "is invalid without a user_id" do
      event = Event.new(name: Faker::Name.name,
                        category: Faker::Space.agency_abv,
                        user_id: create(:user),
                        unique_event_id: nil)

      expect(event).to be_invalid
    end
  end
end
