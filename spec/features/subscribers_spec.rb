require 'rails_helper'

feature 'subscribers' do

  scenario 'Site administrators can see who the current members are' do
    create_user
    sign_in_user
    create_subscribers
    click_on 'Current Members'
    expect(page).to have_content "Miss Kip Torp"
    expect(page).to_not have_content "Gretchen Langosh"
  end
end