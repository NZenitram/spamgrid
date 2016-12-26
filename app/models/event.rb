class Event < ApplicationRecord
  validates_presence_of :name, :category, :user_id, :unique_event_id
  validates_uniqueness_of :unique_event_id
end
