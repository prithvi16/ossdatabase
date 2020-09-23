# frozen_string_literal: true

require "system_helper"

describe "Users" do

  it "Creates a user account and logs in" do
    visit new_user_registration_path
    expect(page).to have_content('Sign up')  
    fill_in 'Email', with: 'ram@example.com'
    fill_in 'Username', with: 'ram'
    fill_in 'Password', with: '222222'
    fill_in 'Password confirmation', with: '222222'
    click_button 'Sign up'
    expect(page).to have_content('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')
    ram_user = User.find_by(email: 'ram@example.com')
    ram_user.confirm
    visit new_user_session_path
    fill_in 'Email', with: 'ram@example.com'
    fill_in 'Password', with: '222222'
    click_button 'Sign In'
    expect(page).to have_content('Signed in successfully.')
    click_button '', {id: "user-menu"}
    click_link 'Account settings'
    fill_in 'Username', with: 'mam'
    fill_in 'Current password', with: '222222'
    click_button 'Update account'
    expect(page).to have_content('Your account has been updated successfully.')
    ram_user.reload
    expect(ram_user.username).to eq('mam')
  end

end
