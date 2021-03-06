require 'spec_helper'

feature 'Add application to accounts', js: true do
  scenario 'without logging in' do
    visit '/oauth/applications'
    expect(page).to have_content('Sign in with your one OpenStax account!')
  end

  scenario 'as an admin user' do
    create_admin_user
    visit '/login'
    login_as 'admin'
    expect(page).to have_content('Welcome, admin')
    visit '/oauth/applications'
    expect(page).to have_content('OAuth Applications')
    create_new_application(true)
    expect(page).to have_content('Application created.')
    expect(page).to have_content('Application: example')
    expect(page).to have_content('Callback url: http://localhost/')
    expect(page.text).to match(/Application Id: [a-z0-9]+/)
    expect(page.text).to match(/Secret: [a-z0-9]+/)
    expect(page).to have_content('Trusted? Yes')
  end

  scenario 'as a normal local user' do
    create_user 'user'
    visit '/login'
    login_as 'user'
    expect(page).to have_content('Welcome, user')
    visit '/oauth/applications'
    expect(page).to have_content('OAuth Applications')
    create_new_application
    expect(page).to have_content('Application created.')
    expect(page).to have_content('Application: example')
    expect(page).to have_content('Callback url: http://localhost/')
    expect(page.text).to match(/Application Id: [a-z0-9]+/)
    expect(page.text).to match(/Secret: [a-z0-9]+/)
    expect(page).to have_content('Trusted? No')
  end
end
