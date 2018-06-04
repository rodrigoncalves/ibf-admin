require 'rails_helper'

RSpec.feature "Login", type: :feature do

  let(:admin)     { User.create(role: :admin, name: "Admin", email: "admin@example.com", password: '123456') }
  let(:secretary) { User.create(role: :secretary, name: "Secretary", email: "secretary@example.com", password: '123456') }

  it 'displays the name of the app' do
    visit ''
    expect(page).to have_content "Sistema IBF"
  end

  it 'redirect to root page when not logged in' do
    visit '/user'
    expect(page).to have_content "Sistema IBF"
    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end

  it 'sign in as admin' do
    visit ''
    within('#new_user') do
      fill_in I18n.t('login.placeholder.email'), with: admin.email
      fill_in I18n.t('login.placeholder.password'), with: admin.password
    end
    click_button 'Login'
    expect(current_path).to eq rails_admin.dashboard_path
    expect(page).to have_content I18n.t('activerecord.models.user.other')
  end

  it 'sign in as secretary' do
    visit ''
    within('#new_user') do
      fill_in I18n.t('login.placeholder.email'), with: secretary.email
      fill_in I18n.t('login.placeholder.password'), with: secretary.password
    end
    click_button 'Login'
    expect(current_path).to eq rails_admin.dashboard_path
    expect(page).not_to have_content I18n.t('activerecord.models.user.other')
  end

  it 'sign in failed' do
    visit ''
    within('#new_user') do
      fill_in I18n.t('login.placeholder.email'), with: admin.email
      fill_in I18n.t('login.placeholder.password'), with: 'qwerty'
    end
    click_button 'Login'
    expect(page).to have_content I18n.t('devise.failure.invalid',
      authentication_keys: I18n.t('login.placeholder.email'))
  end

end
