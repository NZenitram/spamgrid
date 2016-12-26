# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'support/factory_girl'
#
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"


  config.use_transactional_fixtures = false

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({"provider"=>"google_oauth2",
         "uid"=>"111267142973881035060",
         "info"=>
          {"name"=>"Nicholas Martinez",
           "email"=>"nicholasmartinez@gmail.com",
           "first_name"=>"Nicholas",
           "last_name"=>"Martinez",
           "image"=>"https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg",
           "urls"=>{"Google"=>"https://plus.google.com/111267142973881035060"}},
         "credentials"=>{"token"=>ENV['GOOGLE_TOKEN'], "expires_at"=>1481487642, "expires"=>true},
         "extra"=>
          {"id_token"=> ENV['GOOGLE_ID_TOKEN'],
           "raw_info"=>
            {"id"=>"111267142973881035060",
             "email"=>"nicholasmartinez@gmail.com",
             "verified_email"=>true,
             "name"=>"Nicholas Martinez",
             "given_name"=>"Nicholas",
             "family_name"=>"Martinez",
             "link"=>"https://plus.google.com/111267142973881035060",
             "picture"=>"https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg",
             "locale"=>"en"}}})

  end

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end
