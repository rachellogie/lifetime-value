require 'rails_helper'

feature 'reports' do

  before do
    create_user
    sign_in_user
    create_subscribers
  end

  scenario 'Site administrators can see who the current members are' do
    click_on 'Current Members'
    expect(page).to have_content "Miss Kip Torp"
    expect(page).to_not have_content "Gretchen Langosh"
  end

  scenario 'Users can see the lifetime value of each user' do
    click_on 'Lifetime Value'
    expect(page).to have_content "Miss Kip Torp"
    expect(page).to have_content "59.00"
  end
end