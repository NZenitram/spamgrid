require 'rails_helper'

describe 'user visits root' do
  scenario 'they can log in' do
    user = stub_omniauth

    visit '/'
    expect(page).to have_content 'Sign in with Google'

    click_link "Sign in"
    expect(page).to have_content("Sign Out")
  end
end
